module F = Format
module H = Hashtbl
module L = Llvm
module S = Symbol
module T = Types
module TA = TypedAst

(** [internal_error msg_fmt] invokes [Error.internal error_fmt] where
    [error_fmt] is [default_fmt] extended with [msg_fmt] *)
let internal_error msg_fmt =
  let default_fmt = format_of_string "during escape analysis, " in
  let error_fmt = default_fmt ^^ msg_fmt in
  Error.internal error_fmt

(** [pp_llvalue_opt ppf llvalue_opt] returns unit and provides the ppx_deriving printer
    for llvalue option [llvalue_opt] formatting the output with F.formatter [ppf] *)
let pp_llvalue_opt ppf = function
  | None -> F.fprintf ppf "None"
  | Some (llvalue: L.llvalue) -> F.fprintf ppf "Some (%s)" (L.string_of_llvalue llvalue)

(** [info] type used in final hashtbl *)
type info =
  | LocalVarInfo of { name_sym: S.symbol; ty: T.ty; dec_depth: int; func_sym: S.symbol; llvalue_opt: L.llvalue option [@printer pp_llvalue_opt] } 
  | EscVarInfo of { name_sym: S.symbol; ty: T.ty; dec_depth: int; func_sym: S.symbol; frame_offset: int }
  | FuncInfo of { name_sym: S.symbol; ty: T.ty; dec_depth: int; local_list: (S.symbol * T.ty) list; esc_list: (S.symbol * T.ty) list }
[@@deriving show]

(** [info_tbl_t] final hashtbl type *)
type info_tbl_t = (int, info) H.t

(** [tbl_add tbl name_sym entry] adds/overwrites the mapping int (of [name_sym]) -> [entry]
    in hashtbl [tbl] *)
let tbl_add (tbl: info_tbl_t) name_sym entry = H.replace tbl (S.num name_sym) entry

(* implementation is more general from interface *)
let tbl_find_opt (tbl: info_tbl_t) name_sym = H.find_opt tbl (S.num name_sym)

(** [tbl_remove tbl name_sym] removes the mapping of hashtbl [tbl] associated with
    int (of [name_sym]) *)
let tbl_remove (tbl: info_tbl_t) name_sym = H.remove tbl (S.num name_sym)

let pprint (tbl: info_tbl_t) =
  let print_pair num entry = Printf.printf "%d |-> %s\n" num (show_info entry) in
  Printf.printf "Info table:\n";
  if H.length tbl = 0 
    then Printf.printf "<Empty>\n" 
    else H.iter print_pair tbl

(** [add_local_var_to_tbl tbl name_sym ty dec_depth func_sym] adds to [tbl] the mapping int (of [name_sym])
    -> LocalVarInfo { [name_sym]; [ty]; [dec_depth]; [func_sym]; llvalue_opt = None } *)
let add_local_var_to_tbl (tbl: info_tbl_t) name_sym ty dec_depth func_sym =
  let entry = LocalVarInfo { name_sym; ty; dec_depth; func_sym; llvalue_opt = None } in
  tbl_add tbl name_sym entry

(** [add_fun_to_tbl tbl name_sym ty dec_depth local_list esc_list] adds to [tbl] the mapping int (of [name_sym])
    -> FuncInfo { [name_sym]; [ty]; [dec_depth]; [local_list]; [esc_list] } *)
let add_fun_to_tbl (tbl: info_tbl_t) name_sym ty dec_depth local_list esc_list =
  let entry = FuncInfo { name_sym; ty; dec_depth; local_list; esc_list } in
  tbl_add tbl name_sym entry

