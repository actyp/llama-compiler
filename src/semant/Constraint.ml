module CT = ConstraintTree
module H = Hashtbl
module S = Symbol
module T = Types
module TA = TypedAst

(** [generic_array elem_ty] creates an ARRAY of int 0 and element type [elem_ty]
    It is used for placeholding purposes and awaits substitution in unify *)
let generic_array elem_ty = T.ARRAY (0, elem_ty)

(** [generic_user_type ()] creates a generic user defined type
    It is used for placeholding purposes and awaits substitution in unify *)
and generic_user_type () = T.freshGenericType "user defined"

(** [con_lookup_tbl] is used only to collect previously found constraints,
    so as conloclist to contain no (same or symmetric) duplicates *)
let con_lookup_tbl: (CT.con, unit) H.t = H.create 512

(** [make_con (inferred, expected)] creates a ConstraintTree.con from [inferred] type and [expected] type.
    The convention (inferred, expected) is held for correct error messages *)
let make_con (found, expected) =
  let con = CT.Unify (found, expected) in
  let sym_con = CT.Unify (expected, found) in
  let lookup c = H.find_opt con_lookup_tbl c in
  match lookup con, lookup sym_con with
  | Some _, _ | _, Some _  -> CT.Empty
  | None, None -> H.add con_lookup_tbl con (); con

(** [internal_error loc msg_fmt] invokes [Error.pos_internal_error loc error_fmt] where
    [error_fmt] is [default_fmt] extended with [msg_fmt] *)
let internal_error loc msg_fmt =
  let default_fmt = format_of_string "during constraint generation, " in
  let error_fmt = default_fmt ^^ msg_fmt in
  Error.pos_internal_error loc error_fmt

(** [sym_to_ty loc env sym] returns the Types.ty mapping of [sym] in [env]
    Raises: Error.Terminate using [internal_error] on absent mapping and outputs
    position based on [loc] and a corresponding message *)
let sym_to_ty loc env sym = match S.look env sym with
  | Some t -> t
  | None -> internal_error loc "%s was not in environment" (S.name sym)

(** [augment_venv_dec venv d] augments given [venv] adding the type mapping of dec [d] *)
let augment_venv_dec venv = function
  | TA.ConstVarDec { ty; name_sym } | TA.FunctionDec { ty; name_sym }
  | TA.MutVarDec   { ty; name_sym } | TA.ArrayDec    { ty; name_sym } ->
    S.enter venv name_sym ty

(** [augment_venv_dec venv p] augments given [venv] adding the type mapping of param [p] *)
and augment_venv_param venv (TA.Param { ty; name_sym }) =
    S.enter venv name_sym ty

(** [augment_venv_dec venv p] augments given [venv] adding the type mapping of pattern [p] *)
and augment_venv_base_pattern venv = function
  | TA.BP_INT _ | TA.BP_FLOAT _ | TA.BP_CHAR _ | TA.BP_BOOL _ -> venv
  | TA.BP_ID { ty; name_sym; } -> S.enter venv name_sym ty

let rec collect (env_tast: TA.env_tast): CT.contree =
  let rec aux contree = function
    | [] -> List.rev contree
    | (venv, tenv, def) :: rest -> match def with
      | TA.LetDefNonRec _ | TA.LetDefRec _ ->
        let con = collect_let_def venv tenv def in
        aux (con :: contree) rest
      | TA.TypeDef _ ->
        aux contree rest
  in
  aux [] env_tast

(** [collect_let_def d] returns the ConstraintTree.def from TypedAst.def [d] *)
and collect_let_def venv tenv = function
  | TA.LetDefNonRec { decs } ->
    CT.LetDefNonRec { decs = collect_decs venv tenv decs }
  | TA.LetDefRec { decs } ->
    CT.LetDefRec { decs = collect_decs venv tenv decs }
  | TA.TypeDef { loc } ->
    internal_error loc "collect_let_def applied to TypedAst.TypeDef"

