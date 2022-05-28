module E = Escape
module H = Hashtbl
module L = Llvm
module LAN = Llvm_analysis
module LBE = Llvm_all_backends
module LTG = Llvm_target
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

let internal_error_of_msg_format loc_opt expected found func_name = 
  let msg_fmt = expected ^^ " %s found as " ^^ found ^^ " in " ^^ func_name in
  internal_error loc_opt msg_fmt

type global_str_tbl_t = (string, L.llvalue) H.t
let global_str_tbl: global_str_tbl_t = H.create 512

let tbl_add tbl key entry = H.replace tbl key entry
and tbl_find_opt tbl key = H.find_opt tbl key


let rec function_frames = Stack.create()
and function_frames_push frame = Stack.push frame function_frames
and function_frames_pop () = Stack.pop function_frames
and function_frames_top () = Stack.top function_frames
and function_frames_is_empty () = Stack.is_empty function_frames
  
let pprint (llmodule: L.llmodule): unit = L.dump_module llmodule

let print_lltype msg lltype = Printf.printf "%s lltype: %s\n" msg (L.string_of_lltype lltype); flush stdout
and print_llvalue msg llvalue = Printf.printf "%s llvalue: %s\n" msg (L.string_of_llvalue llvalue); flush stdout

let _ = LBE.initialize()
let ll_target_triple = LTG.Target.default_triple ()
let ll_target = LTG.Target.by_triple ll_target_triple
let ll_machine = LTG.TargetMachine.create ll_target_triple ll_target
let ll_data_layout = Llvm_target.TargetMachine.data_layout ll_machine

let ctx = L.global_context ()
let the_module = L.create_module ctx "llama"
let builder = L.builder ctx

let void_type = L.void_type ctx
and int_type = L.integer_type ctx 64
and char_type = L.integer_type ctx 8
and bool_type = L.integer_type ctx 1
and float_type = L.float_type ctx
and struct_type = L.struct_type ctx

let const_int i = L.const_int int_type i

let get_global_string_pointer string_value =
  let string_ptr = L.build_global_stringptr string_value "str" builder in
  tbl_add global_str_tbl string_value string_ptr;
  string_ptr

let ll_name_of_userdef_ty = function
  | T.USERDEF (name_sym, occ_num) -> (S.name name_sym) ^ ":" ^ (string_of_int occ_num)
  | _ -> internal_error_of_msg_format None "USERDEF" "other type" "userdef_type_name_of" "type"

let rec lltype_of_ty: T.ty -> L.lltype = function
  | T.UNIT -> bool_type
  | T.INT -> int_type
  | T.CHAR -> char_type
  | T.BOOL -> bool_type
  | T.FLOAT -> float_type
  | T.REF (ty, _) | T.DYN_REF (ty, _) -> L.pointer_type (lltype_of_ty ty)
  | T.ARRAY (dims, ty) ->
    (* array type is a struct { pointer to array, dim1 size, ..., dimN size } *)
    let rec gen_int_type_list curr_dim curr_tys = 
      if curr_dim = dims then curr_tys else gen_int_type_list (curr_dim + 1) (int_type :: curr_tys)
    in
    let array_ptr = L.pointer_type(lltype_of_ty ty) in
    let struct_elem_list = array_ptr :: (gen_int_type_list 0 []) in
    struct_type (Array.of_list struct_elem_list)
  | T.FUNC (param_tys, ret_ty) ->
    let param_lltypes = Array.of_list (List.map lltype_of_ty param_tys) in
    let ret_lltype = lltype_of_ty ret_ty in
    L.function_type ret_lltype param_lltypes
  | T.USERDEF (name_sym, occ_num) as ty -> 
    (* userdef type is a named struct, 'name:occ_num' = { int_tag; largest constructor type size } 
       (implementing tagged union), created elsewhere and only queried from here *)
    let userdef_type_name = ll_name_of_userdef_ty ty in
    begin match L.type_by_name the_module userdef_type_name with
      | Some lltype -> L.pointer_type lltype
      | None -> internal_error None "unknown userdef type encountered in lltype_of_ty"
    end
  | T.CONSTR (param_tys, userdef_ty, _) ->
    (* type constructor is a struct { int_tag; param_ty1; ...,  param_tyN} 
       following on the implementation of tagged union *)
    let param_lltypes = List.map lltype_of_ty param_tys in
    struct_type (Array.of_list (int_type :: param_lltypes))
  | T.VAR _ -> bool_type
  | T.POLY _ -> internal_error None "poly type encountered in lltype_of_ty"

let rec find_declaration_frame current_frame curr_depth dec_depth =
  if curr_depth - dec_depth <= 0
  then current_frame
  else begin
    let parent_frame_addr = L.build_struct_gep current_frame 0 "parent_frame_addr" builder in
    let parent_frame = L.build_load parent_frame_addr "parent_frame_temp_load" builder in
    find_declaration_frame parent_frame (curr_depth - 1) dec_depth
  end

