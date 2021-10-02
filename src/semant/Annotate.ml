module A = Ast
module TA = TypedAst
module T = Types
module S = Symbol

(** [venv] is a mapping from value variables to types *)
type venv = T.ty_symboltable

(** [tenv] is a mapping from type variables to types *)
and tenv = T.ty_symboltable

(** [v_error_fmt] format string on unbound value *)
let v_error_fmt = format_of_string "Unbound value %s"

(** [t_error_fmt] format string on unbound type constructor *)
and t_error_fmt = format_of_string "Unbound type constructor %s"

(** [fatal_error loc] invokes Error.pos_fatal_error [loc] *)
let fatal_error loc = Error.pos_fatal_error loc

(** [dim_opt_to_num loc d] returns the number provided from int option [d] in the
    array dim expression. Raises: Error.Terminate using [fatal_error] if the number
    provided is less than 1 *)
let dim_opt_to_num loc = function
  | None -> 1
  | Some 0 -> fatal_error loc "Number in dim expression should be greater than 0"
  | Some num -> num

(** [rev l] reverses list [l] in linear time *)
let rev l =
  let rec aux acc l = match l with
    | [] -> acc
    | h::t -> aux (h::acc) t
  in
  aux [] l

(** [sym_to_ty loc error_fmt env sym] returns the Types.ty mapping of [sym] in [env]
    Raises: Error.Terminate using [fatal_error] on absent mapping and outputs position
    based on [loc] and a corresponding message based on [error_fmt] *)
let sym_to_ty loc error_fmt env sym = match S.look env sym with
  | Some t -> t
  | None -> fatal_error loc error_fmt (S.name sym)

(** [from_ast_type loc tenv ty] returns the Types.ty from Ast._type [ty]
    Raises: Error.Terminate utilizing [sym_to_ty], [tenv] and [loc] to
    check for unbound user-defined type *)
let from_ast_type loc tenv ty = match TA.from_ast_type ty with
  | T.USERDEF ty_sym -> sym_to_ty loc t_error_fmt tenv ty_sym
  | _ as t -> t

(** [ty_opt_to_ty loc tenv ty_opt] converts ast [ty_opt] to typed ast type or returns a fresh var
    Raises: Error.Terminate using [from_ast_type] with [tenv] and [loc] *)
let ty_opt_to_ty loc tenv ty_opt = match ty_opt with
  | None -> T.freshVar ()
  | Some ty -> from_ast_type loc tenv ty

(** [make_fun_ty aparams ret_ty] from TypedAst.Param list [aparams] and return function type [ret_ty]
    returns function type Types.ty [ret_ty] *)
let make_fun_ty aparams ret_ty =
  let ty_from_Param (TA.Param { ty }) = ty in
  let param_tys = List.map ty_from_Param aparams in
  T.FUNC (param_tys, ret_ty)

(** [annotate_list_seq f_an env ls] applies annotation function [f_an] sequentially
    to each member of ast nodes in list [ls] starting with initial env [env] and
    returns the final env and the list of annotated typed ast nodes *)
let annotate_list_seq f_an env ls =
  let rec aux f_an env ls als =
    match ls with
    | [] -> env, rev als
    | l :: rest ->
      let env', al = f_an env l in
      aux f_an env' rest (al::als)
  in
  aux f_an env ls []

(** [annotate venv tenv ast] returns the augmented venv and tenv and the typed ast
    generated from [venv], [tenv] and [ast] *)
let rec annotate (venv: venv) (tenv: tenv) (ast: A.ast): venv * tenv * TA.tast =
  let rec aux venv tenv ast tast = match ast with
    | []        -> venv, tenv, rev tast
    | d :: defs -> match d with
      | A.LetDef _ ->
        let venv', ad = annotate_let_def venv tenv d in
        aux venv' tenv defs (ad::tast)
      | A.TypeDef _ ->
        let tenv', ad = annotate_type_def tenv d in
        aux venv tenv' defs (ad::tast)
  in
  aux venv tenv ast []

