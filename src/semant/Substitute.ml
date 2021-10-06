module E = Environment
module H = Hashtbl
module S = Symbol
module T = Types
module TA = TypedAst
module U = Unify

(** [fatal_error loc] invokes Error.pos_fatal_error [loc] *)
let fatal_error loc = Error.pos_fatal_error loc

(** [warning_error loc] invokes Error.pos_warning_error [loc] *)
and warning_error loc = Error.pos_warning_error loc

(** [internal_error loc msg_fmt] invokes [Error.pos_fatal_error loc error_fmt] where
    [error_fmt] is [default_fmt] extended with [msg_fmt] *)
and internal_error loc msg_fmt =
  let default_fmt = format_of_string "Internal error: during substitution, " in
  let error_fmt = default_fmt ^^ msg_fmt in
  Error.pos_fatal_error loc error_fmt

(** [error_fmt_strings] string formats for error reporting *)
type error_fmt_strings = {
  unsubstituted_var: string;
  invalid_type: string;
  func_param: string;
  match_type: string;
  rec_failure: string;
}

(** [efs] error string formats implementation *)
let efs = {
  unsubstituted_var = "Unsubstituted type variable(s) in type: %s";
  invalid_type = "Invalid type: %s";
  func_param = "Invalid parameter type: %s";
  match_type = "Invalid expression type to be matched: %s";
  rec_failure = "Value %s, defined in 'let rec', is not allowed at right-hand side"
}

(** [hint_strings] string formats for hints on error reporting *)
type hint_strings = {
  invalid_type: string;
  delete_type: string;
  match_type: string;
  rec_failure: string;
}

(** [hnts] hint string formats implementation *)
let hnts = {
  invalid_type = "Hint: array type is not allowed in type ref or as array element;\n      \
                        function is not allowed to return a function";
  delete_type = "Hint: in delete expression are allowed only dynamically allocated \
                       references created with new";
  match_type = "Hint: expression to be matched should be of user defined type";
  rec_failure = "Hint: only function bodies are allowed to contain values defined in the \
                       same 'let rec' definition"
}

(** [string_fmt str] creates a format from string [str], which contains one substring *)
let string_fmt str = Scanf.format_from_string str "%s"

(** [lookup st ty loc] finds the binding of Types.VAR [ty] in [st]. If [ty] is not
    Types.VAR then [ty] is returned. In case of missing binding, a warning is produced
    based on [loc] and [var_ty] is returned *)
let lookup (st: U.subst_tbl) (ty: T.ty) loc =
  let rec warn loc str ty =
    warning_error loc (string_fmt str) (T.ty_to_string ty)

  and warn_flag = ref false

  and generic_ty = function
    | T.ARRAY (0, _) | T.USERDEF (("user defined", _), _) -> true
    | _ -> false

  and lookup_aux = function
    | T.UNIT -> T.UNIT
    | T.INT -> T.INT
    | T.CHAR -> T.CHAR
    | T.BOOL -> T.BOOL
    | T.FLOAT -> T.FLOAT
    | T.REF (t, u) -> T.REF ((lookup_aux t), u)
    | T.DYN_REF (t, u) -> T.DYN_REF ((lookup_aux t), u)
    | T.ARRAY (i, t) -> T.ARRAY (i, lookup_aux t)
    | T.FUNC (param_tys, ret_ty) -> T.FUNC (List.map lookup_aux param_tys, lookup_aux ret_ty)
    | T.USERDEF (sym, n) -> T.USERDEF (sym, n)
    | T.CONSTR (param_tys, ret_ty, u) -> T.CONSTR (List.map lookup_aux param_tys, lookup_aux ret_ty, u)
    | T.VAR _ as var_ty ->
      begin match H.find_opt st var_ty with
      | None ->
        warn_flag := true; var_ty
      | Some bind_ty ->
        if generic_ty bind_ty
        then (warn_flag := true; var_ty)
        else lookup_aux bind_ty
      end
    | T.POLY _ as p -> internal_error loc "unsubstituted polymorphic %s found" (T.ty_to_string p)

  in
  let subst_ty = lookup_aux ty in
  if !warn_flag then warn loc efs.unsubstituted_var subst_ty;
  subst_ty

(** [validate ty loc special_pair_opt] checks the validity of Types.ty [ty] and
    on error reports a corresponding message and the location [loc] using [fatal_error].
    [special_pair_opt] is tuple of [validation_function * error_string] to overwrite
    the default of [T.is_valid_type * efs.invalid_type ^ hint_str] *)
