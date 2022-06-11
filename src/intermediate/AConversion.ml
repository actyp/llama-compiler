module S = Symbol
module TA = TypedAst

(** [name_gens] is a record of name generators based on type
    holding a prefix and a number *)
type name_gens = {
  const_var: string * int ref;
  func: string * int ref;
  param: string * int ref;
  mut_var: string * int ref;
  array: string * int ref;
  for_loop: string * int ref;
  pattern: string * int ref;
}

(** [gen] is an implementation of name generators *)
let gen = {
  const_var = ("cv", ref 0);
  func = ("fn", ref 0);
  param = ("pm", ref 0);
  mut_var = ("mv", ref 0);
  array = ("ar", ref 0);
  for_loop = ("for", ref 0);
  pattern = ("pat", ref 0);
}

(** [senv] is the environment mapping old symbols to new symbols on rename *)
type senv = S.symbol S.symboltable

(** [fresh_name gen name_sym] returns a fresh name based on generator [gen]
    and symbol [name_sym] *)
let fresh_name gen name_sym =
  incr (snd gen);
  fst gen ^ string_of_int !(snd gen) ^ ":" ^ S.name name_sym

(** [fresh_sym gen name_sym] returns a fresh symbol using [fresh_name]
    with generator [gen] and symbol [name_sym] *)
let fresh_sym gen name_sym = S.symbol (fresh_name gen name_sym)

(** [add_name_sym senv name_sym name_sym'] adds to senv environment [senv] the mapping
    [name_sym] -> [name_sym'] *)
let add_name_sym senv name_sym name_sym' = S.enter senv name_sym name_sym'

(** [lookup_sym senv name_sym] returns the name_sym mapping of [name_sym] in [senv]
    If [name_sym] is not in [senv], it is a function from [Environment] that is not renamed,
    but replaced with (name, 0) symbol, in order 0 not to collide with newly A-converted
    symbols *)
let lookup_sym senv name_sym = match S.look senv name_sym with
  | Some s -> s
  | None -> (S.name name_sym, 0)

(** [convert_list_seq f_cnv env ls] applies convert function [f_cnv] sequentially
    to each member of tast nodes in list [ls] starting with initial env [env] and
    returns the final env and the list of renamed typed ast nodes *)
let convert_list_seq f_cnv env ls =
  let rec aux f_cnv env ls acc =
    match ls with
    | [] -> env, List.rev acc
    | l :: rest ->
      let env', tl = f_cnv env l in
      aux f_cnv env' rest (tl::acc)
  in
  aux f_cnv env ls []

let rec convert (tast: TA.tast): TA.tast =
  S.clear_symbols ();
  let _, new_tast = convert_list_seq convert_def S.empty tast in
  new_tast

(** [convert_def senv d] returns the A-converted TypedAst.def from [d] with senv [senv] *)
and convert_def senv = function
  | TA.LetDefNonRec { decs; loc } ->
    let convert_non_rec_dec, augment_senv_after_conv = convert_non_rec_dec_funs in
    let decs' = List.map (convert_non_rec_dec senv) decs in
    let senv' = augment_senv_after_conv senv decs decs' in
    senv', TA.LetDefNonRec { decs = decs'; loc }
  | TA.LetDefRec { recur; decs; loc } ->
    let augment_senv, convert_rec_dec = convert_rec_dec_funs in
    let senv' = List.fold_left augment_senv senv decs in
    let decs' = List.map (convert_rec_dec senv') decs in
    senv', TA.LetDefRec { recur; decs = decs'; loc }
  | TA.TypeDef _ as td ->
    senv, td

