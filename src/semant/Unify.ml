module CT = ConstraintTree
module H = Hashtbl
module T = Types

(** [fatal_error loc] invokes Error.pos_fatal_error [loc] *)
let fatal_error loc = Error.pos_fatal_error loc

(** [internal_error msg_fmt] invokes [Error.pos_fatal error_fmt] where
    [error_fmt] is [default_fmt] extended with [msg_fmt] *)
and internal_error msg_fmt =
  let default_fmt = format_of_string "Internal error: during unification, " in
  let error_fmt = default_fmt ^^ msg_fmt in
  Error.fatal error_fmt

(** [error_fmt_strings] string formats for error reporting *)
type error_fmt_strings = {
    type_mismatch: string;
    occur_check: string;
    array_param_num: string;
    array_ref_sym: string;
    array_dim_sym: string;
    func_param_num: string;
    func_dec_body: string;
    func_return: string;
    constr_type: string;
    constr_param_num: string;
    if_cond: string;
    then_eq_else: string;
    while_cond: string;
    match_userdef: string;
    match_pat: string;
}

(** [efs] error string formats implementation *)
let efs = {
  type_mismatch = "This expression has type %s, but expected of type %s";
  occur_check = "Type cicrcularity: %s occurs in %s";
  array_param_num = "Array has %s dims, but referenced with %s";
  array_ref_sym = "Referenced value has type %s, but expected of type %s";
  array_dim_sym = "The second argument in dim call has type %s, but expected of type %s";
  func_param_num = "Function takes %s parameter(s), but applied to %s";
  func_dec_body = "Function body has type %s, but expected of type %s";
  func_return = "Function returns type %s, but expected to return type %s";
  constr_type = "Type Constructor has type %s, but expected of type %s";
  constr_param_num = "Type Constructor takes %s parameter(s), but applied to %s";
  if_cond = "If condition has type %s, but expected of type %s";
  then_eq_else = "Else branch has type %s, but expected of type %s same as then branch";
  while_cond = "While condition has type %s, but expected of type %s";
  match_userdef = "Pattern has type %s, but expected of %s type";
  match_pat = "This pattern matches values of type %s, but expected of type %s"
}

(** [string_fmt str] creates a format from string [str], which contains two substrings *)
let string_fmt str = Scanf.format_from_string str "%s%s"

exception UnifyError of CT.loc * string * T.ty * T.ty
exception ParamNumError of CT.loc * string * int * int

(** [subst_tbl] is the type of Types.ty to Types.ty Hashtbl used for Types.VAR to Types.ty mapping *)
type subst_tbl = (T.ty, T.ty) H.t

(** [subst_tbl] is the hashtable that contains Types.ty -- to be sustituted -- mapping to Types.ty *)
let subst_tbl: subst_tbl = H.create 512

(** [subst_lookup st ty] finds the latest mapping of [ty] in subst_tbl [st] *)
let rec subst_lookup (st: subst_tbl) ty =
  (** [latest_of_var_ty ty] finds the latest ty binding of [var_ty] following the binding chain
      and on return every var_ty (first and intermediate) is updated to the latest binding *)
  let rec latest_of_var_ty var_ty =
    match H.find_opt st var_ty with
    | None -> var_ty
    | Some ty -> latest_of_ty ty

  (** [latest_of_ty ty] finds the latest ty binding of [ty] following the binding chain
      and on return every intermediate ty is updated to the latest binding *)
  and latest_of_ty = function
    | T.UNIT -> T.UNIT
    | T.INT -> T.INT
    | T.CHAR -> T.CHAR
    | T.BOOL -> T.BOOL
    | T.FLOAT -> T.FLOAT
    | (T.REF (ty, u)) -> T.REF ((subst_lookup st ty), u)
    | (T.DYN_REF (ty, u)) -> T.DYN_REF ((subst_lookup st ty), u)
    | (T.ARRAY (0, _) as var_ty) -> subst_lookup st var_ty
    | (T.ARRAY (i, ty)) -> T.ARRAY (i, subst_lookup st ty)
    | (T.FUNC (param_tys, ret_ty)) -> T.FUNC (List.map (subst_lookup st) param_tys, subst_lookup st ret_ty)
    | (T.USERDEF ("user defined", _) as var_ty) -> subst_lookup st var_ty
    | (T.USERDEF sym) -> T.USERDEF sym
    | (T.CONSTR (param_tys, ret_ty, u)) -> T.CONSTR (List.map (subst_lookup st) param_tys, subst_lookup st ret_ty, u)
    | (T.VAR _ as var_ty) -> subst_lookup st var_ty
    | (T.POLY _ as p) -> internal_error "polymorphic %s found in substitution table" (T.ty_to_string p)

  (** [update_var_ty var_ty latest_ty] updates current binding of [var_ty] to [latest_ty] *)
  and update_var_ty var_ty latest_ty =
    match H.find_opt st var_ty with
    | None -> var_ty
    | Some (_ as current_ty) ->
      if current_ty = latest_ty
      then latest_ty
      else (H.replace st var_ty latest_ty; latest_ty)
  in
  match ty with
  | T.VAR _ | T.ARRAY (0, _) | T.USERDEF ("user defined", _) ->
    update_var_ty ty (latest_of_var_ty ty)
  | _ -> latest_of_ty ty

