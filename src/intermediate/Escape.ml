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

(** [temp_info] type used in processing hashtbl.
    [TempVarInfo] is converted to [VarInfo] and [TempFuncInfo] to [FuncInfo] *)
type temp_info =
  | TempVarInfo of { dec_depth: int; esc_flag: bool; func_sym: S.symbol; esc_offset: int }
  | TempFuncInfo of { dec_depth: int; esc_list: (S.symbol * T.ty) list }

(** [info] type used in final hashtbl *)
type info =
  | VarInfo of { dec_depth: int; func_sym: S.symbol; esc_offset: int }
  | FuncInfo of { dec_depth: int; esc_list: (S.symbol * T.ty) list }
[@@deriving show]

(** [temp_info_tbl_t] processing hashtbl type *)
type temp_info_tbl_t = (int, temp_info) H.t

(** [info_tbl_t] final hashtbl type *)
type info_tbl_t = (int, info) H.t

(** [tbl_add tbl name_sym entry] adds/overwrites the mapping int (of [name_sym]) -> [entry]
    in hashtbl [tbl] *)
let tbl_add tbl name_sym entry = H.replace tbl (S.num name_sym) entry

(** [tbl_find_opt tbl name_sym] returns the option of looking the key = int (of [name_sym])
    in hashtbl [tbl] *)
let tbl_find_opt tbl name_sym = H.find_opt tbl (S.num name_sym)

(** [tbl_remove tbl name_sym] removes the mapping of hashtbl [tbl] associated with
    int (of [name_sym]) *)
let tbl_remove tbl name_sym = H.remove tbl (S.num name_sym)

let pprint (tbl: info_tbl_t) =
  let print_pair num entry = Printf.printf "%d |-> %s\n" num (show_info entry) in
  Printf.printf "Info table:\n";
  H.iter print_pair tbl

(** [add_temp_var_to_tbl tbl name_sym dec_depth func_sym] adds to [tbl] the mapping int
    (of [name_sym]) -> TempVarInfo {[dec_depth]; esc_flag = false; [func_sym]; esc_offset = 0} *)
let add_temp_var_to_tbl (tbl: temp_info_tbl_t) name_sym dec_depth func_sym =
  let entry = TempVarInfo { dec_depth; esc_flag = false; func_sym; esc_offset = 0 } in
  tbl_add tbl name_sym entry

(** [add_temp_fun_to_tbl tbl name_sym dec_depth esc_list] adds to [tbl] the
    mapping int (of [name_sym]) -> TempFuncInfo {[dec_depth]; [esc_list]} *)
let add_temp_fun_to_tbl (tbl: temp_info_tbl_t) name_sym dec_depth esc_list =
  let entry = TempFuncInfo { dec_depth; esc_list } in
  tbl_add tbl name_sym entry