(** [convert_non_rec_dec_funs] is a tuple of functions used for non_rec_dec convertion *)
and convert_non_rec_dec_funs =
  let rec convert_non_rec_dec senv = function
    | TA.ConstVarDec { ty; name_sym; value; loc } ->
      let name_sym' = fresh_sym gen.const_var name_sym in
      let value' = convert_expr senv value in
      TA.ConstVarDec { ty; name_sym = name_sym'; value = value'; loc }
    | TA.FunctionDec { ty; name_sym; params; body; loc } ->
      let name_sym' = fresh_sym gen.func name_sym in
      let local_senv, params' = convert_list_seq convert_param senv params in
      let body' = convert_expr local_senv body in
      TA.FunctionDec { ty; name_sym = name_sym'; params = params'; body = body'; loc }
    | TA.MutVarDec { ty; name_sym; loc } ->
      let name_sym' = fresh_sym gen.mut_var name_sym in
      TA.MutVarDec { ty = ty; name_sym = name_sym'; loc }
    | TA.ArrayDec { ty; name_sym; dims_len_exprs; loc } ->
      let name_sym' = fresh_sym gen.array name_sym in
      let exprs' = List.map (convert_expr senv) dims_len_exprs in
      TA.ArrayDec { ty; name_sym = name_sym'; dims_len_exprs = exprs'; loc }

  and name_sym_of_dec = function
    | TA.ConstVarDec { name_sym } | TA.FunctionDec { name_sym }
    | TA.MutVarDec   { name_sym } | TA.ArrayDec    { name_sym } ->
      name_sym

  and augment_senv_after_conv senv old_decs new_decs =
      let old_ns = List.map name_sym_of_dec old_decs in
      let new_ns = List.map name_sym_of_dec new_decs in
      List.fold_left2 add_name_sym senv old_ns new_ns
  in
  convert_non_rec_dec, augment_senv_after_conv

(** [convert_param senv p] returns the A-converted TypedAst.param from [p] with senv [senv] *)
and convert_param senv (TA.Param { ty; name_sym; loc }) =
  let name_sym' = fresh_sym gen.param name_sym in
  let senv' = add_name_sym senv name_sym name_sym' in
  senv', TA.Param { ty; name_sym = name_sym'; loc }

(** [convert_rec_dec_funs] is a tuple of functions used for rec_dec convertion *)
and convert_rec_dec_funs =
  let rec augment_senv senv = function
    | TA.ConstVarDec { name_sym } ->
      let name_sym' = fresh_sym gen.const_var name_sym in
      add_name_sym senv name_sym name_sym'
    | TA.FunctionDec { name_sym } ->
      let name_sym' = fresh_sym gen.func name_sym in
      add_name_sym senv name_sym name_sym'
    | TA.MutVarDec { name_sym } ->
      let name_sym' = fresh_sym gen.mut_var name_sym in
      add_name_sym senv name_sym name_sym'
    | TA.ArrayDec { name_sym } ->
      let name_sym' = fresh_sym gen.array name_sym in
      add_name_sym senv name_sym name_sym'

  and convert_rec_dec senv = function
    | TA.ConstVarDec { ty; name_sym; value; loc } ->
      let name_sym' = lookup_sym senv name_sym in
      let value' = convert_expr senv value in
      TA.ConstVarDec { ty; name_sym = name_sym'; value = value'; loc }
    | TA.FunctionDec { ty; name_sym; params; body; loc } ->
      let name_sym' = lookup_sym senv name_sym in
      let local_senv, params' = convert_list_seq convert_param senv params in
      let body' = convert_expr local_senv body in
      TA.FunctionDec { ty; name_sym = name_sym'; params = params'; body = body'; loc }
    | TA.MutVarDec { ty; name_sym; loc } ->
      let name_sym' = lookup_sym senv name_sym in
      TA.MutVarDec { ty = ty; name_sym = name_sym'; loc }
    | TA.ArrayDec { ty; name_sym; dims_len_exprs; loc } ->
      let name_sym' = lookup_sym senv name_sym in
      let exprs' = List.map (convert_expr senv) dims_len_exprs in
      TA.ArrayDec { ty; name_sym = name_sym'; dims_len_exprs = exprs'; loc }

  in
  augment_senv, convert_rec_dec

(** [convert_expr senv expr] returns the A-converted TypedAst.expr from [d] with senv [senv] *)
and convert_expr senv expr =
  let rec convert_expr_aux = function
    | TA.E_ID  { ty; name_sym; loc } ->
      let name_sym' = lookup_sym senv name_sym in
      TA.E_ID { ty; name_sym = name_sym'; loc }
    | TA.E_Int  _ as e -> e
    | TA.E_Float  _ as e -> e
    | TA.E_Char  _ as e -> e
    | TA.E_String  _ as e -> e
    | TA.E_BOOL _ as e -> e
    | TA.E_Unit  _ as e -> e
    | TA.E_ArrayRef { ty; name_sym; exprs; loc } ->
      let exprs' = List.map convert_expr_aux exprs in
      let name_sym' = lookup_sym senv name_sym in
      TA.E_ArrayRef { ty; name_sym = name_sym'; exprs = exprs'; loc }
    | TA.E_ArrayDim { ty; dim; name_sym; loc } ->
      let name_sym' = lookup_sym senv name_sym in
      TA.E_ArrayDim {ty; dim; name_sym = name_sym'; loc }
    | TA.E_New _ as e -> e
    | TA.E_Delete { ty; expr; loc } ->
      let expr' = convert_expr_aux expr in
      TA.E_Delete { ty; expr = expr'; loc }
    | TA.E_FuncCall { ty; name_sym; param_exprs; loc } ->
      let exprs' = List.map convert_expr_aux param_exprs in
      let name_sym' = lookup_sym senv name_sym in
      TA.E_FuncCall { ty; name_sym = name_sym'; param_exprs = exprs'; loc }
    | TA.E_ConstrCall { ty; name_sym; param_exprs; loc} ->
      let exprs' = List.map convert_expr_aux param_exprs in
      let name_sym' = lookup_sym senv name_sym in
      TA.E_ConstrCall { ty; name_sym = name_sym'; param_exprs = exprs'; loc }
    | TA.E_LetIn { ty; letdef; in_expr; loc } ->
      let senv', letdef' = convert_def senv letdef in
      let expr' = convert_expr senv' in_expr in
      TA.E_LetIn { ty; letdef = letdef'; in_expr = expr'; loc }
    | TA.E_BeginEnd { ty; expr; loc } ->
      let expr' = convert_expr_aux expr in
      TA.E_BeginEnd { ty; expr = expr'; loc }
    | TA.E_MatchedIF { ty; if_expr; then_expr; else_expr; loc } ->
      let if' = convert_expr_aux if_expr in
      let then' = convert_expr_aux then_expr in
      let else' = convert_expr_aux else_expr in
      TA.E_MatchedIF { ty; if_expr = if'; then_expr = then'; else_expr = else'; loc }
    | TA.E_WhileDoDone  { ty; while_expr; do_expr; loc} ->
      let while' = convert_expr_aux while_expr in
      let do' = convert_expr_aux do_expr in
      TA.E_WhileDoDone  { ty; while_expr = while'; do_expr = do'; loc }
    | TA.E_ForDoDone { ty; count_var_sym; start_expr; count_dir; end_expr; do_expr; loc } ->
      let count_var_sym' = fresh_sym gen.for_loop count_var_sym in
      let start' = convert_expr_aux start_expr in
      let end' = convert_expr_aux end_expr in
      let senv' = add_name_sym senv count_var_sym count_var_sym' in
      let do' = convert_expr senv' do_expr in
      TA.E_ForDoDone { ty; count_var_sym = count_var_sym'; start_expr = start'; count_dir; end_expr = end'; do_expr = do'; loc }
    | TA.E_MatchWithEnd { ty; match_expr; with_clauses; loc } ->
      let match' = convert_expr_aux match_expr in
      let with' = List.map convert_clause with_clauses in
      TA.E_MatchWithEnd { ty; match_expr = match'; with_clauses = with'; loc }

  and convert_clause = function
    | TA.BasePattClause { base_pattern; expr; loc } ->
      let senv', base' = convert_base_pattern senv base_pattern in
      let expr' = convert_expr senv' expr in
      TA.BasePattClause { base_pattern = base'; expr = expr'; loc }
    | TA.ConstrPattClause { constr_pattern; expr; loc } ->
      let senv', constr' = convert_constr_pattern senv constr_pattern in
      let expr' = convert_expr senv' expr in
      TA.ConstrPattClause { constr_pattern = constr'; expr = expr'; loc }

  and convert_base_pattern senv = function
    | TA.BP_INT _ as bp -> senv, bp
    | TA.BP_FLOAT _ as bp -> senv, bp
    | TA.BP_CHAR _ as bp -> senv, bp
    | TA.BP_BOOL _ as bp -> senv, bp
    | TA.BP_ID { ty; name_sym; loc } ->
      let name_sym' = fresh_sym gen.pattern name_sym in
      let senv' = add_name_sym senv name_sym name_sym' in
      senv', TA.BP_ID { ty; name_sym = name_sym'; loc }

  and convert_constr_pattern senv (TA.CP_BASIC { ty; constr_sym; base_patterns; loc }) =
    let senv', base_pats' = convert_list_seq convert_base_pattern senv base_patterns in
    senv', TA.CP_BASIC { ty; constr_sym; base_patterns = base_pats'; loc }

  in
  convert_expr_aux expr