(** [collect_let_def_local_venv venv d] returns the augmented venv from [venv] and the ConstraintTree.def
    from TypedAst.def [d] -- used from let...in expressions *)
and collect_let_def_local_venv venv tenv = function
  | TA.LetDefNonRec { decs } ->
    let condecs = collect_decs venv tenv decs in
    let venv' = List.fold_left augment_venv_dec venv decs in
    venv', CT.LetDefNonRec { decs = condecs }
  | TA.LetDefRec { decs } ->
    let venv' = List.fold_left augment_venv_dec venv decs in
    let condecs = collect_decs venv' tenv decs in
    venv', CT.LetDefRec { decs = condecs }
  | TA.TypeDef { loc } ->
    internal_error loc "collect_let_def applied to TypedAst.TypeDef"

(** [collect_decs venv condecs] returns the ConstraintTree.dec list from
    venv [venv] and TypedAst.dec list [condecs] *)
and collect_decs venv tenv condecs =
  let rec aux acc = function
    | [] -> List.rev acc
    | d :: ds -> match d with
      | TA.ConstVarDec _ | TA.FunctionDec _ | TA.ArrayDec _ ->
        aux ((collect_dec venv tenv d) :: acc) ds
      | TA.MutVarDec _ ->
        aux acc ds
  in
  aux [] condecs

(** [collect_dec venv d] returns the ConstraintTree.dec from venv [venv] and TypedAst.dec [d] *)
and collect_dec venv tenv = function
  | TA.ConstVarDec { ty; name_sym; value } ->
    let convalue = collect_expr venv tenv value in
    let value_ty = TA.expr_ty value in
    let con = make_con (value_ty, ty) in
    CT.ConstVarDec { con = con; name_sym; value = convalue }
  | TA.FunctionDec { ty; name_sym; params; body; loc } ->
    let local_venv = List.fold_left augment_venv_param venv params in
    let conbody = collect_expr local_venv tenv body in
    let ret_ty = match ty with
      | T.FUNC (_, t) -> t
      | _ as errty -> internal_error loc "function %s has type %s" (S.name name_sym) (T.ty_to_string errty) in
    let body_ty = TA.expr_ty body in
    let con = make_con (body_ty, ret_ty) in
    CT.FunctionDec { con = con; name_sym; body = conbody }
  | TA.MutVarDec { loc } ->
    internal_error loc "collect_dec applied to TypedAst.MutVarDec"
  | TA.ArrayDec { dims_len_exprs } ->
    let conexprs = List.map (collect_expr venv tenv) dims_len_exprs in
    let expr_tys = List.map TA.expr_ty dims_len_exprs in
    let expr_cons = List.map (fun ty -> make_con (ty, T.INT)) expr_tys in
    CT.ArrayDec { expr_cons = expr_cons; dims_len_exprs = conexprs }

(** [collect_expr venv e] returns the ConstraintTree.expr from venv [venv] and TypedAst.expr [e].
    [tenv] is obtained from outer [collect] function *)