let rec validate ty loc special_pair_opt =
  let check val_f ty loc str =
    if not (val_f ty)
    then fatal_error loc (string_fmt str) (T.ty_to_string ty)
  in
  match special_pair_opt with
    | None -> check T.is_valid_type ty loc (efs.invalid_type ^ "\n" ^ hnts.invalid_type)
    | Some (val_f, error_str) -> check val_f ty loc error_str

(** [validate_func_ty name_sym ty loc] checks the validity of function with Symbol.symbol
    [name_sym] and Types.ty [ty] found in location [loc] using [validate] *)
and validate_func_ty name_sym param_ty loc =
  let binary_func_val = E.is_valid_binary name_sym in
  let additional_info = " for function " ^ (S.name name_sym) ^ "\n" ^ (E.hint_str name_sym) in
  let error_str = efs.func_param ^ additional_info in
  validate param_ty loc (Some (binary_func_val, error_str))

(** [validate_delete_expr expr_ty loc] checks the validity of delete expression so as
    [expr_ty] to be Types.DYN_REF and reports error based on [loc] using [fatal_error] *)
and validate_delete_expr expr_ty loc =
  let error_str = efs.invalid_type ^ "\n" ^ hnts.delete_type in
  match expr_ty with
  | T.DYN_REF _ -> ()
  | _ -> fatal_error loc (string_fmt error_str) (T.ty_to_string expr_ty)

(** [validate_match_expr match_ty loc] checks the validity of match expression so as
    [match_ty] to be Types.USERDEF and reports error based on [loc] using [fatal_error] *)
and validate_match_expr match_ty loc =
  let error_str = efs.match_type ^ "\n" ^ hnts.match_type in
  match match_ty with
  | T.USERDEF _ -> ()
  | _ -> fatal_error loc (string_fmt error_str) (T.ty_to_string match_ty)

(** [validate_after_lookup st ty loc] looks up Types.ty [ty] in subst_tbl [st],
    validates the substituted ty using [validate] and returns the substituted ty *)
and validate_after_lookup st ty loc =
  let ty' = lookup st ty loc in
  validate ty' loc None;
  ty'

(** [rec_error_check decs] traversing recursive TypedAst.dec list [decs], checks for
    rec failure error on and uses [fatal_error] on error *)
let rec_error_check decs =
  let rec rvenv_add rvenv sym = S.enter rvenv sym ()

  and rvenv_mem rvenv sym = S.mem rvenv sym

  and rvenv_rmv rvenv sym = S.remove rvenv sym

  and check_sym rvenv sym loc =
    if rvenv_mem rvenv sym
    then
      let error_str = efs.rec_failure ^ "\n" ^ hnts.rec_failure in
      fatal_error loc (string_fmt error_str) (S.name sym)

  and dec_to_rvenv f_rvenv rvenv = function
    | TA.ConstVarDec { name_sym } | TA.FunctionDec { name_sym }
    | TA.MutVarDec   { name_sym } | TA.ArrayDec    { name_sym } ->
      f_rvenv rvenv name_sym

  and check_def_local_rvenv rvenv = function
    | TA.LetDefNonRec _ | TA.TypeDef _ -> rvenv
    | TA.LetDefRec { decs } ->
      let local_rvenv = List.fold_left (dec_to_rvenv rvenv_rmv) rvenv decs in
      List.iter (check_dec local_rvenv) decs;
      local_rvenv

  and check_dec rvenv = function
    | TA.ConstVarDec { value } -> check_expr rvenv value
    | TA.FunctionDec _ | TA.MutVarDec _ | TA.ArrayDec _ -> ()

  and check_expr rvenv expr =
    let rec check_expr_aux = function
      | TA.E_ID { name_sym; loc } ->
        check_sym rvenv name_sym loc
      | TA.E_Int _  | TA.E_Float _  -> ()
      | TA.E_Char _ | TA.E_String _ -> ()
      | TA.E_BOOL _ | TA.E_Unit _   -> ()
      | TA.E_ArrayRef { name_sym; exprs; loc } ->
        check_sym rvenv name_sym loc;
        List.iter check_expr_aux exprs
      | TA.E_ArrayDim { name_sym; loc } ->
        check_sym rvenv name_sym loc
      | TA.E_New _ -> ()
      | TA.E_Delete { expr } ->
        check_expr_aux expr
      | TA.E_FuncCall { name_sym; param_exprs; loc } ->
        check_sym rvenv name_sym loc;
        List.iter check_expr_aux param_exprs
      | TA.E_ConstrCall { param_exprs } ->
        List.iter check_expr_aux param_exprs
      | TA.E_LetIn { letdef; in_expr } ->
        let local_rvenv = check_def_local_rvenv rvenv letdef in
        check_expr local_rvenv in_expr
      | TA.E_BeginEnd { expr } ->
        check_expr_aux expr
      | TA.E_MatchedIF { if_expr; then_expr; else_expr } ->
        List.iter check_expr_aux [if_expr; then_expr; else_expr]
      | TA.E_WhileDoDone { while_expr; do_expr } ->
        List.iter check_expr_aux [while_expr; do_expr]
      | TA.E_ForDoDone { start_expr; end_expr; do_expr } ->
        List.iter check_expr_aux [start_expr; end_expr; do_expr]
      | TA.E_MatchWithEnd { match_expr; with_clauses } ->
        check_expr_aux match_expr;
        List.iter check_clause with_clauses

    and check_clause = function
      | TA.BasePattClause { base_pattern; expr } ->
        let local_rvenv = base_pattern_local_rvenv rvenv base_pattern in
        check_expr local_rvenv expr
      | TA.ConstrPattClause { constr_pattern; expr } ->
        let local_rvenv = constr_pattern_local_rvenv rvenv constr_pattern in
        check_expr local_rvenv expr

    and base_pattern_local_rvenv rvenv = function
      | TA.BP_INT _ | TA.BP_FLOAT _ | TA.BP_CHAR _ | TA.BP_BOOL _ -> rvenv
      | TA.BP_ID { name_sym } -> rvenv_rmv rvenv name_sym

    and constr_pattern_local_rvenv rvenv = function
      | TA.CP_BASIC { base_patterns } ->
        List.fold_left base_pattern_local_rvenv rvenv base_patterns

    in
    check_expr_aux expr

  in
  let empty_rvenv: unit S.symboltable = S.empty in
  let rec_venv = List.fold_left (dec_to_rvenv rvenv_add) empty_rvenv decs in
  List.iter (check_dec rec_venv) decs

