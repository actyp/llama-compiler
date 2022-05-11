module E = Escape
module L = Llvm
module LAN = Llvm_analysis
module S = Symbol
module T = Types
module TA = TypedAst

(** [internal_error loc_opt msg_fmt] invokes [Error.internal error_fmt] if loc_opt = None else
    [Error.pos_internal lpos_pair] where [error_fmt] is [default_fmt] extended with [msg_fmt] *)
let internal_error loc_opt msg_fmt =
  let default_fmt = format_of_string "during IR codegen, " in
  let error_fmt = default_fmt ^^ msg_fmt in
  match loc_opt with
  | None -> Error.internal error_fmt
  | Some loc -> Error.pos_internal_error loc error_fmt

let ctx = L.global_context ()
let the_module = L.create_module ctx "llama"
let builder = L.builder ctx

let unit_type = L.void_type ctx
and int_type = L.integer_type ctx 64
and char_type = L.integer_type ctx 8
and bool_type = L.integer_type ctx 1
and float_type = L.float_type ctx
and string_type = L.pointer_type (L.i8_type ctx)
and struct_type = L.struct_type ctx

let rec lltype_of_ty: T.ty -> L.lltype = function
  | T.UNIT -> unit_type
  | T.INT -> int_type
  | T.CHAR -> char_type
  | T.BOOL -> bool_type
  | T.FLOAT -> float_type
  | T.REF (ty, _) | T.DYN_REF (ty, _) -> L.pointer_type (lltype_of_ty ty)
  | T.ARRAY (dims, ty) ->
    let array_ptr = L.pointer_type (lltype_of_ty ty) in
    let array_struct = struct_type [| int_type; array_ptr |] in
    L.array_type array_struct dims
  | T.FUNC (param_tys, ret_ty) ->
    let param_lltypes = Array.of_list (List.map lltype_of_ty param_tys) in
    let ret_lltype = lltype_of_ty ret_ty in
    L.function_type ret_lltype param_lltypes
  | T.USERDEF _ -> 
    struct_type [| string_type; int_type |]
  | T.CONSTR (param_tys, userdef_ty, _) ->
    let param_lltypes = Array.of_list (List.map lltype_of_ty param_tys) in
    let userdef_lltype = lltype_of_ty userdef_ty in
    L.function_type userdef_lltype param_lltypes
  | T.VAR _ -> unit_type
  | T.POLY _ -> internal_error None "poly type found unsubstituted"

let pprint (llmodule: L.llmodule): unit = L.dump_module llmodule

let rec generate_ir (opt: bool) (tast: TA.tast) (info_tbl: E.info_tbl_t): L.llmodule =
  let init_depth = 0 in
  List.iter (generate_ir_def init_depth info_tbl) tast;
  match LAN.verify_module the_module with
  | None -> the_module
  | Some reason -> internal_error None "%s" reason

and generate_ir_def depth info_tbl = function
  | TA.LetDefNonRec { decs } ->
    List.iter (generate_ir_non_rec_dec depth info_tbl) decs
  | TA.LetDefRec { decs } ->
    failwith "TODO"
  | TA.TypeDef { tdecs } ->
    failwith "TODO"

and generate_ir_non_rec_dec depth info_tbl = function
  | TA.ConstVarDec { ty; name_sym; value } ->
    if depth = 0 then
      let llvalue = generate_ir_expr depth info_tbl value in
      ignore(L.define_global (S.name name_sym) llvalue the_module)
  | TA.FunctionDec { ty; name_sym; params; body; loc } ->
    failwith "TODO"
  | TA.MutVarDec { ty; name_sym } ->
    if depth = 0 then
      let llvalue = L.const_null (lltype_of_ty ty) in
      ignore(L.define_global (S.name name_sym) llvalue the_module)
  | TA.ArrayDec { ty; name_sym; dims_len_exprs; loc } ->
    failwith "TODO"
  
and generate_ir_expr depth info_tbl expr: L.llvalue =
  let rec generate_ir_expr_aux = function
  | TA.E_ID  { ty; name_sym; loc } ->
    if depth = 0 then
      match L.lookup_global (S.name name_sym) the_module with
      | Some v -> v
      | None -> internal_error (Some loc) "Unbound global %s" (S.name name_sym)
    else
      failwith "TODO EID"
  | TA.E_Int  { ty; value } -> L.const_int (lltype_of_ty ty) value
  | TA.E_Float { ty; value } -> L.const_float (lltype_of_ty ty) value
  | TA.E_Char { ty; value } -> L.const_int (lltype_of_ty ty) (int_of_char value)
  | TA.E_String  { value } -> L.const_stringz ctx value
  | TA.E_BOOL { ty; value } -> L.const_int (lltype_of_ty ty) (if value then 1 else 0)
  | TA.E_Unit { ty } -> L.const_null (lltype_of_ty ty)
  | TA.E_ArrayRef { ty; name_sym; exprs; loc } ->
    failwith "TODO"
  | TA.E_ArrayDim { ty; dim; name_sym; loc } ->
    failwith "TODO"
  | TA.E_New { ty } -> failwith "TODO"
  | TA.E_Delete { ty; expr; loc } ->
    failwith "TODO"
  | TA.E_FuncCall { ty; name_sym; param_exprs; loc } ->
    failwith "TODO"
  | TA.E_ConstrCall { ty; name_sym; param_exprs; loc} ->
    failwith "TODO"
  | TA.E_LetIn { ty; letdef; in_expr; loc } ->
    failwith "TODO"
  | TA.E_BeginEnd { ty; expr; loc } ->
    failwith "TODO"
  | TA.E_MatchedIF { ty; if_expr; then_expr; else_expr; loc } ->
    failwith "TODO"
  | TA.E_WhileDoDone  { ty; while_expr; do_expr; loc} ->
    failwith "TODO"
  | TA.E_ForDoDone { ty; count_var_sym; start_expr; count_dir; end_expr; do_expr; loc } ->
    failwith "TODO"
  | TA.E_MatchWithEnd { ty; match_expr; with_clauses; loc } ->
    failwith "TODO"

  and generate_ir_clause = function
  | TA.BasePattClause { base_pattern; expr; loc } ->
    failwith "TODO"
  | TA.ConstrPattClause { constr_pattern; expr; loc } ->
    failwith "TODO"

  and generate_ir_base_pattern = function
  | TA.BP_INT _ as bp -> failwith "TODO"
  | TA.BP_FLOAT _ as bp -> failwith "TODO"
  | TA.BP_CHAR _ as bp -> failwith "TODO"
  | TA.BP_BOOL _ as bp -> failwith "TODO"
  | TA.BP_ID { ty; name_sym; loc } -> failwith "TODO"

  and generate_ir_constr_pattern (TA.CP_BASIC { ty; constr_sym; base_patterns; loc }) =
  failwith "TODO"

  in
  generate_ir_expr_aux expr