(** [add_var_to_func_list tbl func_sym (name_sym, ty)] obtains the [FuncInfo] from [tbl]
    associated to [func_sym] and adds to front of it's [local_list] the tuple [(name_sym, ty)] *)
let add_var_to_func_list (tbl: info_tbl_t) func_sym (name_sym, ty) =
  let new_var = (name_sym, ty) in
  match tbl_find_opt tbl func_sym with
  | Some FuncInfo ({ local_list } as info) ->
    tbl_add tbl func_sym (FuncInfo { info with local_list = (new_var :: local_list) })
  | Some LocalVarInfo _ ->
    internal_error "symbol %s with LocalVarInfo binding in add_var_to_func_list" (S.name name_sym)
  | Some EscVarInfo _ ->
    internal_error "symbol %s with EscVarInfo binding in add_var_to_func_list" (S.name name_sym)
  | None ->
    internal_error "unbound symbol %s in tbl in add_var_to_func_list" (S.name name_sym)

(** [esc_var_of_local tbl name_sym use_depth] obtains the [LocalVarInfo] from [tbl]
    associated to [name_sym] in order to update it to [EscVarInfo] *)
let esc_var_of_local (tbl: info_tbl_t) name_sym use_depth =
  match tbl_find_opt tbl name_sym with
  | Some LocalVarInfo { name_sym; ty; dec_depth; func_sym } ->
    if dec_depth <> use_depth
    then tbl_add tbl name_sym (EscVarInfo { name_sym; ty; dec_depth; func_sym; frame_offset = 0 })
  | Some EscVarInfo _ -> ()
  | Some FuncInfo _ -> () (* external function not in tbl *)
  | None -> () (* variable not in tbl *)

(** [cleanup_func_dec tbl name_sym] used before exiting an analysed function and obtains
    [FuncInfo] from [name_sym] in [tbl] and moves the escaping variables from
    [local_list] to [esc_list]; the escaping variables have their [frame_offset]
    adjusted based on the final [esc_list] *)
let cleanup_func_dec (tbl: info_tbl_t) name_sym =
  let rec get_fun_info tbl name_sym =
    match tbl_find_opt tbl name_sym with
    | Some FuncInfo { ty; dec_depth; local_list } -> ty, dec_depth, List.rev local_list
    | Some LocalVarInfo _ -> internal_error "symbol %s with LocalVarInfo binding in get_fun_info" (S.name name_sym)
    | Some EscVarInfo _ -> internal_error "symbol %s with EscVarInfo binding in get_fun_info" (S.name name_sym)
    | None -> internal_error "unbound symbol %s in tbl to get_fun_info" (S.name name_sym)

  and frame_offset = ref 0

  and keep_var_in_local_list tbl (name_sym, _) =
    match tbl_find_opt tbl name_sym with
    | None | Some FuncInfo _ ->
      internal_error "symbol %s with None/FuncInfo binding in keep_var_in_local_list" (S.name name_sym)
    | Some LocalVarInfo _ ->
      true
    | Some EscVarInfo (_ as info) ->
      tbl_add tbl name_sym (EscVarInfo { info with frame_offset = !frame_offset });
      incr frame_offset;
      false

  in
  let ty, dec_depth, prev_local_list = get_fun_info tbl name_sym in
  let local_list, esc_list = List.partition (keep_var_in_local_list tbl) prev_local_list in
  add_fun_to_tbl tbl name_sym ty dec_depth local_list esc_list

let rec analyse (tast: TA.tast): info_tbl_t =
  let info_tbl: info_tbl_t = H.create 512 in
  let init_depth = 0 and init_func_sym = ("entry_func", 0) and init_func_ty = T.FUNC ([], T.INT) in
  (* create a single outer wrapper function 'entry_func', so that
     global variables can be escaping variables of 'entry_func' *)
  add_fun_to_tbl info_tbl init_func_sym init_func_ty init_depth [] [];
  List.iter (analyse_def (init_depth + 1) init_func_sym info_tbl) tast;
  cleanup_func_dec info_tbl init_func_sym;
  info_tbl

(** [analyse_def depth func_sym info_tbl d] traverses and analyses TypedAst.def [d] of
    function-depth [depth] in function with symbol [func_sym] in [info_tbl_t] [info_tbl] *)
and analyse_def depth func_sym info_tbl = function
  | TA.LetDefNonRec { decs } ->
    List.iter (analyse_non_rec_dec depth func_sym info_tbl) decs
  | TA.LetDefRec { decs } ->
    let analyse_dec_headers, analyse_dec_bodies = analyse_rec_dec_funs depth func_sym info_tbl in
    List.iter analyse_dec_headers decs;
    List.iter analyse_dec_bodies decs
  | TypeDef { tdecs } ->
    ()

(** [analyse_non_rec_dec depth func_sym info_tbl d] traverses and analyses TypedAst.dec [d] of
    function-depth [depth] in function with symbol [func_sym] in [info_tbl_t] [info_tbl] *)
and analyse_non_rec_dec depth func_sym info_tbl = function
  | TA.ConstVarDec { ty; name_sym; value } ->
    if depth <> 0 then begin
      add_local_var_to_tbl info_tbl name_sym ty depth func_sym;
      add_var_to_func_list info_tbl func_sym (name_sym, ty)
    end;
    analyse_expr depth func_sym info_tbl value
  | TA.FunctionDec { ty; name_sym; params; body } ->
    add_fun_to_tbl info_tbl name_sym ty depth [] [];
    List.iter (analyse_param (depth + 1) name_sym info_tbl) params;
    analyse_expr (depth + 1) name_sym info_tbl body;
    cleanup_func_dec info_tbl name_sym
  | TA.MutVarDec { ty; name_sym } ->
    if depth <> 0 then begin
      add_local_var_to_tbl info_tbl name_sym ty depth func_sym;
      add_var_to_func_list info_tbl func_sym (name_sym, ty)
    end
  | TA.ArrayDec { ty; name_sym; dims_len_exprs } ->
    if depth <> 0 then begin
      add_local_var_to_tbl info_tbl name_sym ty depth func_sym;
      add_var_to_func_list info_tbl func_sym (name_sym, ty)
    end;
    List.iter (analyse_expr depth func_sym info_tbl) dims_len_exprs;

(** [analyse_rec_dec_funs depth func_sym info_tbl] provides the functions needed, in order
    to traverse recursive decs. First traverse only their headers and add them to [info_tbl]
    and then their bodies. In short the [analyse_non_rec_dec] function is split in two,
    [analyse_dec_headers] and [analyse_dec_bodies] *)
and analyse_rec_dec_funs depth func_sym info_tbl =
    let analyse_dec_headers = function
      | TA.ConstVarDec { ty; name_sym } ->
        if depth <> 0 then begin
        add_local_var_to_tbl info_tbl name_sym ty depth func_sym;
        add_var_to_func_list info_tbl func_sym (name_sym, ty)
        end
      | TA.FunctionDec { ty; name_sym } ->
        add_fun_to_tbl info_tbl name_sym ty depth [] [];
      | TA.MutVarDec { ty; name_sym } ->
        if depth <> 0 then begin
          add_local_var_to_tbl info_tbl name_sym ty depth func_sym;
          add_var_to_func_list info_tbl func_sym (name_sym, ty)
        end
      | TA.ArrayDec { ty; name_sym } ->
        if depth <> 0 then begin
          add_local_var_to_tbl info_tbl name_sym ty depth func_sym;
          add_var_to_func_list info_tbl func_sym (name_sym, ty)
        end
    
    and analyse_dec_bodies = function
    | TA.ConstVarDec { value } ->
      analyse_expr depth func_sym info_tbl value
    | TA.FunctionDec { name_sym; params; body } ->
      List.iter (analyse_param (depth + 1) name_sym info_tbl) params;
      analyse_expr (depth + 1) name_sym info_tbl body;
      cleanup_func_dec info_tbl name_sym
    | TA.MutVarDec _ ->
      ()
    | TA.ArrayDec { dims_len_exprs } ->
      List.iter (analyse_expr depth func_sym info_tbl) dims_len_exprs
    in

    analyse_dec_headers, analyse_dec_bodies

(** [analyse_param depth func_sym info_tbl p] traverses and analyses TypedAst.param [p] of
    function-depth [depth] in function with symbol [func_sym] in [info_tbl_t] [info_tbl] *)
and analyse_param depth func_sym info_tbl = function
  | TA.Param { ty; name_sym } ->
    add_local_var_to_tbl info_tbl name_sym ty depth func_sym;
    add_var_to_func_list info_tbl func_sym (name_sym, ty)

(** [analyse_expr depth func_sym info_tbl expr] traverses and analyses TypedAst.expr [expr] of
    function-depth [depth] in function with symbol [func_sym] in [info_tbl_t] [info_tbl] *)
and analyse_expr depth func_sym info_tbl expr =
  let rec analyse_expr_aux = function
    | TA.E_ID { name_sym } ->
      esc_var_of_local info_tbl name_sym depth
    | TA.E_Int _ | TA.E_Float _ | TA.E_Char _ -> ()
    | TA.E_String _ | TA.E_BOOL _ | TA.E_Unit _ -> ()
    | TA.E_ArrayRef { name_sym } | TA.E_ArrayDim { name_sym } ->
      esc_var_of_local info_tbl name_sym depth
    | TA.E_New _ | TA.E_Delete _-> ()
    | TA.E_FuncCall { name_sym; param_exprs } ->
      esc_var_of_local info_tbl name_sym depth;
      List.iter analyse_expr_aux param_exprs
    | TA.E_ConstrCall { name_sym; param_exprs } ->
      esc_var_of_local info_tbl name_sym depth;
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
      add_local_var_to_tbl info_tbl count_var_sym (T.INT) depth func_sym;
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
      add_local_var_to_tbl info_tbl name_sym ty depth func_sym;
      add_var_to_func_list info_tbl func_sym (name_sym, ty)
      end

  and analyse_constr_pattern = function
    | TA.CP_BASIC { base_patterns } ->
      List.iter analyse_base_pattern base_patterns

  in
  analyse_expr_aux expr