(** [substitute_and_typecheck tast st] given the annotated_ast [tast] and the subst_tbl [st]
    traverses the tree and substitutes and typechecks -- when needed-- the type variables
    returning the final typed ast *)
let substitute_and_typecheck (tast: TA.tast) (st: U.subst_tbl): TA.tast =

  (** [traverse_def d] returns the substituted TypedAst.def from TypedAst.def [d] *)
  let rec traverse_def = function
    | TA.LetDefNonRec { decs; loc } ->
      let decs' = List.map traverse_dec decs in
      TA.LetDefNonRec { decs = decs'; loc }
    | TA.LetDefRec { recur; decs; loc } ->
      let decs' = List.map traverse_dec decs in
      rec_error_check decs;
      TA.LetDefRec { recur; decs = decs'; loc }
    | TA.TypeDef _ as tdef ->
      tdef

  (** [traverse_dec d] returns the substituted TypedAst.dec from TypedAst.dec [d] *)
  and traverse_dec = function
    | TA.ConstVarDec { ty; name_sym; value; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let value' = traverse_expr value in
      TA.ConstVarDec { ty = ty'; name_sym; value = value'; loc }
    | TA.FunctionDec { ty; name_sym; params; body; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let params' = List.map traverse_param params in
      let body' = traverse_expr body in
      TA.FunctionDec { ty = ty'; name_sym; params = params'; body = body'; loc }
    | MutVarDec { ty; name_sym; loc } ->
      let ty' = validate_after_lookup st ty loc in
      MutVarDec { ty = ty'; name_sym; loc }
    | TA.ArrayDec { ty; name_sym; dims_len_exprs; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let exprs' = List.map traverse_expr dims_len_exprs in
      TA.ArrayDec { ty = ty'; name_sym; dims_len_exprs = exprs'; loc }

  (** [traverse_param p] returns the substituted TypedAst.param from TypedAst.param [p] *)
  and traverse_param = function
    | TA.Param { ty; name_sym; loc } ->
      let ty' = validate_after_lookup st ty loc in
      TA.Param { ty = ty'; name_sym; loc }

  (** [traverse_expr e] returns the substituted TypedAst.expr from TypedAst.expr [e] *)
  and traverse_expr = function
    | TA.E_ID { ty; name_sym; loc } ->
      let ty' = validate_after_lookup st ty loc in
      TA.E_ID { ty = ty'; name_sym; loc }
    | TA.E_Int _ as e -> e
    | TA.E_Float _ as e -> e
    | TA.E_Char _ as e -> e
    | TA.E_String _ as e -> e
    | TA.E_BOOL _ as e -> e
    | TA.E_Unit _ as e -> e
    | TA.E_ArrayRef { ty; name_sym; exprs; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let exprs' = List.map traverse_expr exprs in
      TA.E_ArrayRef { ty = ty'; name_sym; exprs = exprs'; loc }
    | TA.E_ArrayDim _ as e -> e
    | TA.E_New _ as e -> e
    | TA.E_Delete { ty; expr; loc } ->
      let expr' = traverse_expr expr in
      validate_delete_expr (TA.expr_ty expr') loc;
      TA.E_Delete { ty; expr = expr'; loc }
    | TA.E_FuncCall { ty; name_sym; param_exprs; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let exprs' = List.map traverse_expr param_exprs in
      let param_ty = TA.expr_ty (List.hd exprs') in
      validate_func_ty name_sym param_ty loc;
      TA.E_FuncCall { ty = ty'; name_sym; param_exprs = exprs'; loc }
    | TA.E_ConstrCall { ty; name_sym; param_exprs; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let exprs' = List.map traverse_expr param_exprs in
      TA.E_ConstrCall { ty = ty'; name_sym; param_exprs = exprs'; loc }
    | TA.E_LetIn { ty; letdef; in_expr; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let ldef' = traverse_def letdef in
      let expr' = traverse_expr in_expr in
      TA.E_LetIn { ty = ty'; letdef = ldef'; in_expr = expr'; loc }
    | TA.E_BeginEnd { ty; expr; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let expr' = traverse_expr expr in
      TA.E_BeginEnd { ty = ty'; expr = expr'; loc }
    | TA.E_MatchedIF { ty; if_expr; then_expr; else_expr; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let if' = traverse_expr if_expr in
      let then' = traverse_expr then_expr in
      let else' = traverse_expr else_expr in
      TA.E_MatchedIF { ty = ty'; if_expr = if'; then_expr = then'; else_expr = else'; loc }
    | TA.E_WhileDoDone { ty; while_expr; do_expr; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let while' = traverse_expr while_expr in
      let do' = traverse_expr do_expr in
      TA.E_WhileDoDone { ty = ty'; while_expr = while'; do_expr = do'; loc }
    | TA.E_ForDoDone { ty; count_var_sym; start_expr; count_dir; end_expr; do_expr; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let start' = traverse_expr start_expr in
      let end' = traverse_expr end_expr in
      let do' = traverse_expr do_expr in
      TA.E_ForDoDone { ty = ty'; count_var_sym; start_expr = start'; count_dir; end_expr = end'; do_expr = do'; loc }
    | TA.E_MatchWithEnd { ty; match_expr; with_clauses; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let match' = traverse_expr match_expr in
      validate_match_expr (TA.expr_ty match') loc;
      let clauses' = List.map traverse_clause with_clauses in
      TA.E_MatchWithEnd { ty = ty'; match_expr = match'; with_clauses = clauses'; loc }

  (** [traverse_clause c] returns the substituted TypedAst.clause from TypedAst.clause [c] *)
  and traverse_clause = function
    | TA.BasePattClause { base_pattern; expr; loc } ->
      let bp' = traverse_base_pattern base_pattern in
      let expr' = traverse_expr expr in
      TA.BasePattClause { base_pattern = bp'; expr = expr'; loc }
    | TA.ConstrPattClause { constr_pattern; expr; loc } ->
      let cp' = traverse_constr_pattern constr_pattern in
      let expr' = traverse_expr expr in
      TA.ConstrPattClause { constr_pattern = cp'; expr = expr'; loc }

  (** [traverse_base_pattern bp] returns the substituted TypedAst.base_pattern from
      TypedAst.base_pattern [bp] *)
  and traverse_base_pattern = function
    | TA.BP_INT _ as bp -> bp
    | TA.BP_FLOAT _ as bp -> bp
    | TA.BP_CHAR _ as bp -> bp
    | TA.BP_BOOL _ as bp -> bp
    | TA.BP_ID { ty; name_sym; loc } ->
      let ty' = validate_after_lookup st ty loc in
      TA.BP_ID { ty = ty'; name_sym; loc }

  (** [traverse_constr_pattern cp] returns the substituted TypedAst.constr_pattern from
      TypedAst.constr_pattern [cp] *)
  and traverse_constr_pattern = function
    | TA.CP_BASIC { ty; constr_sym; base_patterns; loc } ->
      let ty' = validate_after_lookup st ty loc in
      let bps' = List.map traverse_base_pattern base_patterns in
      TA.CP_BASIC { ty = ty'; constr_sym; base_patterns = bps'; loc }

  in
  List.map traverse_def tast