let find_llvalue_addr_of_var name_sym current_depth info_tbl = 
  let func_internal_error expected found =
    internal_error_of_msg_format None expected found "find_llvalue_addr_of_var" (S.name name_sym)
  in
  match E.tbl_find_opt info_tbl name_sym with
  | None -> func_internal_error "var" "None"
  | Some E.FuncInfo _ -> func_internal_error "var" "FuncInfo"
  | Some E.LocalVarInfo { llvalue_opt } ->
    (* assuming info_tbl is correct, a local is found only in local scope while parsing *)
    begin match llvalue_opt with
    | None -> func_internal_error "local" "None" (* should have been allocated on it's function entry block *)
    | Some llvalue_addr -> llvalue_addr
    end
  | Some E.EscVarInfo { dec_depth; frame_offset } ->
    let name = S.name name_sym in
    let current_frame = function_frames_top () in
    let declaration_frame = find_declaration_frame current_frame current_depth dec_depth in
    print_llvalue "declaration_frame" declaration_frame;
    let load_addr = L.build_struct_gep declaration_frame (1 + frame_offset) (name ^ ":temp_gep") builder in
    print_llvalue "load_addr" load_addr;
    load_addr

let find_function_in_module name_sym = match L.lookup_function (S.name name_sym) the_module with
    | Some f -> f
    | None -> internal_error None "function %s not found in the_module" (S.name name_sym)
  
let build_frame_alloc func_name_sym esc_list =
  let esc_list_lltypes = List.map (fun (_, ty) -> lltype_of_ty ty) esc_list in
  let parent_struct_ptr_type = if function_frames_is_empty () 
    then L.pointer_type bool_type 
    else L.type_of (function_frames_top ()) (* stored addr is already a pointer*) in
  print_lltype (S.name func_name_sym ^ " parent_struct_ptr") parent_struct_ptr_type;
  let frame_type = struct_type (Array.of_list (parent_struct_ptr_type :: esc_list_lltypes)) in
  print_lltype "frame_type" frame_type;
  let frame_addr = L.build_alloca frame_type (S.name func_name_sym ^ ":frame") builder in
  function_frames_push frame_addr;
  frame_addr

let declare_function name_sym func_ty =
  let func_internal_error expected found name_sym =
    internal_error_of_msg_format None expected found "declare_function" (S.name name_sym)
  in
  let func_type = match func_ty with
    | T.FUNC _ -> lltype_of_ty func_ty
    | _ -> func_internal_error "Types.FUNC" "other type" name_sym
  in
  let func = L.declare_function (S.name name_sym) func_type the_module in
  L.set_gc (Some "ocaml") func;
  func

let build_func_frame_vars name_sym func_ty info_tbl =
  let func_internal_error expected found name_sym =
    internal_error_of_msg_format None expected found "build_func_frame_vars" (S.name name_sym)
  in
  let local_list, esc_list = match E.tbl_find_opt info_tbl name_sym with
    | None -> func_internal_error "function" "None" name_sym
    | Some E.LocalVarInfo _ -> func_internal_error "function" "LocalVarInfo" name_sym
    | Some E.EscVarInfo _ -> func_internal_error "function" "EscVarInfo" name_sym
    | Some E.FuncInfo { local_list; esc_list } -> local_list, esc_list
  in
  let add_llvalue_of_local_var name_sym llvalue = match E.tbl_find_opt info_tbl name_sym with
    | None -> func_internal_error "local" "None" name_sym
    | Some E.EscVarInfo _ -> func_internal_error "local" "EscVarInfo" name_sym
    | Some E.FuncInfo _ -> func_internal_error "local" "FuncInfo" name_sym
    | Some E.LocalVarInfo (_ as record) -> E.tbl_add info_tbl name_sym (E.LocalVarInfo { record with llvalue_opt = Some llvalue })
  in
  let rec alloc_locals = function
    | [] -> ()
    | (name_sym, ty) :: rest ->
      let name = S.name name_sym in
      let llvalue = L.build_alloca (lltype_of_ty ty) name builder in
      add_llvalue_of_local_var name_sym llvalue;
      alloc_locals rest
  in
  let func = match L.lookup_function (S.name name_sym) the_module with
    | Some f -> f (* already declared, found in recursive declaration *)
    | None -> declare_function name_sym func_ty (* undeclared, time for declaration *)
  in
  let entry_block = L.append_block ctx "entry" func in
  let body_block = L.append_block ctx "body" func in
  L.position_at_end entry_block builder;
  ignore(build_frame_alloc name_sym esc_list);
  alloc_locals local_list;
  ignore(L.build_br body_block builder);
  ignore(L.position_at_end body_block builder);
  body_block

let build_func_return body_block ret_llvalue =
  L.position_at_end body_block builder;
  ignore(L.build_ret ret_llvalue builder);
  ignore(function_frames_pop ())

let build_array_llvalue name array_llty array_struct_addr_opt array_addr_opt dims_len_llvalues =
  let store_to_struct ll_struct index value =
    let addr = L.build_struct_gep ll_struct index "tmp_struct_store_addr" builder in
    print_llvalue "addr" addr;
    ignore(L.build_store value addr builder)
  in
  let array_addr = match array_addr_opt with
  | Some addr -> addr
  | None ->
    (* calculate size as multiplication of dims *)
    let array_size = List.fold_left (fun acc d -> L.build_mul d acc "tmp_array_size" builder) (List.hd dims_len_llvalues) (List.tl dims_len_llvalues) in
    print_llvalue "array_size" array_size;
    let elem_type = array_llty |> L.struct_element_types |> fun arr -> Array.get arr 0 |> L.element_type in
    print_lltype "array_llty" array_llty;
    print_lltype "elem_ty" elem_type;
    let array_addr = L.build_array_alloca elem_type array_size "tmp_array_alloca" builder in
    print_llvalue "array_addr" array_addr;
    array_addr
  in
  let array_struct_addr = match array_struct_addr_opt with
    | Some addr -> addr
    | None -> L.build_alloca array_llty name builder
  in
  print_llvalue "array_struct_addr" array_struct_addr;
  List.iteri (fun i llv -> store_to_struct array_struct_addr i llv) (array_addr :: dims_len_llvalues)

let userdef_ty_of_constr (TA.Constr { ty }) =
  let userdef_ty_of_constr_ty = function
    | T.CONSTR (_, ty, _) -> ty
    | _ -> internal_error_of_msg_format None "CONSTR" "other type" "userdef_ty_of_constr_ty" "type"
  in
  userdef_ty_of_constr_ty ty

let declare_opaque_userdef_type (TA.TypeDec { name_sym; constrs }) =
  let struct_name = constrs |> List.hd |> userdef_ty_of_constr |> ll_name_of_userdef_ty in
  (* type is opaque; just a name *)
  L.named_struct_type ctx struct_name

let create_userdef_type_struct (TA.TypeDec { name_sym; constrs }) =
  let constr_ll_types = List.map (fun (TA.Constr { ty }) -> lltype_of_ty ty) constrs in
  List.iteri (fun i ty -> print_lltype (string_of_int i) ty) constr_ll_types;
  let abi_size_of llty = LTG.DataLayout.abi_size llty ll_data_layout in
  let largest_lltype_of t1 t2 = if (abi_size_of t1) > (abi_size_of t2) then t1 else t2 in
  let largest_lltype = List.fold_left largest_lltype_of (List.hd constr_ll_types) constr_ll_types in
  print_lltype "max_type" largest_lltype;
  let struct_lltype = constrs |> List.hd |> userdef_ty_of_constr |> lltype_of_ty |> L.element_type in (* opaque type *)
  L.struct_set_body struct_lltype [| int_type; largest_lltype |] false; (* opaque type obtains body and becomes struct type *)
  print_lltype (S.name name_sym) struct_lltype

(* let create_userdef_type  *)
let rec generate_ir (opt: bool) (tast: TA.tast) (info_tbl: E.info_tbl_t): L.llmodule =
  let init_depth = 0 in
  let entry_func_name_sym = ("entry_func", 0) in
  let entry_func_ty = T.FUNC ([], T.INT) in
  let entry_body_block = build_func_frame_vars entry_func_name_sym entry_func_ty info_tbl in
  let entry_ret_llvalue = const_int 0 in

  List.iter (generate_ir_def (init_depth + 1) info_tbl) tast;
  build_func_return entry_body_block entry_ret_llvalue;

  match LAN.verify_module the_module with
  | None -> the_module
  | Some reason -> pprint the_module; internal_error None "Verification error: %s" reason

and generate_ir_def depth info_tbl = function
  | TA.LetDefNonRec { decs } ->
    List.iter (generate_ir_non_rec_dec depth info_tbl) decs
  | TA.LetDefRec { decs } ->
    let declare_only_func = function 
      | TA.FunctionDec { ty; name_sym } -> ignore(declare_function name_sym ty) (* functions need to be parsed and declared *)
      | _ -> () (* others being in info_tbl are already allocated in entry block of current function *)
    in
    List.iter declare_only_func decs;
    List.iter (generate_ir_non_rec_dec depth info_tbl) decs
  | TA.TypeDef { tdecs } ->
    List.iter (fun tdec -> ignore(declare_opaque_userdef_type tdec)) tdecs; (* type names need to be parsed and declared *)
    List.iter create_userdef_type_struct tdecs (* create struct types for opaque declared types *)

and generate_ir_non_rec_dec depth info_tbl = function
  | TA.ConstVarDec { ty; name_sym; value } ->
    let llvalue = generate_ir_expr depth info_tbl value in
    begin match value with
    | TA.E_String { value } ->
      (* String is represented as array of chars, so has lltype array struct *)
      let struct_addr = find_llvalue_addr_of_var name_sym depth info_tbl in
      let array_llty = lltype_of_ty ty in
      let str_size_with_zeros = String.length value + 1 in
      build_array_llvalue (S.name name_sym) array_llty (Some struct_addr) (Some llvalue) [const_int str_size_with_zeros]
    | _ ->
      let addr = find_llvalue_addr_of_var name_sym depth info_tbl in
      ignore(L.build_store llvalue addr builder)
    end
  | TA.FunctionDec { ty; name_sym; params; body } ->
    let current_block = L.insertion_block builder in
    let body_block = build_func_frame_vars name_sym ty info_tbl in
    List.iteri (generate_ir_param name_sym info_tbl depth) params;
    let ret_llvalue = generate_ir_expr (depth + 1) info_tbl body in
    build_func_return body_block ret_llvalue;
    L.position_at_end current_block builder
  | TA.MutVarDec { ty; name_sym } ->
    let llvalue = L.const_null (lltype_of_ty ty) in
    let addr = find_llvalue_addr_of_var name_sym depth info_tbl in
    ignore(L.build_store llvalue addr builder)
  | TA.ArrayDec { ty; name_sym; dims_len_exprs } ->
    let struct_addr = find_llvalue_addr_of_var name_sym depth info_tbl in
    let array_llty = lltype_of_ty ty in
    let dims_len_llvalues = List.map (generate_ir_expr depth info_tbl) dims_len_exprs in
    build_array_llvalue (S.name name_sym) array_llty (Some struct_addr) None dims_len_llvalues
    
and generate_ir_param func_name_sym info_tbl depth param_index (Param { name_sym }) =
  let func = find_function_in_module func_name_sym in
  let var_addr = find_llvalue_addr_of_var name_sym depth info_tbl in
  let param_llvalue = L.param func param_index in
  ignore(L.build_store param_llvalue var_addr builder)

and generate_ir_expr depth info_tbl expr: L.llvalue =
  let rec generate_ir_expr_aux = function
  | TA.E_ID  { name_sym } ->
    let id_addr = find_llvalue_addr_of_var name_sym depth info_tbl in
    L.build_load id_addr "temp_load" builder
  | TA.E_Int  { ty; value } -> 
    L.const_int (lltype_of_ty ty) value
  | TA.E_Float { ty; value } -> 
    L.const_float (lltype_of_ty ty) value
  | TA.E_Char { ty; value } -> 
    L.const_int (lltype_of_ty ty) (int_of_char value)
  | TA.E_String  { value } ->
    begin match tbl_find_opt global_str_tbl value with
    | Some string_ptr -> string_ptr
    | None -> get_global_string_pointer value
    end
  | TA.E_BOOL { ty; value } -> 
    L.const_int (lltype_of_ty ty) (if value then 1 else 0)
  | TA.E_Unit { ty } -> 
    L.const_null (lltype_of_ty ty)
  | TA.E_ArrayRef { name_sym; exprs } ->
    let exprs_ll = List.map generate_ir_expr_aux exprs in
    (* TODO generate mapped boundary check *)
    let struct_addr = find_llvalue_addr_of_var name_sym depth info_tbl in
    failwith "TODO"
  | TA.E_ArrayDim { dim; name_sym } ->
    let struct_addr = find_llvalue_addr_of_var name_sym depth info_tbl in
    (* TODO array boundary check before gep instruction *)
    (* dim (as int constant >= 1) equals struct offset *)
    let dim_addr = L.build_struct_gep struct_addr dim "tmp_struct_dim_addr" builder in
    L.build_load dim_addr "tmp_struct_dim_load" builder
  | TA.E_New { ty } -> failwith "TODO"
  | TA.E_Delete { ty; expr; loc } ->
    failwith "TODO"
  | TA.E_FuncCall { ty; name_sym; param_exprs } ->
    let callee = find_function_in_module name_sym in
    let param_llvalues = List.map generate_ir_expr_aux param_exprs in
    L.build_call callee (Array.of_list param_llvalues) ("temp_call") builder
  | TA.E_ConstrCall { ty; name_sym; param_exprs; loc} ->
    failwith "TODO"
  | TA.E_LetIn { letdef; in_expr} ->
    generate_ir_def depth info_tbl letdef;
    generate_ir_expr depth info_tbl in_expr
  | TA.E_BeginEnd { expr } ->
    generate_ir_expr_aux expr
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