(** [annotate_def venv tenv def] returns the typed letdef generated from [tenv] and [def] *)
and annotate_let_def venv tenv = function
  | A.LetDef { recur_opt = None; decs; loc } ->
    let annotate_non_rec_dec, augment_venv_after_ann = annotate_non_rec_dec_funs in
    let adecs = List.map (annotate_non_rec_dec venv tenv) decs in
    let venv' = List.fold_left augment_venv_after_ann venv adecs in
    venv', TA.LetDefNonRec { decs = adecs; loc }
  | A.LetDef { recur_opt = Some recur; decs; loc } ->
    let augment_venv, annotate_rec_dec = annotate_rec_dec_funs in
    let venv' = List.fold_left (augment_venv tenv) venv decs in
    let adecs = List.map (annotate_rec_dec venv' tenv) decs in
    venv', TA.LetDefRec { recur; decs = adecs; loc}
  | A.TypeDef { loc } ->
    fatal_error loc "Internal error: annotate_let_def applied to Ast.TypeDef"

(** [annotate_type_def tenv def] returns the typed typedef generated from [tenv] and [def] *)
and annotate_type_def tenv = function
  | A.TypeDef { tdecs; loc } ->
    let augment_tenv, annotate_tdec = annotate_tdec_funs in
    let tenv_heads = List.fold_left augment_tenv tenv tdecs in
    let tenv', atdecs = annotate_list_seq annotate_tdec tenv_heads tdecs in
    tenv', TA.TypeDef { tdecs = atdecs; loc }
  | A.LetDef { loc } ->
    fatal_error loc "Internal error: annotate_type_def applied to Ast.LetDef"

(** [annotate_tdec_funs] is a tuple containing:
    - [augment_tenv tenv d] for augmenting [tenv] with type of type dec [d]
    - [annotate_tdec tenv d] for returning the typed tdec of [d] in [tenv] *)
and annotate_tdec_funs =
  let augment_tenv tenv (A.TypeDec { name_sym; constrs; loc }) =
    S.enter tenv name_sym (T.USERDEF name_sym)

  and annotate_tdec tenv (A.TypeDec { name_sym; constrs; loc }) =
    let userty = T.USERDEF name_sym in
    let tenv', aconstrs = annotate_list_seq (annotate_constr userty) tenv constrs in
    tenv', TA.TypeDec { name_sym; constrs = aconstrs; loc }
  in
    augment_tenv, annotate_tdec

(** [annotate_constr userty tenv c] returns the typed constr generated from
    T.types [userty], [tenv] and [c] *)
and annotate_constr userty tenv = function
  | A.Constr { name_sym; tys_opt = None; loc } ->
    let ty = T.CONSTR ([], userty, ref ()) in
    let tenv' = S.enter tenv name_sym ty in
    tenv', TA.Constr { ty = ty; name_sym; loc }
  | A.Constr { name_sym; tys_opt = Some t_list; loc } ->
    let tys = List.map (from_ast_type loc tenv) t_list in
    let ty = T.CONSTR (tys, userty, ref ()) in
    let tenv' = S.enter tenv name_sym ty in
    tenv', TA.Constr { ty = ty; name_sym; loc }

(** [annotate_non_rec_dec_funs] is a tuple containing:
    - [annotate_non_rec_dec venv tenv d] for returning the typed tdec of [d] using [venv], [tenv]
    - [augment_venv_after_ann tenv venv td] for augmenting [venv] with type of typed dec [td] *)
and annotate_non_rec_dec_funs =
  let annotate_non_rec_dec venv tenv = function
    | A.ConstVarDec { name_sym; ty_opt; value; loc } ->
      let ty = ty_opt_to_ty loc tenv ty_opt in
      let avalue = annotate_expr venv tenv value in
      TA.ConstVarDec { ty = ty; name_sym; value = avalue; loc }
    | A.FunctionDec { name_sym; params; result_ty_opt; body; loc } ->
      let ret_ty = ty_opt_to_ty loc tenv result_ty_opt in
      let annotate_param_fixed_tenv venv = annotate_param venv tenv in
      let local_venv, aparams = annotate_list_seq annotate_param_fixed_tenv venv params in
      let fun_ty = make_fun_ty aparams ret_ty in
      let abody = annotate_expr local_venv tenv body in
      TA.FunctionDec { ty = fun_ty; name_sym; params = aparams; body = abody; loc }
    | A.MutVarDec { name_sym; ty_opt; loc } ->
      let ty = T.REF (ty_opt_to_ty loc tenv ty_opt, ref ()) in
      TA.MutVarDec { ty = ty; name_sym; loc }
    | A.ArrayDec { name_sym; dims_len_exprs; ty_opt; loc } ->
      let value_ty = ty_opt_to_ty loc tenv ty_opt in
      let dim_num = List.length dims_len_exprs in
      let array_ty = T.ARRAY (dim_num, value_ty) in
      let adims_len_exprs = List.map (annotate_expr venv tenv) dims_len_exprs in
      TA.ArrayDec { ty = array_ty; name_sym; dims_len_exprs = adims_len_exprs; loc }

  and augment_venv_after_ann venv = function
    | TA.ConstVarDec { ty; name_sym } | TA.FunctionDec { ty; name_sym }
    | TA.MutVarDec   { ty; name_sym } | TA.ArrayDec    { ty; name_sym } ->
      S.enter venv name_sym ty
  in
  annotate_non_rec_dec, augment_venv_after_ann

(** [annotate_param venv A.Param {...}] returns the augmented venv' from [venv] and
    the TypedAst.Param from Ast.Param *)
and annotate_param venv tenv (A.Param { name_sym; ty_opt; loc }) =
  let ty = ty_opt_to_ty loc tenv ty_opt in
  let venv' = S.enter venv name_sym ty in
  venv', TA.Param { ty = ty; name_sym; loc }

(** [annotate_rec_dec_funs] is a tuple containing:
    - [augment_venv tenv venv d] for augmenting [venv] with type of type dec [d]
    - [annotate_rec_dec venv tenv d] for returning the typed tdec of [d] using [venv], [tenv] *)
and annotate_rec_dec_funs =
  let rec augment_venv tenv venv = function
    | A.ConstVarDec { name_sym; ty_opt; loc } ->
      let ty = ty_opt_to_ty loc tenv ty_opt in
      S.enter venv name_sym ty
    | A.FunctionDec { name_sym; params; result_ty_opt; loc } ->
      let ret_ty = ty_opt_to_ty loc tenv result_ty_opt in
      let aparam_from_annotate p = snd (annotate_param venv tenv p) in
      let aparams = List.map aparam_from_annotate params in
      let fun_ty = make_fun_ty aparams ret_ty in
      S.enter venv name_sym fun_ty
    | A.MutVarDec { name_sym; ty_opt; loc } ->
      let ty = T.REF (ty_opt_to_ty loc tenv ty_opt, ref ()) in
      S.enter venv name_sym ty
    | A.ArrayDec { name_sym; dims_len_exprs; ty_opt; loc } ->
      let value_ty = ty_opt_to_ty loc tenv ty_opt in
      let dim_num = List.length dims_len_exprs in
      let array_ty = T.ARRAY (dim_num, value_ty) in
      S.enter venv name_sym array_ty

  and annotate_rec_dec venv tenv = function
    | A.ConstVarDec { name_sym; value; loc } ->
      let ty = sym_to_ty loc v_error_fmt venv name_sym in
      let avalue = annotate_expr venv tenv value in
      TA.ConstVarDec { ty = ty; name_sym; value = avalue; loc }
    | A.FunctionDec { name_sym; params; result_ty_opt; body; loc } ->
      let ty = sym_to_ty loc v_error_fmt venv name_sym in
      let local_venv, aparams = annotate_rec_params loc venv ty params in
      let abody = annotate_expr local_venv tenv body in
      TA.FunctionDec { ty = ty; name_sym; params = aparams; body = abody; loc }
    | A.MutVarDec { name_sym; ty_opt; loc } ->
      let ty = sym_to_ty loc v_error_fmt venv name_sym in
      TA.MutVarDec { ty = ty; name_sym; loc }
    | A.ArrayDec { name_sym; dims_len_exprs; ty_opt; loc } ->
      let ty = sym_to_ty loc v_error_fmt venv name_sym in
      let adims_len_exprs = List.map (annotate_expr venv tenv) dims_len_exprs in
      TA.ArrayDec { ty = ty; name_sym; dims_len_exprs = adims_len_exprs; loc }

  and annotate_rec_params loc venv fun_ty params = match fun_ty with
    | T.FUNC (param_tys, _) ->
      let ast_to_tast (A.Param { name_sym; loc }) t = TA.Param { ty = t; name_sym; loc } in
      let aparams = List.map2 ast_to_tast params param_tys in
      let augment_venv venv (TA.Param { ty; name_sym }) = S.enter venv name_sym ty in
      let venv' = List.fold_left augment_venv venv aparams in
      venv', aparams
    | _ -> fatal_error loc "Internal error: annotate_rec_params applied to non function Types.ty"
  in
  augment_venv, annotate_rec_dec

(** [annotate_expr venv tenv expr] returns the typed expr generated from [venv], [tenv] and [expr].
    It contains [annotate_expr_aux] so as not to repeat [venv] and [tenv] parameters,
    [annotate_clause], [annotate_base_pattern] and [annotate_constr_pattern] *)
and annotate_expr venv tenv expr =
  let rec annotate_expr_aux = function
    | A.E_ID  { name_sym; loc } ->
      let ty = sym_to_ty loc v_error_fmt venv name_sym in
      TA.E_ID { ty = ty; name_sym; loc }
    | A.E_Int  { value; loc } ->
      TA.E_Int { ty = T.INT; value; loc }
    | A.E_Float  { value; loc } ->
      TA.E_Float { ty = T.FLOAT; value; loc }
    | A.E_Char  { value; loc } ->
      TA.E_Char { ty = T.CHAR; value; loc }
    | A.E_String  { value; loc } ->
      TA.E_String { ty = T.ARRAY (1, T.CHAR); value; loc }
    | A.E_BOOL { value; loc } ->
      TA.E_BOOL { ty = T.BOOL; value; loc }
    | A.E_Unit  loc ->
      TA.E_Unit { ty = T.UNIT; loc }
    | A.E_ArrayRef { name_sym; exprs; loc } ->
      ignore(sym_to_ty loc v_error_fmt venv name_sym);
      let ty = T.freshVar () in
      let aexprs = List.map annotate_expr_aux exprs in
      TA.E_ArrayRef { ty = ty; name_sym; exprs = aexprs; loc }
    | A.E_FuncCall { name_sym; param_exprs; loc } ->
      ignore(sym_to_ty loc v_error_fmt venv name_sym);
      let ty = T.freshVar () in
      let aexprs = List.map annotate_expr_aux param_exprs in
      TA.E_FuncCall { ty = ty; name_sym; param_exprs = aexprs; loc }
    | A.E_ConstrCall { name_sym; param_exprs; loc} ->
      ignore(sym_to_ty loc t_error_fmt tenv name_sym);
      let ty = T.freshVar () in
      let aexprs = List.map annotate_expr_aux param_exprs in
      TA.E_ConstrCall { ty = ty; name_sym; param_exprs = aexprs; loc }
    | A.E_ArrayDim { dim_opt; name_sym; loc } ->
      ignore(sym_to_ty loc v_error_fmt venv name_sym);
      let dim = dim_opt_to_num loc dim_opt in
      TA.E_ArrayDim {ty = T.INT; dim = dim; name_sym; loc }
    | A.E_New { ty; loc } ->
      TA.E_New { ty = T.DYN_REF (from_ast_type loc tenv ty, ref ()); loc }
    | A.E_Delete { expr; loc } ->
      let aexpr = annotate_expr_aux expr in
      TA.E_Delete { ty = T.UNIT; expr = aexpr; loc }
    | A.E_LetIn { letdef; in_expr; loc } ->
      let ty = T.freshVar () in
      let venv', aletdef = annotate_let_def venv tenv letdef in
      let aexpr = annotate_expr venv' tenv in_expr in
      TA.E_LetIn { ty = ty; letdef = aletdef; in_expr = aexpr; loc }
    | A.E_BeginEnd { expr; loc } ->
      let ty = T.freshVar () in
      let aexpr = annotate_expr_aux expr in
      TA.E_BeginEnd { ty = ty; expr = aexpr; loc }
    | A.E_MatchedIF { if_expr; then_expr; else_expr; loc } ->
      let ty = T.freshVar () in
      let aif = annotate_expr_aux if_expr in
      let athen = annotate_expr_aux then_expr in
      let aelse = annotate_expr_aux else_expr in
      TA.E_MatchedIF { ty = ty; if_expr = aif; then_expr = athen; else_expr = aelse; loc }
    | A.E_WhileDoDone  { while_expr; do_expr; loc} ->
      let awhile = annotate_expr_aux while_expr in
      let ado = annotate_expr_aux do_expr in
      TA.E_WhileDoDone  { ty = T.UNIT; while_expr = awhile; do_expr = ado; loc }
    | A.E_ForDoDone { count_var_sym; start_expr; count_dir; end_expr; do_expr; loc } ->
      let cdir = TA.from_ast_count_dir count_dir in
      let astart = annotate_expr_aux start_expr in
      let aend = annotate_expr_aux end_expr in
      let venv' = S.enter venv count_var_sym T.INT in
      let ado = annotate_expr venv' tenv do_expr in
      TA.E_ForDoDone { ty = T.UNIT; count_var_sym; start_expr = astart; count_dir = cdir; end_expr = aend; do_expr = ado; loc }
    | A.E_MatchWithEnd { match_expr; with_clauses; loc } ->
      let ty = T.freshVar () in
      let amatch = annotate_expr_aux match_expr in
      let awith = List.map annotate_clause with_clauses in
      TA.E_MatchWithEnd { ty = ty; match_expr = amatch; with_clauses = awith; loc }

  (** [annotate_clause c] returns the typed clause from Ast.clause [c] supplied with
      [annotate_expr]'s [venv] and [tenv] *)
  and annotate_clause = function
    | A.BasePattClause { base_pattern; expr; loc } ->
      let venv', abase = annotate_base_pattern venv base_pattern in
      let aexpr = annotate_expr venv' tenv expr in
      TA.BasePattClause { base_pattern = abase; expr = aexpr; loc }
    | A.ConstrPattClause { constr_pattern; expr; loc } ->
      let venv', aconstr = annotate_constr_pattern venv constr_pattern in
      let aexpr = annotate_expr venv' tenv expr in
      TA.ConstrPattClause { constr_pattern = aconstr; expr = aexpr; loc }

  (** [annotate_base_pattern venv p] returns the augmented venv' from [venv] and
      the typed base_pattern from [venv] and [p] *)
  and annotate_base_pattern venv = function
    | A.BP_INT { num; loc } ->
      venv, TA.BP_INT { ty = T.INT; num; loc }
    | A.BP_FLOAT { num; loc} ->
      venv, TA.BP_FLOAT { ty = T.FLOAT; num; loc }
    | A.BP_CHAR { chr; loc } ->
      venv, TA.BP_CHAR { ty = T.CHAR; chr; loc }
    | A.BP_BOOL { value; loc } ->
      venv, TA.BP_BOOL { ty = T.BOOL; value; loc }
    | A.BP_ID { name_sym; loc } ->
      let ty = T.freshVar () in
      let venv' = S.enter venv name_sym ty in
      venv', TA.BP_ID { ty = ty; name_sym; loc }

  (** [annotate_constr_pattern venv p] returns the augmented venv' from [venv] and the typed
      constr_pattern from [venv] and [p]. [tenv] is supplied from [annotate_expr]'s [tenv] *)
  and annotate_constr_pattern venv (A.CP_BASIC { constr_sym; base_patterns; loc }) =
    ignore(sym_to_ty loc t_error_fmt tenv constr_sym);
    let ty = T.freshVar () in
    let venv', abase_pats = annotate_list_seq annotate_base_pattern venv base_patterns in
    venv', TA.CP_BASIC { ty = ty; constr_sym; base_patterns = abase_pats; loc }

  in
  annotate_expr_aux expr