(** [add_var_to_func_list tbl func_sym (name_sym, ty)] obtains the [TempFuncInfo] from [tbl]
    associated to [func_sym] and adds to front of it's [esc_list] the tuple [(name_sym, ty)] *)
let add_var_to_func_list (tbl: temp_info_tbl_t) func_sym (name_sym, ty) =
  let new_var = (name_sym, ty) in
  match tbl_find_opt tbl func_sym with
  | Some (TempFuncInfo { dec_depth; esc_list }) ->
    add_temp_fun_to_tbl tbl func_sym dec_depth (new_var :: esc_list)
  | Some (TempVarInfo _) -> internal_error "symbol with TempVarInfo binding to add_var_to_func_list"
  | None -> internal_error "unbound symbol in tbl to add_var_to_func_list"

(** [esc_check_temp_var tbl name_sym use_depth] obtains the [TempVarInfo] from [tbl]
    associated to [name_sym] in order to update it's [esc_flag] to true, unless it is already *)
let esc_check_temp_var (tbl: temp_info_tbl_t) name_sym use_depth =
  match tbl_find_opt tbl name_sym with
  | Some (TempVarInfo ({ dec_depth; esc_flag = false } as info)) ->
    if dec_depth <> use_depth
    then tbl_add tbl name_sym (TempVarInfo { info with esc_flag = true })
  | Some (TempVarInfo { esc_flag = true }) -> ()
  | Some (TempFuncInfo _) -> () (* external function not in tbl *)
  | None -> () (* global variable not in tbl *)

(** [cleanup_func_dec tbl name_sym] used before exiting an analysed function and obtains
    [TempFuncInfo] from [name_sym] in [tbl] and discards the non-escaping variables in
    [esc_list] both from [esc_list] and from [tbl]; the escaping are kept in [esc_list]
    and the [esc_offset] of their TempVar bindings is adjusted based on the final [esc_list] *)
let cleanup_func_dec (tbl: temp_info_tbl_t) name_sym =
  let rec get_fun_info tbl name_sym =
    match tbl_find_opt tbl name_sym with
    | Some (TempFuncInfo { dec_depth; esc_list }) -> dec_depth, List.rev esc_list
    | Some (TempVarInfo _) -> internal_error "symbol with TempVarInfo binding to get_fun_info"
    | None -> internal_error "unbound symbol in tbl to get_fun_info"

  and esc_offset = ref 0

  and keep_var_in_list tbl (name_sym, _) =
    match tbl_find_opt tbl name_sym with
    | None | Some (TempFuncInfo _) ->
      false
    | Some (TempVarInfo { esc_flag = false }) ->
      tbl_remove tbl name_sym;
      false
    | Some (TempVarInfo ({ esc_flag = true } as info)) ->
      tbl_add tbl name_sym (TempVarInfo { info with esc_offset = !esc_offset });
      incr esc_offset;
      true

  in
  let dec_depth, esc_list = get_fun_info tbl name_sym in
  esc_list
  |> List.filter (keep_var_in_list tbl)
  |> add_temp_fun_to_tbl tbl name_sym dec_depth

(** [temp_info_tbl_to_info_tbl temp_tbl] creates and returns a new [info_tbl_t] hashtbl
    after converting from [temp_info_tbl_t] temp_tbl each escaping [TempVarInfo]
    to [VarInfo] and [TempFuncInfo] to [FuncInfo]. A non-escaping [TempVar] in
    [temp_tbl] is not converted in the [info_tbl_t] hashtbl. *)
let temp_info_tbl_to_info_tbl (temp_tbl: temp_info_tbl_t): info_tbl_t =
  let rec sym_of_int num = ("", num)

  and fill (tbl: info_tbl_t) num = function
    | TempVarInfo { esc_flag = false } -> ()
    | TempVarInfo { dec_depth; esc_flag = true; func_sym; esc_offset} ->
      tbl_add tbl (sym_of_int num) (VarInfo { dec_depth; func_sym; esc_offset })
    | TempFuncInfo { dec_depth; esc_list } ->
      tbl_add tbl (sym_of_int num) (FuncInfo { dec_depth; esc_list })
  in
  let info_tbl: info_tbl_t = H.create 512 in
  H.iter (fill info_tbl) temp_tbl;
  info_tbl

let rec analyse (tast: TA.tast): info_tbl_t =
  let temp_info_tbl: temp_info_tbl_t = H.create 512 in
  let init_depth = 0 and init_func_sym = ("", 0) in
  List.iter (analyse_def init_depth init_func_sym temp_info_tbl) tast;
  temp_info_tbl_to_info_tbl temp_info_tbl

(** [analyse_def depth func_sym info_tbl d] traverses and analyses TypedAst.def [d] of
    function-depth [depth] in function with symbol [func_sym] in [temp_info_tbl_t] [info_tbl] *)
and analyse_def depth func_sym temp_info_tbl = function
  | TA.LetDefNonRec { decs } | TA.LetDefRec { decs } ->
    List.iter (analyse_dec depth func_sym temp_info_tbl) decs
  | TypeDef { tdecs } -> ()

(** [analyse_dec depth func_sym temp_info_tbl d] traverses and analyses TypedAst.dec [d] of
    function-depth [depth] in function with symbol [func_sym] in [temp_info_tbl_t] [temp_info_tbl] *)
and analyse_dec depth func_sym temp_info_tbl = function
  | TA.ConstVarDec { ty; name_sym; value } ->
    analyse_expr depth func_sym temp_info_tbl value;
    if depth <> 0 then begin
    add_temp_var_to_tbl temp_info_tbl name_sym depth func_sym;
    add_var_to_func_list temp_info_tbl func_sym (name_sym, ty)
    end
  | TA.FunctionDec { name_sym; params; body } ->
    add_temp_fun_to_tbl temp_info_tbl name_sym depth [];
    List.iter (analyse_param (depth + 1) name_sym temp_info_tbl) params;
    analyse_expr (depth + 1) name_sym temp_info_tbl body;
    cleanup_func_dec temp_info_tbl name_sym
  | MutVarDec _ -> ()
  | TA.ArrayDec { dims_len_exprs } ->
    List.iter (analyse_expr depth func_sym temp_info_tbl) dims_len_exprs

(** [analyse_param depth func_sym temp_info_tbl p] traverses and analyses TypedAst.param [p] of
    function-depth [depth] in function with symbol [func_sym] in [temp_info_tbl_t] [temp_info_tbl] *)
and analyse_param depth func_sym temp_info_tbl = function
  | TA.Param { ty; name_sym } ->
    add_temp_var_to_tbl temp_info_tbl name_sym depth func_sym;
    add_var_to_func_list temp_info_tbl func_sym (name_sym, ty)

(** [analyse_expr depth func_sym temp_info_tbl expr] traverses and analyses TypedAst.expr [expr] of
    function-depth [depth] in function with symbol [func_sym] in [temp_info_tbl_t] [temp_info_tbl] *)
and analyse_expr depth func_sym temp_info_tbl expr =
  let rec analyse_expr_aux = function
    | TA.E_ID { name_sym } ->
      esc_check_temp_var temp_info_tbl name_sym depth
    | TA.E_Int _ | TA.E_Float _ | TA.E_Char _ -> ()
    | TA.E_String _ | TA.E_BOOL _ | TA.E_Unit _ -> ()
    | TA.E_ArrayRef _ | TA.E_ArrayDim _ -> ()
    | TA.E_New _ | TA.E_Delete _-> ()
    | TA.E_FuncCall { param_exprs } ->
      List.iter analyse_expr_aux param_exprs
    | TA.E_ConstrCall { param_exprs } ->
      List.iter analyse_expr_aux param_exprs
    | TA.E_LetIn { letdef; in_expr } ->
      analyse_def depth func_sym temp_info_tbl letdef;
      analyse_expr_aux in_expr
    | TA.E_BeginEnd { expr } ->
      analyse_expr_aux expr
    | TA.E_MatchedIF { if_expr; then_expr; else_expr } ->
      List.iter analyse_expr_aux [if_expr; then_expr; else_expr]
    | TA.E_WhileDoDone { while_expr; do_expr } ->
      List.iter analyse_expr_aux [while_expr; do_expr]
    | TA.E_ForDoDone { count_var_sym; start_expr; end_expr; do_expr } ->
      if depth <> 0 then begin
      add_temp_var_to_tbl temp_info_tbl count_var_sym depth func_sym;
      add_var_to_func_list temp_info_tbl func_sym (count_var_sym, T.INT)
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
      add_temp_var_to_tbl temp_info_tbl name_sym depth func_sym;
      add_var_to_func_list temp_info_tbl func_sym (name_sym, ty)
      end

  and analyse_constr_pattern = function
    | TA.CP_BASIC { base_patterns } ->
      List.iter analyse_base_pattern base_patterns

  in
  analyse_expr_aux expr