(** [replace_subst st var_ty latest_ty ty] adds or updates in subst_tbl [st] the mappings
    [var_ty] -> [ty] and [latest_ty] -> [ty] *)
let replace_subst (st: subst_tbl) (var_ty: T.ty) (latest_ty: T.ty) (new_ty: T.ty) =
  let replace_var var ty = match var with
    | T.VAR _  | T.ARRAY (0, _) | T.USERDEF ("user defined", _) ->
      H.replace st var ty
    | _ -> ()
  in
  let var_is_in_tbl = var_ty <> latest_ty in
  replace_var var_ty new_ty;
  if var_is_in_tbl
  then replace_var latest_ty new_ty

(** [pprint st] pretty-prints the given subst_tbl [st] *)
let pprint (st: subst_tbl) =
  let print_pair t1 t2 = Printf.printf "%s |-> %s\n" (T.ty_to_string t1) (T.ty_to_string t2) in
  Printf.printf "Substitutions:\n";
  H.iter print_pair st

(** [occurs var ty] checks if Types.VAR [var] is included in type [ty] *)
let rec occurs (var: T.ty) (ty: T.ty) = match var with
  | T.VAR var_sym ->
    begin match ty with
    | T.UNIT | T.INT | T.CHAR | T.BOOL | T.FLOAT -> false
    | T.REF (t, _) | T.DYN_REF (t, _) -> occurs var t
    | T.ARRAY (_, t) -> occurs var t
    | T.FUNC (param_tys, ret_ty) -> List.exists (occurs var) (ret_ty :: param_tys)
    | T.USERDEF _ | T.CONSTR _ -> false
    | T.VAR other_sym -> snd var_sym = snd other_sym
    | T.POLY _ as p -> internal_error "polymorphic %s was not instantiated" (T.ty_to_string p)
    end
  | _ -> false


(** [unify_and_substitute contree] traverses ConstaintTree.contree [contree], solves the constraints
    and returns the resulting [subst_tbl] *)