and collect_expr venv tenv e =
  let rec collect_expr_aux = function
    | TA.E_ID { loc } | TA.E_Int { loc } | TA.E_Float { loc } | TA.E_Char { loc }
    | TA.E_String { loc } | TA.E_BOOL { loc } | TA.E_Unit { loc } | TA.E_New { loc } ->
      CT.E_Trivial loc
    | TA.E_ArrayRef { ty; name_sym; exprs; loc } ->
      let conexprs = List.map collect_expr_aux exprs in
      let expr_tys = List.map TA.expr_ty exprs in
      let dim = List.length exprs in
      let array_ty = sym_to_ty loc venv name_sym in
      let elem_ty = T.freshVar () in
      let array_cons = List.map make_con [(ty, T.REF (elem_ty, ref ())); (T.ARRAY (dim, elem_ty), array_ty)] in
      let expr_cons = List.map (fun ty -> make_con (ty, T.INT)) expr_tys in
      CT.E_ArrayRef { array_cons = array_cons; expr_cons = expr_cons; name_sym; exprs = conexprs; loc }
    | TA.E_ArrayDim { ty; dim; name_sym; loc } ->
      let array_ty = sym_to_ty loc venv name_sym in
      let elem_ty = T.freshVar () in
      let con = make_con (array_ty, generic_array elem_ty) in
      CT.E_ArrayDim { con = con; name_sym; loc }
    | TA.E_Delete { expr; loc } ->
      let conexpr = collect_expr_aux expr in
      let expr_ty = TA.expr_ty expr in
      let ty = T.freshVar() in
      let con = make_con (expr_ty, ty) in
      CT.E_Delete { con = con; expr = conexpr; loc }
    | TA.E_FuncCall { ty; name_sym; param_exprs; loc } ->
      let conexprs = List.map collect_expr_aux param_exprs in
      let param_tys = List.map TA.expr_ty param_exprs in
      let fun_ty = T.instantiate_func_ty (sym_to_ty loc venv name_sym) in
      let con = make_con (T.FUNC (param_tys, ty), fun_ty) in
      CT.E_FuncCall { con = con; param_exprs = conexprs; loc }
    | TA.E_ConstrCall { ty; name_sym; param_exprs; loc } ->
      let conexprs = List.map collect_expr_aux param_exprs in
      let param_tys = List.map TA.expr_ty param_exprs in
      let constr_ty = sym_to_ty loc tenv name_sym in
      let con = make_con (T.CONSTR (param_tys, ty, ref ()), constr_ty) in
      CT.E_ConstrCall { con = con; param_exprs = conexprs; loc }
    | TA.E_LetIn { ty; letdef; in_expr; loc } ->
      let local_venv, conletdef = collect_let_def_local_venv venv tenv letdef in
      let conexpr = collect_expr local_venv tenv in_expr in
      let in_expr_ty = TA.expr_ty in_expr in
      let con = make_con (ty, in_expr_ty) in
      CT.E_LetIn { con = con; letdef = conletdef; in_expr = conexpr; loc }
    | TA.E_BeginEnd { ty; expr; loc } ->
      let conexpr = collect_expr_aux expr in
      let expr_ty = TA.expr_ty expr in
      let con = make_con (ty, expr_ty) in
      CT.E_BeginEnd { con = con; expr = conexpr; loc }
    | TA.E_MatchedIF { ty; if_expr; then_expr; else_expr; loc } ->
      let conif = collect_expr_aux if_expr
      and conthen = collect_expr_aux then_expr
      and conelse = collect_expr_aux else_expr in
      let if_ty = TA.expr_ty if_expr
      and then_ty = TA.expr_ty then_expr
      and else_ty = TA.expr_ty else_expr in
      let cons = List.map make_con [(if_ty, T.BOOL); (else_ty, then_ty); (ty, then_ty)] in
      CT.E_MatchedIF { cons = cons; if_expr = conif; then_expr = conthen; else_expr = conelse; loc }
    | TA.E_WhileDoDone { while_expr; do_expr; loc } ->
      let conwhile = collect_expr_aux while_expr
      and condo = collect_expr_aux do_expr in
      let while_ty = TA.expr_ty while_expr
      and do_ty = TA.expr_ty do_expr in
      let cons = List.map make_con [(while_ty, T.BOOL); (do_ty, T.UNIT)] in
      CT.E_WhileDoDone { cons = cons; while_expr = conwhile; do_expr = condo; loc }
    | TA.E_ForDoDone { start_expr; end_expr; do_expr; loc } ->
      let constart = collect_expr_aux start_expr
      and conend = collect_expr_aux end_expr
      and condo = collect_expr_aux do_expr in
      let start_ty = TA.expr_ty start_expr
      and end_ty = TA.expr_ty end_expr
      and do_ty = TA.expr_ty do_expr in
      let cons = List.map make_con [(start_ty, T.INT); (end_ty, T.INT); (do_ty, T.UNIT)] in
      CT.E_ForDoDone { cons = cons; start_expr =  constart; end_expr = conend; do_expr = condo; loc }
    | TA.E_MatchWithEnd { ty; match_expr; with_clauses; loc } ->
      let conmatch = collect_expr_aux match_expr in
      let conclauses = List.map collect_clause with_clauses in
      let match_ty = TA.expr_ty match_expr in
      let clause_ty_pairs = List.map TA.clause_tys with_clauses in
      let userdef_con, pat_cons, expr_cons = make_match_cons loc ty match_ty clause_ty_pairs in
      CT.E_MatchWithEnd { userdef_con = userdef_con; pat_cons = pat_cons; expr_cons = expr_cons;
                          match_expr = conmatch; with_clauses = conclauses; loc }

  (** [collect_clause c] returns the ConstraintTree.clause from TypedAst.clause [c] *)
  and collect_clause = function
    | TA.BasePattClause { base_pattern; expr } ->
      let local_venv = augment_venv_base_pattern venv base_pattern in
      let conexpr = collect_expr local_venv tenv expr in
      let conbp = collect_base_pattern base_pattern in
      CT.BasePattClause { base_pattern = conbp; expr = conexpr }
    | TA.ConstrPattClause { constr_pattern; expr } ->
      let local_venv, concp = collect_constr_pattern constr_pattern in
      let conexpr = collect_expr local_venv tenv expr in
      CT.ConstrPattClause { constr_pattern = concp; expr = conexpr }

  and collect_base_pattern = function
    | TA.BP_INT   { loc } | TA.BP_FLOAT { loc } | TA.BP_CHAR  { loc }
    | TA.BP_BOOL  { loc } | TA.BP_ID    { loc } ->
      CT.BP_TRIVIAL { loc }

  (** [collect_constr_pattern cp] returns the ConstraintTree.constr_pattern from
      TypedAst.constr_pattern [cp]. [tenv] is obtained from outer [collect] *)
  and collect_constr_pattern (TA.CP_BASIC { ty; constr_sym; base_patterns; loc }) =
    let local_venv = List.fold_left augment_venv_base_pattern venv base_patterns in
    let conbps = List.map collect_base_pattern base_patterns in
    let bp_tys = List.map TA.base_pattern_ty base_patterns in
    let constr_ty = sym_to_ty loc tenv constr_sym in
    let con = make_con (T.CONSTR(bp_tys, ty, ref ()), constr_ty) in
    local_venv, CT.CP_BASIC { con = con; constr_sym; base_patterns = conbps; loc }

  (** [make_match_cons loc ty match_ty clause_tys] returns the constraints generated from whole
      match expression type [ty], type of matched expression [match_ty] and a list of [clause_tys].
      Raises error using [internal_error] based on [loc] *)
  and make_match_cons loc ty match_ty clause_tys =
    let make_inner_cons (p1, e1) pairs =
      let rec aux pcons econs = function
        | [] ->  (List.rev pcons, List.rev econs)
        | (p, e) :: cs -> aux ((make_con (p, p1)) :: pcons) ((make_con (e, e1)) :: econs) cs
      in
      aux [] [] pairs
    in
    match clause_tys with
    | [] -> internal_error loc "match expression with no clauses"
    | (p1, e1) :: pairs  ->
      let pat_cons, expr_cons = make_inner_cons (p1, e1) pairs in
      let userdef_con = make_con (match_ty, generic_user_type ()) in
      let hd_pat_con = make_con (p1, match_ty) in
      let hd_expr_con = make_con (e1, ty) in
      userdef_con, (hd_pat_con :: pat_cons), (hd_expr_con :: expr_cons)

  in
  collect_expr_aux e
