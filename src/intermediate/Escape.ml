module H = Hashtbl
module S = Symbol
module T = Types
module TA = TypedAst

(** [internal_error msg_fmt] invokes [Error.internal error_fmt] where
    [error_fmt] is [default_fmt] extended with [msg_fmt] *)
let internal_error msg_fmt =
  let default_fmt = format_of_string "during escape analysis, " in
  let error_fmt = default_fmt ^^ msg_fmt in
  Error.internal error_fmt

type tbl_entry =
  | TempVarInfo of { dec_depth: int; esc_flag: bool; func_sym: S.symbol }
  | VarInfo of { dec_depth: int; func_sym: S.symbol; esc_offset: int }
  | FuncInfo of { dec_depth: int; esc_list: (S.symbol * T.ty) list }
[@@deriving show]

type info_tbl_t = (int, tbl_entry) H.t

(** [tbl_add tbl name_sym entry] adds/overwrites the mapping int (of [name_sym]) -> [entry]
    in [tbl] *)
let tbl_add (tbl: info_tbl_t) name_sym entry = H.replace tbl (S.num name_sym) entry

(** [tbl_find_opt tbl name_sym] returns the option of looking the key = int (of [name_sym])
    in [tbl] *)
let tbl_find_opt (tbl: info_tbl_t) name_sym = H.find_opt tbl (S.num name_sym)

(** [tbl_remove tbl name_sym] removes the mapping of [tbl] associated with
    int (of [name_sym]) *)
let tbl_remove (tbl: info_tbl_t) name_sym = H.remove tbl (S.num name_sym)

let pprint (tbl: info_tbl_t) =
  let print_pair num entry = Printf.printf "%d |-> %s\n" num (show_tbl_entry entry) in
  Printf.printf "Info table:\n";
  H.iter print_pair tbl

(** [add_temp_var_to_tbl tbl name_sym dec_depth esc_flag func_sym] adds to [tbl] the
    mapping int (of [name_sym]) -> TempVarInfo {[dec_depth]; [esc_flag]; [func_sym]} *)
let add_temp_var_to_tbl (tbl: info_tbl_t) name_sym dec_depth esc_flag func_sym =
  let entry = TempVarInfo { dec_depth; esc_flag; func_sym } in
  tbl_add tbl name_sym entry

(** [add_var_to_tbl tbl name_sym dec_depth func_sym esc_offset] adds to [tbl] the
    mapping int (of [name_sym]) -> VarInfo {[dec_depth]; [func_sym]; [esc_offset]} *)
let add_var_to_tbl (tbl: info_tbl_t) name_sym dec_depth func_sym esc_offset =
  let entry = VarInfo { dec_depth; func_sym; esc_offset } in
  tbl_add tbl name_sym entry

(** [add_fun_to_tbl tbl name_sym dec_depth esc_list] adds to [tbl] the
    mapping int (of [name_sym]) -> FuncInfo {[dec_depth]; [esc_list]} *)
let add_fun_to_tbl (tbl: info_tbl_t) name_sym dec_depth esc_list =
  let entry = FuncInfo { dec_depth; esc_list } in
  tbl_add tbl name_sym entry