let unify_and_substitute (contree: CT.contree): subst_tbl =

  (** [handle_exception unify d] handles exception raises by the call [unify d] *)
  let rec handle_exception unify d =
    try unify d with
    | UnifyError (loc, str, t1, t2) ->
      fatal_error loc (string_fmt str) (T.ty_to_string t1) (T.ty_to_string t2)
    | ParamNumError (loc, str, i1, i2) ->
      fatal_error loc (string_fmt str) (string_of_int i1) (string_of_int i2)

  (** [unify_contree st contree] traverses the [contree] and stores results in subst_tbl [st] *)
  and unify_contree st contree =
    let rec traverse = function
      | [] -> final_update st; st
      | d :: ds -> handle_exception unify_def d; traverse ds

    (** [final update st] iterates through subst_tbl [st] and updates all mappings
      to their latest value *)
    and final_update (st: subst_tbl) =
      H.iter (fun var _ -> ignore(subst_lookup st var)) st

    (** [unify_def d] solves constraints for ConstraintTree.def node [d] *)
    and unify_def = function
      | CT.LetDefNonRec { decs } | CT.LetDefRec { decs } ->
      List.iter unify_dec decs

    (** [unify_dec d] solves constraints for ConstraintTree.dec node [d] *)
    and unify_dec = function
      | CT.ConstVarDec { con; name_sym; value } ->
        let value_loc = CT.expr_loc value in
        unify_expr value;
        unify_con con value_loc [] None
      | CT.FunctionDec { con; name_sym; body } ->
        let body_loc = CT.expr_loc body in
        unify_expr body;
        unify_con con body_loc [] (Some efs.func_dec_body)
      | CT.ArrayDec { expr_cons; dims_len_exprs } ->
        let expr_locs = List.map CT.expr_loc dims_len_exprs in
        List.iter unify_expr dims_len_exprs;
        unify_ext_loc expr_cons expr_locs None

    (** [unify_expr e] solves constraints for ConstraintTree.expr node [e] *)
    and unify_expr = function
      | CT.E_Trivial _ -> ()
      | CT.E_ArrayRef { array_cons; expr_cons; name_sym; exprs; loc } ->
        let expr_locs = List.map CT.expr_loc exprs in
        let array_locs = [loc; loc] in
        let array_error_strs_opt = Some [efs.type_mismatch; efs.array_ref_sym] in
        List.iter unify_expr exprs;
        unify_ext_loc expr_cons expr_locs None;
        unify_ext_loc array_cons array_locs array_error_strs_opt
      | CT.E_FuncCall { con; param_exprs; loc } ->
        let param_locs = List.map CT.expr_loc param_exprs in
        List.iter unify_expr param_exprs;
        unify_con con loc param_locs None
      | CT.E_ConstrCall { con; param_exprs; loc } ->
        let param_locs = List.map CT.expr_loc param_exprs in
        List.iter unify_expr param_exprs;
        unify_con con loc param_locs None
      | CT.E_ArrayDim { con; name_sym; loc } ->
        unify_con con loc [] (Some efs.array_dim_sym)
      | CT.E_Delete { con; expr; loc } ->
        let expr_loc = CT.expr_loc expr in
        unify_expr expr;
        unify_con con expr_loc [] None
      | CT.E_LetIn { con; letdef; in_expr; loc } ->
        unify_def letdef;
        unify_expr in_expr;
        unify_con con loc [] None
      | CT.E_BeginEnd { con; expr; loc } ->
        unify_expr expr;
        unify_con con loc [] None
      | CT.E_MatchedIF { cons; if_expr; then_expr; else_expr; loc } ->
        let conlocs = [CT.expr_loc if_expr; CT.expr_loc else_expr; loc] in
        let error_strs_opt = Some [efs.if_cond; efs.then_eq_else; efs.type_mismatch] in
        List.iter unify_expr [if_expr; then_expr; else_expr];
        unify_ext_loc cons conlocs error_strs_opt
      | CT.E_WhileDoDone { cons; while_expr; do_expr; loc } ->
        let conlocs = [CT.expr_loc while_expr; CT.expr_loc do_expr] in
        let error_strs_opt = Some [efs.while_cond; efs.type_mismatch] in
        List.iter unify_expr [while_expr; do_expr];
        unify_ext_loc cons conlocs error_strs_opt
      | CT.E_ForDoDone { cons; start_expr; end_expr; do_expr; loc } ->
        let conlocs = List.map CT.expr_loc [start_expr; end_expr; do_expr] in
        List.iter unify_expr [start_expr; end_expr; do_expr];
        unify_ext_loc cons conlocs None
      | CT.E_MatchWithEnd { userdef_con; pat_cons; expr_cons; match_expr; with_clauses } ->
        let clause_loc_pairs = List.map CT.clause_locs with_clauses in
        let pat_locs = List.map fst clause_loc_pairs in
        let expr_locs = List.map snd clause_loc_pairs in
        let matchloc = CT.expr_loc match_expr in
        let pat_error_strs_opt = Some (List.map (fun _ -> efs.match_pat) pat_cons) in
        unify_expr match_expr;
        List.iter unify_clause with_clauses;
        unify_con userdef_con matchloc [] (Some efs.match_userdef);
        unify_ext_loc pat_cons pat_locs pat_error_strs_opt;
        unify_ext_loc expr_cons expr_locs None

    (** [unify_clause c] solves constraints for ConstraintTree.clause node [c] *)
    and unify_clause = function
      | CT.BasePattClause { expr } ->
        unify_expr expr
      | CT.ConstrPattClause { constr_pattern; expr } ->
        unify_constr_pattern constr_pattern;
        unify_expr expr

    (** [unify_constr_pattern cp] solves constraints for ConstraintTree.constr_pattern node [cp] *)
    and unify_constr_pattern = function
      | CT.CP_BASIC { con; base_patterns; loc } ->
        let bp_locs = List.map CT.base_pattern_loc base_patterns in
        unify_con con loc bp_locs None

    (** [unify_con con loc param_locs error_str_opt] unifies (and substitutes) ConstraintTree.con [con].
        Raises [UnifyError] and [ParamNumError] exceptions using [loc] and [error_str_opt]. [loc] refers
        to constraint and [param_locs] refer to locations of constraint params in case of appearing in [con].
        [error_str_opt] is provided in case of overwriting the default error_str [efs.type_mismatch] *)
    and unify_con con loc param_locs error_str_opt =
      let rec mismatch_error_str = match error_str_opt with
        | None -> efs.type_mismatch
        | Some str -> str

      (** [unify_con_aux con] unifies constraint [con] *)
      and unify_con_aux = function
        | CT.Empty -> ()
        | CT.Unify (t1, t2) ->
          let lt1 = subst_lookup st t1
          and lt2 = subst_lookup st t2 in
          match lt1, lt2 with
          | T.VAR (_, n1), T.VAR (_, n2) ->
            if n1 = n2
            then ()
            else replace_subst st t1 lt1 lt2
          | T.VAR _, _ ->
            if not (occurs lt1 lt2)
            then replace_subst st t1 lt1 lt2
            else raise (UnifyError (loc, efs.occur_check, lt1, lt2))
          | _, T.VAR _ ->
            unify_con_aux (CT.Unify (lt2, lt1))
          | T.REF (e1, _), T.REF (e2, _) | T.DYN_REF (e1, _), T.DYN_REF (e2, _) ->
            unify_con_aux (CT.Unify (e1, e2))
          | T.REF (e1, _), T.DYN_REF (e2, _) | T.DYN_REF (e1, _), T.REF (e2, _) ->
            unify_con_aux (CT.Unify (e1, e2))
          | T.ARRAY (ds1, e1), T.ARRAY(ds2, e2) ->
            begin match ds1, ds2 with
              | 0, 0 -> unify_con_aux (CT.Unify (e1, e2))
              | 0, _ -> replace_subst st t1 lt1 (T.ARRAY (ds2, e1)); unify_con_aux (CT.Unify (e1, e2))
              | _, 0 -> replace_subst st t2 lt2 (T.ARRAY (ds1, e2)); unify_con_aux (CT.Unify (e1, e2))
              | d1, d2 when d1 = d2 -> unify_con_aux (CT.Unify (e1, e2))
              | _, _ -> raise (ParamNumError (loc, efs.array_param_num, ds2, ds1))
            end
          | T.FUNC (ps1, r1), T.FUNC (ps2, r2) ->
            let found_len = List.length ps1 in
            let expected_len = List.length ps2 in
            if found_len = expected_len
            then begin
              unify_params loc param_locs ps1 ps2;
              unify_con (CT.Unify (r1, r2)) loc [] (Some efs.func_return)
            end else
              raise (ParamNumError (loc, efs.func_param_num, expected_len, found_len))
          | T.CONSTR (ps1, r1, _), T.CONSTR (ps2, r2, _) ->
            let found_len = List.length ps1 in
            let expected_len = List.length ps2 in
            if found_len = expected_len
            then begin
              unify_params loc param_locs ps1 ps2;
              unify_con (CT.Unify (r1, r2)) loc [] (Some efs.constr_type)
            end else
              raise (ParamNumError (loc, efs.constr_param_num, expected_len, found_len))
          | T.USERDEF s1, T.USERDEF s2 ->
            begin match s1, s2 with
              | ("user defined", _), ("user defined", _) -> ()
              | ("user defined", _), _ -> replace_subst st t1 lt1 lt2
              | _, ("user defined", _) -> replace_subst st t2 lt2 lt1
              | o1, o2 when o1 = o2 -> ()
              | _, _ -> raise (UnifyError (loc, mismatch_error_str, lt1, lt2))
            end
          | o1, o2 when o1 = o2 -> ()
          | _, _ -> raise (UnifyError (loc, mismatch_error_str, lt1, lt2))

      (** [unify_params loc param_locs found expected] unifies params of two functions or constructors
          in the order [found] params and [expected] params using [unify_con]. [loc] is the function
          or constructor location and [param_locs] the location of params. In case of a parameter being
          a function and an error occurs, then the exception thrown from [unify_con] is caught here and
          a new exception is thrown instead *)
      and unify_params loc param_locs found expected =
        let cons = List.map2 (fun f e -> CT.Unify (f,e)) found expected in
        let conlocs = List.map2 (fun c l -> (c, l)) cons param_locs in
        let aux (con, loc) = match con with
          | CT.Empty -> ()
          | CT.Unify (t1, t2) -> try
            match t1, t2 with
            | T.FUNC (ps1, r1), _ | _, T.FUNC (ps1, r1) ->
              let dummy_locs = List.map (fun _ -> loc) ps1 in
                unify_con con loc dummy_locs None
            | _, _ -> unify_con con loc [] None
            with
            UnifyError _ | ParamNumError _ ->
              let lt1 = subst_lookup st t1
              and lt2 = subst_lookup st t2 in
              raise (UnifyError (loc, efs.type_mismatch, lt1, lt2))
        in
        List.iter aux conlocs


      in
      unify_con_aux con

    (** [unify_ext_loc cons locs error_strs_opt] goven a list of constraints [cons]
        locations [locs] and error_string list option unifies the corresponding
        [con], [loc], [error_str_opt] using [unify_con] *)
    and unify_ext_loc cons locs error_strs_opt =
      match error_strs_opt with
      | None ->
        let aux con loc = unify_con con loc [] None in
        List.iter2 aux cons locs
      | Some strs ->
        let lc_er_pairs = List.map2 (fun l e -> (l, Some e)) locs strs in
        let aux con (loc, error_str_opt) = unify_con con loc [] error_str_opt in
        List.iter2 aux cons lc_er_pairs

    in
    traverse contree

  in
  unify_contree subst_tbl contree