(** [add_var_to_func_list tbl func_sym (name_sym, ty)] obtains the [FuncInfo] from [tbl]
    associated to [func_sym] and adds to front of it's [esc_list] the tuple [(name_sym, ty)] *)
let add_var_to_func_list (tbl: info_tbl_t) func_sym (name_sym, ty) =
  let new_var = (name_sym, ty) in
  match tbl_find_opt tbl func_sym with
  | Some (FuncInfo { dec_depth; esc_list }) ->
    add_fun_to_tbl tbl func_sym dec_depth (new_var :: esc_list)
  | _ -> internal_error "symbol with non-FuncInfo binding to add_var_to_func_list"

(** [esc_check_temp_var tbl name_sym use_depth] obtains the [TempVarInfo] from [tbl]
    associated to [name_sym] in order to update it's [esc_flag] to true, unless it is already *)
let esc_check_temp_var (tbl: info_tbl_t) name_sym use_depth =
  match tbl_find_opt tbl name_sym with
  | Some (TempVarInfo { dec_depth; esc_flag = false; func_sym }) ->
    if dec_depth <> use_depth
    then add_temp_var_to_tbl tbl name_sym dec_depth true func_sym
  | _ -> ()

(** [cleanup_func_dec tbl name_sym] used before exiting an analysed function and obtains
    [FuncInfo] from [name_sym] in [tbl] and discards those variables in [esc_list] that
    do not escape both from [esc_list] and from [tbl]; those that escape are kept in
    [esc_list] and converted in [tbl] from [TempVarInfo] to [VarInfo] adjusting their
    [esc_offset] based on the final [esc_list] *)
let cleanup_func_dec (tbl: info_tbl_t) name_sym =
  let rec get_fun_info tbl name_sym =
    match tbl_find_opt tbl name_sym with
    | Some (FuncInfo { dec_depth; esc_list }) -> dec_depth, List.rev esc_list
    | _ -> internal_error "symbol with non-FuncInfo binding to cleanup_func_dec"

  and esc_offset = ref 0

  and keep_var_in_list tbl (name_sym, _) =
    match tbl_find_opt tbl name_sym with
    | None | Some (FuncInfo _) ->
      false
    | Some (VarInfo _) ->
      internal_error "symbol with VarInfo binding to keep_var_in_list"
    | Some (TempVarInfo { esc_flag = false }) ->
      tbl_remove tbl name_sym;
      false
    | Some (TempVarInfo { dec_depth; func_sym }) ->
      add_var_to_tbl tbl name_sym dec_depth func_sym !esc_offset;
      incr esc_offset;
      true

  in
  let dec_depth, esc_list = get_fun_info tbl name_sym in
  esc_list
  |> List.filter (keep_var_in_list tbl)
  |> add_fun_to_tbl tbl name_sym dec_depth

(** [final_tbl_filter _ entry] is the final filter function used as input to
    Hashtable.filter_map_inplace in order to discard every [entry] of [TempVarInfo]
    that does not escape; thus having [esc_flag = false]. So after filtering only
    [VarInfo] and [FuncInfo] are remaining in filtered tbl *)
let final_tbl_filter _ = function
  | TempVarInfo { esc_flag = false } ->
    None
  | TempVarInfo { esc_flag = true; } ->
    internal_error "TempVarInfo with esc_flag = true found during final_tbl_filter"
  | VarInfo _ as v -> Some v
  | FuncInfo _ as v -> Some v

let rec analyse (tast: TA.tast): info_tbl_t =
  let info_tbl: info_tbl_t = H.create 512 in
  let init_depth = 0 and init_func_sym = ("", 0) in
  List.iter (analyse_def init_depth init_func_sym info_tbl) tast;
  H.filter_map_inplace final_tbl_filter info_tbl;
  info_tbl

(** [analyse_def depth func_sym info_tbl d] traverses and analyses TypedAst.def [d] of
    function-depth [depth] in function with symbol [func_sym] in [info_table_t] [info_tbl] *)
and analyse_def depth func_sym info_tbl = function
  | TA.LetDefNonRec { decs } | TA.LetDefRec { decs } ->
    List.iter (analyse_dec depth func_sym info_tbl) decs
  | TypeDef { tdecs } -> ()

(** [analyse_dec depth func_sym info_tbl d] traverses and analyses TypedAst.dec [d] of
    function-depth [depth] in function with symbol [func_sym] in [info_table_t] [info_tbl] *)
and analyse_dec depth func_sym info_tbl = function
  | TA.ConstVarDec { ty; name_sym; value } ->
    analyse_expr depth func_sym info_tbl value;
    if depth <> 0 then begin
    add_temp_var_to_tbl info_tbl name_sym depth false func_sym;
    add_var_to_func_list info_tbl func_sym (name_sym, ty)
    end
  | TA.FunctionDec { name_sym; params; body } ->
    add_fun_to_tbl info_tbl name_sym depth [];
    List.iter (analyse_param (depth + 1) name_sym info_tbl) params;
    analyse_expr (depth + 1) name_sym info_tbl body;
    cleanup_func_dec info_tbl name_sym
  | MutVarDec _ -> ()
  | TA.ArrayDec { dims_len_exprs } ->
    List.iter (analyse_expr depth func_sym info_tbl) dims_len_exprs

(** [analyse_param depth func_sym info_tbl p] traverses and analyses TypedAst.param [p] of
    function-depth [depth] in function with symbol [func_sym] in [info_table_t] [info_tbl] *)
and analyse_param depth func_sym info_tbl = function
  | TA.Param { ty; name_sym } ->
    add_temp_var_to_tbl info_tbl name_sym depth false func_sym;
    add_var_to_func_list info_tbl func_sym (name_sym, ty)

(** [analyse_expr depth func_sym info_tbl expr] traverses and analyses TypedAst.expr [expr] of
    function-depth [depth] in function with symbol [func_sym] in [info_table_t] [info_tbl] *)
and analyse_expr depth func_sym info_tbl expr =
  let rec analyse_expr_aux = function
    | TA.E_ID { name_sym } ->
      esc_check_temp_var info_tbl name_sym depth
    | TA.E_Int _ | TA.E_Float _ | TA.E_Char _ -> ()
    | TA.E_String _ | TA.E_BOOL _ | TA.E_Unit _ -> ()
    | TA.E_ArrayRef _ | TA.E_ArrayDim _ -> ()
    | TA.E_New _ | TA.E_Delete _-> ()
    | TA.E_FuncCall { param_exprs } ->
      List.iter analyse_expr_aux param_exprs
    | TA.E_ConstrCall { param_exprs } ->
      List.iter analyse_expr_aux param_exprs
    | TA.E_LetIn { letdef; in_expr } ->
      analyse_def depth func_sym info_tbl letdef;
      analyse_expr_aux in_expr
    | TA.E_BeginEnd { expr } ->
      analyse_expr_aux expr
    | TA.E_MatchedIF { if_expr; then_expr; else_expr } ->
      List.iter analyse_expr_aux [if_expr; then_expr; else_expr]
    | TA.E_WhileDoDone { while_expr; do_expr } ->
      List.iter analyse_expr_aux [while_expr; do_expr]
    | TA.E_ForDoDone { count_var_sym; start_expr; end_expr; do_expr } ->
      if depth <> 0 then begin
      add_temp_var_to_tbl info_tbl count_var_sym depth false func_sym;
      add_var_to_func_list info_tbl func_sym (count_var_sym, T.INT)
      end;
      List.iter analyse_expr_aux [start_expr; end_expr; do_expr]
    | TA.E_MatchWithEnd { match_expr; with_clauses } ->
      analyse_expr_aux match_expr;
      List.iter analyse_clause with_clauses

  and analyse_clause = function
    | TA.BasePattClause { base_pattern; expr } ->
      analyse_base_pattern base_pattern;
      analyse_expr_aux expr
    | TA.ConstrPattClause { constr_pattern; expr } ->
      analyse_constr_pattern constr_pattern;
      analyse_expr_aux expr

  and analyse_base_pattern = function
    | TA.BP_INT _ | TA.BP_FLOAT _ | TA.BP_CHAR _ | TA.BP_BOOL _ -> ()
    | TA.BP_ID { ty; name_sym } ->
      if depth <> 0 then begin
      add_temp_var_to_tbl info_tbl name_sym depth false func_sym;
      add_var_to_func_list info_tbl func_sym (name_sym, ty)
      end

  and analyse_constr_pattern = function
    | TA.CP_BASIC { base_patterns } ->
      List.iter analyse_base_pattern base_patterns

  in
  analyse_expr_aux expr
