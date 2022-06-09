module Env = Environment
module Esc = Escape
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

let global_str_tbl: (string, L.llvalue) H.t = H.create 512
let constr_info_tbl: (string, (int * L.lltype)) H.t = H.create 512

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
let ll_machine = LTG.TargetMachine.create ~triple:ll_target_triple ll_target
let ll_data_layout = Llvm_target.TargetMachine.data_layout ll_machine

let ctx = L.global_context ()
let the_module = L.create_module ctx "llama"
let builder = L.builder ctx

let int_type = L.integer_type ctx 64
and char_type = L.integer_type ctx 8
and bool_type = L.integer_type ctx 1
and float_type = L.float_type ctx
and struct_type = L.struct_type ctx

let const_int i = L.const_int int_type i
and const_char c = L.const_int char_type c
and const_bool b = L.const_int bool_type (if b then 1 else 0)
and const_float f = L.const_float float_type f

let unit_type = bool_type
let unit_value = L.const_null unit_type

module StringSet = Set.Make(String)

let string_set_of_list = List.fold_left (fun set str -> StringSet.add str set) StringSet.empty

let unary_operator_name_set = string_set_of_list Env.unary_operator_names
and binary_operator_name_set = string_set_of_list Env.binary_operator_names
and external_function_name_set = string_set_of_list Env.external_function_names

let is_unary_operator name = StringSet.mem name unary_operator_name_set
and is_binary_operator name = StringSet.mem name binary_operator_name_set
and is_external_function name = StringSet.mem name external_function_name_set

let get_or_build_global_string_pointer string_value =
  match tbl_find_opt global_str_tbl string_value with
  | Some string_ptr -> string_ptr
  | None ->
    let string_ptr = L.build_global_stringptr string_value "str" builder in
    tbl_add global_str_tbl string_value string_ptr;
    string_ptr

let rec llname_userdef_of_userdef_ty = function
  | T.USERDEF (name_sym, occ_num) -> (S.name name_sym) ^ ":" ^ (string_of_int occ_num)
  | _ -> internal_error_of_msg_format None "USERDEF" "other type" "llname_userdef_of_userdef_ty" "type"

and llname_constr_of_constr_info name_sym userdef_ty =
  let userdef_ty_name =  llname_userdef_of_userdef_ty userdef_ty in
  userdef_ty_name ^ ":" ^ (S.name name_sym)

and llname_equality_fun_of_userdef_ty = function
  | T.USERDEF _ as ty -> "_" ^ (llname_userdef_of_userdef_ty ty) ^ "_equality"
  | _ -> internal_error_of_msg_format None "USERDEF" "other type" "llname_equality_fun_of_userdef_ty" "type"

and userdef_ty_of_constr_ty = function
  | T.CONSTR (_, ty, _) -> ty
  | _ -> internal_error_of_msg_format None "CONSTR" "other type" "userdef_ty_of_constr_ty" "type"

and userdef_ty_of_constr (TA.Constr { ty }) =
  userdef_ty_of_constr_ty ty

let rec lltype_of_ty: T.ty -> L.lltype = function
  | T.UNIT -> unit_type
  | T.INT -> int_type
  | T.CHAR -> char_type
  | T.BOOL -> bool_type
  | T.FLOAT -> float_type
  | T.REF (ty, _) | T.DYN_REF (ty, _) -> L.pointer_type (lltype_of_ty ty)
  | T.ARRAY (dims, ty) ->
    (* array type is a pointer to a struct { pointer to array, dim1 size, ..., dimN size } *)
    let rec gen_int_type_list curr_dim curr_tys = 
      if curr_dim = dims then curr_tys else gen_int_type_list (curr_dim + 1) (int_type :: curr_tys)
    in
    let array_ptr = L.pointer_type(lltype_of_ty ty) in
    let struct_elem_list = array_ptr :: (gen_int_type_list 0 []) in
    struct_type (Array.of_list struct_elem_list) |> L.pointer_type
  | T.FUNC (param_tys, ret_ty) ->
    let param_lltypes = Array.of_list (List.map lltype_of_ty param_tys) in
    let ret_lltype = lltype_of_ty ret_ty in
    L.function_type ret_lltype param_lltypes
  | T.USERDEF (name_sym, occ_num) as ty -> 
    (* userdef type is pointer to a named struct, 'name:occ_num' = { int_tag; largest constructor type size } 
       (implementing tagged union), created elsewhere and only queried from here *)
    let userdef_type_name = llname_userdef_of_userdef_ty ty in
    begin match L.type_by_name the_module userdef_type_name with
      | Some lltype -> L.pointer_type lltype
      | None -> L.pointer_type (L.named_struct_type ctx userdef_type_name) (* just declare the opaque type *)
    end
  | T.CONSTR (param_tys, userdef_ty, _) ->
    (* type constructor is pointer to a struct { int_tag; param_ty1; ...,  param_tyN} 
       following on the implementation of tagged union *)
    let param_lltypes = List.map lltype_of_ty param_tys in
    struct_type (Array.of_list (int_type :: param_lltypes)) |> L.pointer_type
  | T.VAR _ -> bool_type
  | T.POLY _ -> internal_error None "poly type encountered in lltype_of_ty"

and declare_external_functions () =
  let rec declare_from_list = function
    | [] -> ()
    | (name, ty) :: rest -> 
      (* external implemented functions have a prefix of 'lla_' *)
      let external_name = "lla_" ^ name in
      ignore(declare_function (external_name, 0) ty); 
      declare_from_list rest 
  in
List.iter declare_from_list Env.external_functions

and declare_function name_sym func_ty =
  let func_internal_error expected found name_sym =
    internal_error_of_msg_format None expected found "declare_function" (S.name name_sym)
  in
  let func_type = match func_ty with
    | T.FUNC _ -> lltype_of_ty func_ty
    | _ -> func_internal_error "Types.FUNC" "other type" name_sym
  in
  let func = L.declare_function (S.name name_sym) func_type the_module in
  func

and build_utility_funs () =
  let build_runtime_error_fun () =
    (* declare function *)
    let func_name = "_runtime_error" in
    let func_lltype = L.function_type unit_type [| L.pointer_type char_type; int_type |] in
    let func = L.declare_function func_name func_lltype the_module in

    (* create basic_blocks entry, body *)
    let entry_block = L.append_block ctx "entry" func in
    let body_block = L.append_block ctx "body" func in

    (* take params *)
    let array_ptr = L.param func 0 in
    let array_size = L.param func 1 in

    (* fill entry_block *)
    L.position_at_end entry_block builder;
    ignore(L.build_br body_block builder);

    (* fill body_block *)
    L.position_at_end body_block builder;

    (* build array struct *)
    let struct_ptr_llty = lltype_of_ty Env.array_of_char_ty in
    let struct_ptr = build_array_struct "runtime_error_array_struct" struct_ptr_llty None None (Some array_ptr) [array_size] in
    
    (* build error code *)
    let error_code = const_int 1 in

    (* find and call external function 'lla_exit_with_error_call' *)
    let func = find_function_in_module "lla_exit_with_error" in
    let ret = L.build_call func [| struct_ptr; error_code |] "lla_exit_with_error_call" builder in
    ignore(L.build_ret ret builder);
  in
  let build_division_fun name_sym elem_type ll_cmp_fun ll_div_fun = 
    (* declare function *)
    let func_lltype = L.function_type elem_type [| elem_type; elem_type |] in
    let func = L.declare_function (S.name name_sym) func_lltype the_module in

    (* create basic_blocks entry, runtime_error, body *)
    let entry_block = L.append_block ctx "entry" func in
    let error_block = L.append_block ctx "runtime_error" func in
    let body_block = L.append_block ctx "body" func in
    
    (* take params *)
    let param1 = L.param func 0 in
    let param2 = L.param func 1 in

    (* fill entry_block *)
    L.position_at_end entry_block builder;
    let cond = ll_cmp_fun param2 "denom_zero_comp" builder in
    ignore(L.build_cond_br cond error_block body_block builder);

    (* fill runtime_error block *)
    L.position_at_end error_block builder;
    build_runtime_error "Division by zero";
    ignore(L.build_br error_block builder);

    (* fill body block *)
    L.position_at_end body_block builder;
    let ret = ll_div_fun param1 param2 "division" builder in
    ignore(L.build_ret ret builder);
  in
  build_runtime_error_fun ();
  build_division_fun ("_binary_int_division", 0) int_type (L.build_icmp L.Icmp.Eq (const_int 0)) L.build_sdiv;
  build_division_fun ("_binary_float_division", 0)  float_type (L.build_fcmp L.Fcmp.Oeq (const_float 0.0)) L.build_fdiv

and build_runtime_error msg =
  (* get or build error char array *)
  let error_str = "Runtime Error: " ^ msg ^ "\n" in
  let str_size_with_zeros = String.length error_str + 1 in
  let array_ptr = get_or_build_global_string_pointer error_str in
  let array_size = const_int str_size_with_zeros in

  (* find and call util function '_runtime_error' *)
  let func = find_function_in_module "_runtime_error" in
  ignore(L.build_call func [| array_ptr; array_size |] "_runtime_error_call" builder)

and find_function_in_module name =
  (* add 'lla_' prefix in case of external function *)
  let func_name = if is_external_function name then "lla_" ^ name else name in
  match L.lookup_function func_name the_module with
    | Some f -> f
    | None -> internal_error None "function %s not found in the_module" name

and build_func_frame_vars name_sym func_ty info_tbl =
  let func_internal_error expected found name_sym =
    internal_error_of_msg_format None expected found "build_func_frame_vars" (S.name name_sym)
  in
  let local_list, esc_list = match Esc.tbl_find_opt info_tbl name_sym with
    | None -> func_internal_error "function" "None" name_sym
    | Some Esc.LocalVarInfo _ -> func_internal_error "function" "LocalVarInfo" name_sym
    | Some Esc.EscVarInfo _ -> func_internal_error "function" "EscVarInfo" name_sym
    | Some Esc.FuncInfo { local_list; esc_list } -> local_list, esc_list
  in
  let build_frame_alloc esc_list =
    let esc_list_lltypes = List.map (fun (_, ty) -> lltype_of_ty ty) esc_list in
    let parent_struct_ptr_type = if function_frames_is_empty () 
      then L.pointer_type bool_type 
      else L.type_of (function_frames_top ()) (* stored ptr is already a pointer*) in
    print_lltype (S.name name_sym ^ " parent_struct_ptr") parent_struct_ptr_type;
    let frame_type = struct_type (Array.of_list (parent_struct_ptr_type :: esc_list_lltypes)) in
    print_lltype "frame_type" frame_type;
    let frame_ptr = L.build_alloca frame_type (S.name name_sym ^ ":frame") builder in
    function_frames_push frame_ptr;
    frame_ptr
  in
  let add_llvalue_of_local_var name_sym llvalue = match Esc.tbl_find_opt info_tbl name_sym with
    | None -> func_internal_error "local" "None" name_sym
    | Some Esc.EscVarInfo _ -> func_internal_error "local" "EscVarInfo" name_sym
    | Some Esc.FuncInfo _ -> func_internal_error "local" "FuncInfo" name_sym
    | Some Esc.LocalVarInfo (_ as record) -> Esc.tbl_add info_tbl name_sym (Esc.LocalVarInfo { record with llvalue_opt = Some llvalue })
  in
  let rec alloc_locals = function
    | [] -> ()
    | (name_sym, ty) :: rest ->
      let name = S.name name_sym in
      let llvalue = L.build_alloca (lltype_of_ty ty) name builder in
      print_llvalue "local_param" llvalue;
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
  ignore(build_frame_alloc esc_list);
  alloc_locals local_list;
  ignore(L.build_br body_block builder);
  ignore(L.position_at_end body_block builder)

and find_llvalue_ptr_of_var name_sym current_depth info_tbl = 
let func_internal_error expected found =
  internal_error_of_msg_format None expected found "find_llvalue_ptr_of_var" (S.name name_sym)
in
let rec find_declaration_frame current_frame curr_depth dec_depth =
  if curr_depth - dec_depth <= 0
  then current_frame
  else begin
    let parent_frame_ptr = L.build_struct_gep current_frame 0 "parent_frame_ptr" builder in
    let parent_frame = L.build_load parent_frame_ptr "parent_frame_temp_load" builder in
    find_declaration_frame parent_frame (curr_depth - 1) dec_depth
  end
in
match Esc.tbl_find_opt info_tbl name_sym with
| None -> func_internal_error "var" "None"
| Some Esc.FuncInfo _ -> func_internal_error "var" "FuncInfo"
| Some Esc.LocalVarInfo { llvalue_opt } ->
  (* assuming info_tbl is correct, a local is found only in local scope while parsing *)
  begin match llvalue_opt with
  | None -> func_internal_error "local" "None" (* should have been allocated on it's function entry block *)
  | Some llvalue_ptr -> llvalue_ptr
  end
| Some Esc.EscVarInfo { dec_depth; frame_offset } ->
  let name = S.name name_sym in
  let current_frame = function_frames_top () in
  let declaration_frame = find_declaration_frame current_frame current_depth dec_depth in
  print_llvalue "declaration_frame" declaration_frame;
  let load_ptr = L.build_struct_gep declaration_frame (1 + frame_offset) (name ^ ":temp_gep") builder in
  print_llvalue "load_ptr" load_ptr;
  load_ptr

and build_alloca_end_of_entry_block lltype name array_size_opt =
  let instr_of_option = function
    | None -> internal_error None "no instruction option specified in build_alloca_end_of_entry_block"
    | Some i -> i
  in
  let entry_block_end_builder = builder |> L.insertion_block |> L.block_parent |> L.entry_block 
    |> L.block_terminator |> instr_of_option |> L.builder_before ctx
  in
  match array_size_opt with
  | None -> L.build_alloca lltype name entry_block_end_builder
  | Some array_size -> L.build_array_alloca lltype array_size name entry_block_end_builder

and build_func_return ret_llvalue =
  ignore(L.build_ret ret_llvalue builder);
  ignore(function_frames_pop ())

and build_array_struct name struct_ptr_llty struct_ptr_ptr_opt struct_ptr_opt array_ptr_opt dims_len_llvalues =
  let store_to_struct ll_struct index value =
    let ptr = L.build_struct_gep ll_struct index "temp_struct_store_ptr" builder in
    print_llvalue "ptr" ptr;
    ignore(L.build_store value ptr builder)
  in
  (* get struct type *)
  let struct_llty = L.element_type struct_ptr_llty
  in
  (* get or build array *)
  let array_ptr = match array_ptr_opt with
  | Some ptr -> ptr
  | None ->
    (* create basic blocks array_dec_dim_check_failed, array_dec_dim_check_success *)
    let function_block = builder |> L.insertion_block |> L.block_parent in
    let array_failed_block = L.append_block ctx "array_dec_dim_check_failed" function_block in
    let array_success_block = L.append_block ctx "array_dec_dim_check_success" function_block in

    (* check if all dim sizes are greater than zero with consecutive and *)
    let create_and prev_and dim_size =
      (* 0 < dim_size *)
      let pos_dim_cond = L.build_icmp L.Icmp.Slt (const_int 0) dim_size "array_dec_dim_cond" builder in
      L.build_and prev_and pos_dim_cond "temp_pos_dim_cond" builder
    in
    let dim_check = List.fold_left create_and (const_bool true) dims_len_llvalues in
    ignore(L.build_cond_br dim_check array_success_block array_failed_block builder);

    (* fill array_failed_block *)
    L.position_at_end array_failed_block builder;
    build_runtime_error "Non positive dimension size on array declaration";
    ignore(L.build_br array_failed_block builder);

    (* fill array_success_block *)
    L.position_at_end array_success_block builder;
    (* calculate size as multiplication of dims *)
    let array_size = List.fold_left (fun acc d -> L.build_mul d acc "temp_array_size" builder) (const_int 1) dims_len_llvalues in
    print_llvalue "array_size" array_size;
    let elem_type = struct_llty |> L.struct_element_types |> fun arr -> Array.get arr 0 |> L.element_type in
    print_lltype "struct_llty" struct_llty;
    print_lltype "elem_ty" elem_type;
    (* build alloca in current block instead of entry_block, because on runtime 
        alloca instruction is before branch to dim_check blocks *)
    let array_ptr = L.build_array_alloca elem_type array_size "temp_array_alloca" builder in
    print_llvalue "array_ptr" array_ptr;
    array_ptr
  in
  (* get or build struct *)
  let struct_ptr = match struct_ptr_opt with
    | Some ptr -> ptr
    | None -> build_alloca_end_of_entry_block struct_llty name None
  in
  (* store struct in possible provided struct_ptr_ptr *)
  let _ = match struct_ptr_ptr_opt with
    | None -> ()
    | Some struct_ptr_ptr -> ignore(L.build_store struct_ptr struct_ptr_ptr builder);
  in
  print_llvalue "struct_ptr" struct_ptr;
  List.iteri (fun i llv -> store_to_struct struct_ptr i llv) (array_ptr :: dims_len_llvalues);
  struct_ptr

and build_equality_check is_struct p1_ll p2_ll = function
  | T.UNIT -> 
    const_bool true
  | T.INT | T.CHAR | T.BOOL -> 
    L.build_icmp L.Icmp.Eq p1_ll p2_ll "int_equality_check" builder
  | T.FLOAT -> 
    L.build_fcmp L.Fcmp.Oeq p1_ll p2_ll "float_equality_check" builder
  | T.REF _ | T.DYN_REF _ -> 
    let ptr_diff = L.build_ptrdiff p1_ll p2_ll "ptr_diff" builder in
    L.build_icmp L.Icmp.Eq (const_int 0) ptr_diff "ref_equality_check" builder
  | T.USERDEF _ as userdef_ty -> 
    begin match is_struct with
    | false ->
      let ptr_diff = L.build_ptrdiff p1_ll p2_ll "ptr_diff" builder in
      L.build_icmp L.Icmp.Eq (const_int 0) ptr_diff "constr_nat_equality" builder
    | true -> 
      let func_name = llname_equality_fun_of_userdef_ty userdef_ty in
      let constr_eq_fun = find_function_in_module func_name in
      L.build_call constr_eq_fun [| p1_ll; p2_ll |] "constr_eq_call" builder
    end
  | _ as ty -> 
    internal_error None "unsupported type %s in equality check" (T.ty_to_string ty)

and build_unary_operator name_sym param_exprs generate_ir_fun = 
  let op_name = S.name name_sym in
  let param_ll = match param_exprs with
    | [p] -> generate_ir_fun p 
    | _ -> internal_error None "non-single parameter provided to unary operator: %s" op_name
  in
  match StringSet.find_opt op_name unary_operator_name_set with
  | None -> internal_error None "unsupported unary operator: %s" op_name
  | Some _ -> match op_name with
    | "( ~+ )" -> param_ll
    | "( ~- )" -> L.build_mul (const_int (-1)) param_ll "unary_int_neg_mul" builder
    | "( ~+. )" -> param_ll
    | "( ~-. )" -> L.build_mul (const_float (-1.0)) param_ll "unary_float_neg_mul" builder
    | "( ! )" -> L.build_load param_ll "unary_ref" builder
    | "( not )" -> L.build_not param_ll "unary_not" builder
    | _ -> internal_error None "unsupported unary operator: %s" op_name
  
and build_binary_operator name_sym param_exprs generate_ir_fun =
  let op_name = S.name name_sym in
  (* param2 to be generated on need, in order to support short-circuit behavior *)
  let p1_ll, p2_expr = match param_exprs with
    | [p1; p2] -> generate_ir_fun p1, p2
    | _ -> internal_error None "non-double parameter provided to binary operator: %s" op_name
  in
  let gen_p2 () = generate_ir_fun p2_expr
  in
  let call_after_lookup name param_array var_name =
    let func = find_function_in_module name in
    L.build_call func param_array var_name builder
  in
  let int_char_float_cmp (itp, ftp) p1_ll = match L.type_of p1_ll with
    | t when t = int_type || t = char_type -> L.build_icmp itp p1_ll
    | t when t = float_type -> L.build_fcmp ftp p1_ll
    | _ -> internal_error None "invalid type provided to int_char_float_cmp"
  in
  let build_short_circuited_logical_oper ll_lgc_fun short_llvalue p1_ll gen_p2 =
    (* create basic_blocks logical_non_short_circuit, logical_continue *)
    let current_block = builder |> L.insertion_block in
    let function_block = current_block |> L.block_parent in
    let non_short_block = L.append_block ctx "logical_non_short_circuit" function_block in
    let continue_block = L.append_block ctx "logical_continue" function_block in
    
    (* fill current block *)
    let cond = L.build_icmp L.Icmp.Eq short_llvalue p1_ll "short_circuit_check" builder in
    ignore(L.build_cond_br cond continue_block non_short_block builder);

    (* fill non_short_circuit block *)
    L.position_at_end non_short_block builder;
    (* generate p2_ll in this block *)
    let p2_ll = gen_p2 () in
    let full_llvalue = ll_lgc_fun p1_ll p2_ll "logical_function" builder in
    ignore(L.build_br continue_block builder);

    (* fill continue block *)
    L.position_at_end continue_block builder;
    L.build_phi [(short_llvalue, current_block); (full_llvalue, non_short_block)] "temp_phi" builder
  in
  match StringSet.find_opt op_name binary_operator_name_set with
  | None -> internal_error None "unsupported binary operator: %s" op_name
  | Some _ -> match op_name with
    | "( + )" -> 
      let p2_ll = gen_p2 () in 
      L.build_add p1_ll p2_ll "binary_int_add" builder
    | "( - )" -> 
      let p2_ll = gen_p2 () in 
      L.build_sub p1_ll p2_ll "binary_int_sub" builder
    | "( * )" -> 
      let p2_ll = gen_p2 () in 
      L.build_mul p1_ll p2_ll "binary_int_mul" builder
    | "( / )" -> 
      let p2_ll = gen_p2 () in 
      call_after_lookup "_binary_int_division" [| p1_ll; p2_ll |] "binary_int_division"
    | "( +. )" -> 
      let p2_ll = gen_p2 () in 
      L.build_fadd p1_ll p2_ll "binary_float_add" builder
    | "( -. )" -> 
      let p2_ll = gen_p2 () in 
      L.build_fsub p1_ll p2_ll "binary_float_sub" builder
    | "( *. )" -> 
      let p2_ll = gen_p2 () in
      L.build_fmul p1_ll p2_ll "binary_float_mul" builder
    | "( /. )" -> 
      let p2_ll = gen_p2 () in
      call_after_lookup "_binary_float_division" [| p1_ll; p2_ll |] "binary_float_division"
    | "( mod )" -> 
      let p2_ll = gen_p2 () in 
      L.build_srem p1_ll p2_ll "binary_int_mod" builder
    | "( ** )" -> 
      let p2_ll = gen_p2 () in 
      let func = find_function_in_module "lla_pow" in
      L.build_call func [| p1_ll; p2_ll |] "lla_pow_call" builder
    | "( = )" -> 
      let p2_ll = gen_p2 () in
      build_equality_check true p1_ll p2_ll (TA.expr_ty p2_expr)
    | "( <> )" -> 
      let p2_ll = gen_p2 () in
      let eq = build_equality_check true p1_ll p2_ll (TA.expr_ty p2_expr) in
      L.build_not eq "binary_struct_unequality" builder
    | "( < )" -> 
      let p2_ll = gen_p2 () in 
      int_char_float_cmp (L.Icmp.Slt, L.Fcmp.Olt) p1_ll p2_ll "binary_lt" builder
    | "( > )" -> 
      let p2_ll = gen_p2 () in
      int_char_float_cmp (L.Icmp.Sgt, L.Fcmp.Ogt) p1_ll p2_ll "binary_gt" builder
    | "( <= )" -> 
      let p2_ll = gen_p2 () in
      int_char_float_cmp (L.Icmp.Sle, L.Fcmp.Ole) p1_ll p2_ll "binary_leq" builder
    | "( >= )" -> 
      let p2_ll = gen_p2 () in
      int_char_float_cmp (L.Icmp.Sge, L.Fcmp.Oge) p1_ll p2_ll "binary_geq" builder
    | "( == )" -> 
      let p2_ll = gen_p2 () in
      build_equality_check false p1_ll p2_ll (TA.expr_ty p2_expr)
    | "( != )" -> 
      let p2_ll = gen_p2 () in
      let eq = build_equality_check false p1_ll p2_ll (TA.expr_ty p2_expr) in
      L.build_not eq "binary_nat_unequality" builder
    | "( && )" -> 
      build_short_circuited_logical_oper L.build_and (const_bool false) p1_ll gen_p2
    | "( || )" -> 
      build_short_circuited_logical_oper L.build_or (const_bool true) p1_ll gen_p2
    | "( ; )" ->
      gen_p2 ()
    | "( := )" -> 
      let p2_ll = gen_p2 () in 
      ignore(L.build_store p2_ll p1_ll builder); 
      unit_value
    | _ -> 
      internal_error None "unsupported binary operator: %s" op_name

and create_named_type_structs_and_equality_fun (TA.TypeDec { name_sym; constrs }) =
  let userdef_ty =  constrs |> List.hd |> userdef_ty_of_constr in
  let constr_lltypes = List.map (fun (TA.Constr { ty }) -> lltype_of_ty ty |> L.element_type) constrs in
  List.iteri (fun i ty -> print_lltype (string_of_int i) ty) constr_lltypes;

  let create_userdef_named_struct_type () =
    let abi_size_of llty = LTG.DataLayout.abi_size llty ll_data_layout in
    let largest_lltype_of t1 t2 = if (abi_size_of t1) > (abi_size_of t2) then t1 else t2 in
    let largest_lltype = List.fold_left largest_lltype_of (List.hd constr_lltypes) constr_lltypes in
    print_lltype "max_type" largest_lltype;
    let struct_lltype =  userdef_ty |> lltype_of_ty |> L.element_type in (* opaque type *)
    L.struct_set_body struct_lltype (L.struct_element_types largest_lltype) false; (* opaque type obtains body and becomes struct type *)
    print_lltype (S.name name_sym) struct_lltype
  
  and create_constr_named_struct_types () =
    let create_constr_named_struct_type (TA.Constr { name_sym; index }) lltype =
      let struct_name = llname_constr_of_constr_info name_sym userdef_ty in
      let struct_lltype = L.named_struct_type ctx struct_name in
      L.struct_set_body struct_lltype (L.struct_element_types lltype) false;
      print_lltype struct_name struct_lltype;
      tbl_add constr_info_tbl struct_name (index, L.pointer_type struct_lltype)
    in
    List.iter2 create_constr_named_struct_type constrs constr_lltypes
  
  and build_equality_fun () =
    (* store previous_block in order to return in the end *)
    let previous_block = builder |> L.insertion_block in

    (* declare function *)
    let userdef_struct_pointer = userdef_ty |> lltype_of_ty in
    let func_lltype = L.function_type bool_type [| userdef_struct_pointer; userdef_struct_pointer |] in
    let func_name = llname_equality_fun_of_userdef_ty userdef_ty in
    let func = L.declare_function func_name func_lltype the_module in

    (* create basic blocks entry, body, error, exit *)
    let entry_block = L.append_block ctx "entry" func in
    let body_block = L.append_block ctx "body" func in
    let error_block = L.append_block ctx "error" func in
    let exit_block = L.append_block ctx "exit" func in

    (* take param structs *)
    let s1 = L.param func 0 in
    let s2 = L.param func 1 in
    
    (* fill entry block *)
    L.position_at_end entry_block builder;

    let get_tag_of_struct s =  
      let tag_ptr = L.build_struct_gep s 0 "tag_ptr" builder in
      L.build_load tag_ptr "tag_load" builder
    in
    (* check whether tags are equal *)
    let s1_tag = get_tag_of_struct s1 in
    let s2_tag = get_tag_of_struct s2 in
    let same_tag_cond = L.build_icmp L.Icmp.Eq s1_tag s2_tag "same_tag_comp" builder in
    let entry_phi_pair = (const_bool false, entry_block) in
    ignore(L.build_cond_br same_tag_cond body_block exit_block builder);

    (* fill body block *)
    L.position_at_end body_block builder;
    (* create switch on tag value with default block the error block 
        and add a case for every constructor in the current type *)
    let switch = L.build_switch s1_tag error_block (List.length constrs) builder in
    
    (* create case and basic_block for every constructor and fill it's basic block *)
    let add_constr_to_switch (TA.Constr { ty; name_sym; index }) =
      let constr_name = llname_constr_of_constr_info name_sym userdef_ty in
      let constr_struct_pointer_lltype = match tbl_find_opt constr_info_tbl constr_name with
        | Some (_, lltype) -> lltype
        | None -> internal_error None "Constructor %s not yet defined in add_constr_to_switch" constr_name
      in

      (* create case block and add switch case *)
      let case_block = L.insert_block ctx ("case_" ^ constr_name) error_block in
      L.add_case switch (const_int index) case_block;
      
      (* fill case block *)
      L.position_at_end case_block builder;
      
      (* cast structs to current constructor *)
      let s1_constr_struct = L.build_pointercast s1 constr_struct_pointer_lltype "s1_constr_type_cast" builder in
      let s2_constr_struct = L.build_pointercast s2 constr_struct_pointer_lltype "s2_constr_type_cast" builder in
      
      (* take list of constr_param Types.tys *)
      let constr_param_tys = match ty with
        | T.CONSTR (param_tys, _, _) -> param_tys
        | _ as other_ty -> internal_error None "Constructor %s with invalid type: %s" constr_name (T.ty_to_string other_ty)
      in
      (* create list_pairs with constr_params_llvalues *)
      let load_from_constr_struct s idx =
        let ptr = L.build_struct_gep s idx "temp_constr_param_load_ptr" builder in
        L.build_load ptr "temp_constr_param_load" builder
      in
      let create_pair idx = load_from_constr_struct s1_constr_struct idx, load_from_constr_struct s2_constr_struct idx in
      let s1_s2_constr_param_pairs = List.mapi (fun i _ -> create_pair (i + 1)) constr_param_tys in
        
      (* create and of all constructor param comps *)
      let create_and prev_and param_ty (s1_constr_param, s2_constr_param) =
        let curr_cond = build_equality_check true s1_constr_param s2_constr_param param_ty in
        L.build_and prev_and curr_cond "temp_constr_param_and" builder
      in
      
      (* create equality value and branch to exit block *)
      let eq_cond = List.fold_left2 create_and (const_bool true) constr_param_tys s1_s2_constr_param_pairs in
      ignore(L.build_br exit_block builder);

      (* return phi pair to be used in exit block *)
      eq_cond, case_block
    
    in
    (* add all cases and blocks *)
    let case_phi_pairs = List.map add_constr_to_switch constrs in

    (* fill error block *)
    L.position_at_end error_block builder;
    build_runtime_error ("Invalid constructor of type " ^ (S.name name_sym) ^ " encountered in comparison operation");
    ignore(L.build_br error_block builder);

    (* fill exit block *)
    L.position_at_end exit_block builder;
    let phi_pairs = entry_phi_pair :: case_phi_pairs in
    let phi = L.build_phi phi_pairs "temp_phi" builder in
    ignore(L.build_ret phi builder);

    (* restore builder *)
    L.position_at_end previous_block builder
  in

  create_userdef_named_struct_type ();
  create_constr_named_struct_types ();
  build_equality_fun ()

let rec generate_ir (opt: bool) (tast: TA.tast) (info_tbl: Esc.info_tbl_t): L.llmodule =
  declare_external_functions ();
  build_utility_funs ();

  build_func_frame_vars ("entry_func", 0) (T.FUNC ([], T.INT)) info_tbl;

  let init_depth = 0 in
  List.iter (generate_ir_def (init_depth + 1) info_tbl) tast;
  
  build_func_return (const_int 0);

  match LAN.verify_module the_module with
  | None -> the_module
  | Some reason -> pprint the_module; internal_error None "Verification error: %s" reason
  
and generate_ir_def depth info_tbl = function
  | TA.LetDefNonRec { decs } ->
    List.iter (generate_ir_dec depth info_tbl) decs
  | TA.LetDefRec { decs } ->
    let declare_only_func = function 
      | TA.FunctionDec { ty; name_sym } -> ignore(declare_function name_sym ty) (* functions need to be parsed and declared *)
      | _ -> () (* others being in info_tbl are already allocated in entry block of current function *)
    in
    List.iter declare_only_func decs;
    List.iter (generate_ir_dec depth info_tbl) decs
  | TA.TypeDef { tdecs } ->
    let ensure_declared_userdef_type (TA.TypeDec { name_sym; constrs }) = 
      (* use lltype_of_ty to retrieve already declared type or declare new type.
        Types may be already declared when a var of custom type is found in the 
        escape or local vars of entry function *)
      constrs |> List.hd |> userdef_ty_of_constr |> lltype_of_ty |> ignore
    in
    List.iter ensure_declared_userdef_type tdecs; (* decalare non-yet-declared custom types *)
    List.iter create_named_type_structs_and_equality_fun tdecs (* create struct types for opaque declared userdef type and constructor types *)

and generate_ir_dec depth info_tbl = function
  | TA.ConstVarDec { ty; name_sym; value } ->
    let llvalue = generate_ir_expr depth info_tbl value in
    begin match value with
    | TA.E_String { value } ->
      (* String is represented as array of chars, so has lltype array struct. 
         llvalue found above, here is the array_ptr *)
      let struct_ptr_ptr = find_llvalue_ptr_of_var name_sym depth info_tbl in
      let struct_ptr_llty = lltype_of_ty ty in
      let str_size_with_zeros = String.length value + 1 in
      let array_size = const_int str_size_with_zeros in
      ignore(build_array_struct (S.name name_sym) struct_ptr_llty (Some struct_ptr_ptr) None (Some llvalue) [array_size])
    | _ ->
      let llvalue_ptr = find_llvalue_ptr_of_var name_sym depth info_tbl in
      ignore(L.build_store llvalue llvalue_ptr builder)
    end
  | TA.FunctionDec { ty; name_sym; params; body } ->
    let current_block = L.insertion_block builder in
    build_func_frame_vars name_sym ty info_tbl;
    List.iteri (generate_ir_param name_sym info_tbl depth) params;
    let ret_llvalue = generate_ir_expr (depth + 1) info_tbl body in
    build_func_return ret_llvalue;
    L.position_at_end current_block builder
  | TA.MutVarDec { ty; name_sym } ->
    let llvalue = L.const_null (lltype_of_ty ty) in
    let llvalue_ptr = find_llvalue_ptr_of_var name_sym depth info_tbl in
    ignore(L.build_store llvalue llvalue_ptr builder)
  | TA.ArrayDec { ty; name_sym; dims_len_exprs } ->
    let struct_ptr_ptr = find_llvalue_ptr_of_var name_sym depth info_tbl in
    let struct_ptr_llty = (lltype_of_ty ty) in
    let dims_len_llvalues = List.map (generate_ir_expr depth info_tbl) dims_len_exprs in
    ignore(build_array_struct (S.name name_sym) struct_ptr_llty (Some struct_ptr_ptr) None None dims_len_llvalues)
    
and generate_ir_param func_name_sym info_tbl depth param_index (Param { name_sym }) =
  let func = find_function_in_module (S.name func_name_sym) in
  let param_llvalue_ptr = find_llvalue_ptr_of_var name_sym depth info_tbl in
  let param_llvalue = L.param func param_index in
  ignore(L.build_store param_llvalue param_llvalue_ptr builder)

and generate_ir_expr depth info_tbl expr: L.llvalue =
  let rec generate_ir_expr_aux = function
  | TA.E_ID  { name_sym } ->
    let id_ptr = find_llvalue_ptr_of_var name_sym depth info_tbl in
    L.build_load id_ptr "temp_load" builder
  | TA.E_Int  { ty; value } -> 
    L.const_int (lltype_of_ty ty) value
  | TA.E_Float { ty; value } -> 
    L.const_float (lltype_of_ty ty) value
  | TA.E_Char { ty; value } -> 
    L.const_int (lltype_of_ty ty) (int_of_char value)
  | TA.E_String  { value } ->
    get_or_build_global_string_pointer value
  | TA.E_BOOL { ty; value } -> 
    L.const_int (lltype_of_ty ty) (if value then 1 else 0)
  | TA.E_Unit _ -> 
    unit_value
  | TA.E_ArrayRef { name_sym; exprs } ->
    (* create basic blocks array_ref_bound_check_failed, array_ref_bound_check_success *)
    let function_block = builder |> L.insertion_block |> L.block_parent in
    let array_failed_block = L.append_block ctx "array_ref_bound_check_failed" function_block in
    let array_success_block = L.append_block ctx "array_ref_bound_check_success" function_block in

    (* get array_struct_ptr and generate dim expressions *)
    let struct_ptr = find_llvalue_ptr_of_var name_sym depth info_tbl in
    let exprs_ll = List.map generate_ir_expr_aux exprs in
    
    (* bound check *)
    let load_from_array_struct idx =
      let ptr = L.build_struct_gep struct_ptr idx "temp_array_struct_ptr_load" builder in
      L.build_load ptr "temp_array_struct_load" builder
    in
    (* create and of all compares *)
    let create_and prev_and dim_size expr_num =
      (* 0 <= expr_num < dim_size *)
      let lower_cond = L.build_icmp L.Icmp.Sle (const_int 0) expr_num "array_lower_bound_check" builder in
      let lower_and = L.build_and prev_and lower_cond "temp_cond_lower_and" builder in
      let upper_cond = L.build_icmp L.Icmp.Slt expr_num dim_size "array_upper_bound_check" builder in
      L.build_and lower_and upper_cond "temp_cond_upper_and" builder
    in
    let dim_sizes_ll = List.mapi (fun i _ -> load_from_array_struct (i + 1)) exprs_ll in
    let bound_check = List.fold_left2 create_and (const_bool true) dim_sizes_ll exprs_ll in
    ignore(L.build_cond_br bound_check array_success_block array_failed_block builder);

    (* fill array_failed_block *)
    L.position_at_end array_failed_block builder;
    build_runtime_error "Out of bounds error in array ref call";
    ignore(L.build_br array_failed_block builder);

    (* fill array_success_block *)
    L.position_at_end array_success_block builder;
    (* define helper funcions *)
    let rec split_last_elem acc = function
      | [] -> internal_error None "empty list encountered in split_last_elem"
      | [x] -> List.rev acc, x
      | x :: xs -> split_last_elem (x :: acc) xs
    in
    let add_dim_offset prev_add expr dim_size =
      let dim_offset = L.build_mul expr dim_size "temp_dim_offset_mul" builder in
      L.build_add prev_add dim_offset "temp_add_array_index" builder
    in
    (* calculate array_index = last_expr_num + Σ(expr_num * dim_size) *)
    let first_exprs_ll, last_expr_ll = split_last_elem [] exprs_ll in
    let first_dim_sizes, _ = split_last_elem [] dim_sizes_ll in
    let array_index = List.fold_left2 add_dim_offset last_expr_ll first_exprs_ll first_dim_sizes in
    (* return requested array element pointer -- done with gep *)
    let array_ptr = load_from_array_struct 0 in
    L.build_gep array_ptr [| array_index |] "temp_array_element_gep" builder
  | TA.E_ArrayDim { dim; name_sym } ->
    (* bound check if 1 <= dim <= dimNum *)
    let struct_ptr = find_llvalue_ptr_of_var name_sym depth info_tbl in
    (* remove first element which is array pointer *)
    let dimNum = struct_ptr |> L.type_of |> L.struct_element_types |> Array.length |> fun d -> d - 1 in
    if dim < 1 || dim > dimNum
      then begin
        build_runtime_error "Out of bounds error in array dim call";
        (* dummy return llvalue *)
        const_int 0
        end
      else
        (* dim (as int constant >= 1) equals struct offset *)
        let dim_ptr = L.build_struct_gep struct_ptr dim "temp_struct_dim_ptr" builder in
        L.build_load dim_ptr "temp_struct_dim_load" builder
  | TA.E_New { ty } ->
    let malloc_ptr = L.build_malloc (lltype_of_ty ty) "temp_malloc_for_new" builder in
    L.build_load malloc_ptr "temp_malloc_load_for_new" builder
  | TA.E_Delete { expr } ->
    let llvalue = generate_ir_expr_aux expr in
    ignore(L.build_free llvalue builder);
    unit_value
  | TA.E_FuncCall { ty; name_sym; param_exprs } ->
    if is_unary_operator (S.name name_sym) 
      then build_unary_operator name_sym param_exprs generate_ir_expr_aux
    else if is_binary_operator (S.name name_sym)
      then build_binary_operator name_sym param_exprs generate_ir_expr_aux
    else
      let callee = find_function_in_module (S.name name_sym) in
      let param_llvalues = List.map generate_ir_expr_aux param_exprs in
      L.build_call callee (Array.of_list param_llvalues) "temp_call" builder
  | TA.E_ConstrCall { ty; name_sym; param_exprs; loc} ->
    let userdef_struct_pointer_lltype = lltype_of_ty ty in
    let userdef_struct_lltype = L.element_type userdef_struct_pointer_lltype in
    print_lltype ("userdef struct type:") userdef_struct_lltype;
    let llname = llname_constr_of_constr_info name_sym ty in
    let tag, constr_struct_pointer_lltype = match tbl_find_opt constr_info_tbl llname with
      | Some (tag, lltype) -> tag, lltype
      | None -> internal_error_of_msg_format (Some loc) "Some (tag, lltype)" "None" "constr_info_tbl" "pair"
    in
    print_lltype ("constr type: (tag = " ^ string_of_int tag ^ ")") constr_struct_pointer_lltype;

    (* allocate userdef struct *)
    let userdef_struct = build_alloca_end_of_entry_block userdef_struct_lltype ("temp_userdef_type:" ^ (S.name name_sym)) None in
    print_llvalue "userdef_struct" userdef_struct;
    
    (* store tag *)
    let tag_ptr = L.build_struct_gep userdef_struct 0 "userdef_struct_tag_ptr" builder in
    ignore(L.build_store (const_int tag) tag_ptr builder);

    if List.length param_exprs > 0 then begin
      (* allocate userdef struct pointer and store userdef struct *)
      let userdef_struct_pointer = build_alloca_end_of_entry_block userdef_struct_pointer_lltype ("temp_userdef_pointer_type:" ^ (S.name name_sym)) None in
      print_llvalue "userdef_struct_pointer" userdef_struct_pointer;
      ignore(L.build_store userdef_struct userdef_struct_pointer builder);

      (* cast userdef_struct pointer to specific constr struct pointer *)
      let constr_struct = L.build_pointercast userdef_struct_pointer constr_struct_pointer_lltype "userdef_to_constr_cast" builder in
      print_llvalue "casted_constr_struct" constr_struct;

      (* store all other parameters to constr_struct *)
      let param_llvalues = List.map generate_ir_expr_aux param_exprs in
      let store_to_constr_struct idx value =
        let ptr = L.build_struct_gep constr_struct idx "temp_constr_struct_store_ptr" builder in
        ignore(L.build_store value ptr builder)
      in
      List.iteri (fun idx llvalue -> store_to_constr_struct (idx + 1) llvalue) param_llvalues
    end;

    (* return the userdef struct *)
    userdef_struct
  | TA.E_LetIn { letdef; in_expr} ->
    generate_ir_def depth info_tbl letdef;
    generate_ir_expr depth info_tbl in_expr
  | TA.E_BeginEnd { expr } ->
    generate_ir_expr_aux expr
  | TA.E_MatchedIF { if_expr; then_expr; else_expr } ->
    (* build basic blocks then, else and merge *)
    let function_block = builder |> L.insertion_block |> L.block_parent in
    let then_block = L.append_block ctx "if_then" function_block in
    let else_block = L.append_block ctx "if_else" function_block in
    let merge_block = L.append_block ctx "if_merge" function_block in

    (* build condition *)
    let cond_llvalue = generate_ir_expr_aux if_expr in
    ignore(L.build_cond_br cond_llvalue then_block else_block builder);

    (* build then block *)
    L.position_at_end then_block builder;
    let then_llvalue = generate_ir_expr_aux then_expr in
    ignore(L.build_br merge_block builder);

    (* build else block *)
    L.position_at_end else_block builder;
    let else_llvalue = generate_ir_expr_aux else_expr in
    ignore(L.build_br merge_block builder);

    (* build phi node on merge block and return phi value *)
    L.position_at_end merge_block builder;
    L.build_phi [(then_llvalue, then_block); (else_llvalue, else_block)] "temp_phi" builder
  | TA.E_WhileDoDone  { while_expr; do_expr; loc} ->
    (* build basic blocks check, body and after *)
    let function_block = builder |> L.insertion_block |> L.block_parent in
    let check_block = L.append_block ctx "while_check" function_block in
    let body_block = L.append_block ctx "while_body" function_block in
    let after_block = L.append_block ctx "while_after" function_block in
    ignore(L.build_br check_block builder);

    (* build check block *)
    L.position_at_end check_block builder;
    let cond_llvalue = generate_ir_expr_aux while_expr in
    ignore(L.build_cond_br cond_llvalue body_block after_block builder);

    (* build body block *)
    L.position_at_end body_block builder;
    ignore(generate_ir_expr_aux do_expr);
    ignore(L.build_br check_block builder);

    (* position builder at after block and return unit value *)
    L.position_at_end after_block builder;
    unit_value
  | TA.E_ForDoDone { count_var_sym; start_expr; count_dir; end_expr; do_expr; loc } ->
    (* build basic blocks check, body and after *)
    let pre_loop_block = builder |> L.insertion_block in
    let function_block =  pre_loop_block |> L.block_parent in
    let check_block = L.append_block ctx "for_check" function_block in
    let body_block = L.append_block ctx "for_body" function_block in
    let after_block = L.append_block ctx "for_after" function_block in
    
    (* count_var and step value *)
    let count_var_ptr = find_llvalue_ptr_of_var count_var_sym depth info_tbl in
    let step_llvalue = const_int 1 in

    (* funs according to count direction *)
    let step_llfun, cond_llfun = match count_dir with
      | TA.TO _ -> L.build_add, L.build_icmp L.Icmp.Sle
      | TA.DOWNTO _ -> L.build_sub, L.build_icmp L.Icmp.Sge
    in
      
    (* build start and end values in current block *)
    let start_llvalue = generate_ir_expr_aux start_expr in
    let end_llvalue = generate_ir_expr_aux end_expr in
    ignore(L.build_br check_block builder);

    (* build check block *)
    L.position_at_end check_block builder;
    let loop_llvalue = L.build_empty_phi int_type "loop_var" builder in
    ignore(L.build_store loop_llvalue count_var_ptr builder);
    L.add_incoming (start_llvalue, pre_loop_block) loop_llvalue;
    let cond_llvalue = cond_llfun loop_llvalue end_llvalue "cond" builder in
    ignore(L.build_cond_br cond_llvalue body_block after_block builder);

    (* build body block *)
    L.position_at_end body_block builder;
    ignore(generate_ir_expr_aux do_expr);
    let next_llvalue = step_llfun loop_llvalue step_llvalue "next_loop_var" builder in
    L.add_incoming (next_llvalue, body_block) loop_llvalue;
    ignore(L.build_br check_block builder);

    (* position builder at after block and return unit value *)
    L.position_at_end after_block builder;
    unit_value
  | TA.E_MatchWithEnd { ty; match_expr; with_clauses; loc } ->
    let function_block = builder |> L.insertion_block |> L.block_parent in
    
    let rec create_match_check_blocks start finish acc =
      let block_name = "match_check_" ^ (string_of_int (start + 1)) in
      if start = finish then List.rev acc
      else create_match_check_blocks (start + 1) finish ((L.append_block ctx block_name function_block) :: acc)
    in 
    let prepend_index_string = List.mapi (fun i (b1, b2) -> (string_of_int (i + 1), b1, b2)) in

    (* generate ir for match value *)
    let match_llvalue = generate_ir_expr_aux match_expr in

    (* create match_check blocks for every clause and match failed block *)
    let match_check_blocks = create_match_check_blocks 0 (List.length with_clauses) [] in
    let match_failed_block = L.append_block ctx "match_failed" function_block in

    (* create (current, next) pairs of blocks for every clause *)
    let match_next_check_blocks = (List.tl match_check_blocks) @ [match_failed_block] in
    let match_block_pairs  = List.map2 (fun b1 b2 -> b1, b2) match_check_blocks match_next_check_blocks |> prepend_index_string in

    (* create finish block *)
    let match_finished_block = L.append_block ctx "match_finished" function_block in

    (* generate all clauses *)
    ignore(L.build_br (List.hd match_check_blocks) builder);
    let value_block_phi_pairs = List.map2 (generate_ir_clause match_llvalue match_finished_block) match_block_pairs with_clauses in

    (* fill match_failed block *)
    L.position_at_end match_failed_block builder;
    build_runtime_error "Given expression could not be matched with some clause";
    ignore(L.build_br match_failed_block builder);

    (* fill match_finished block *)
    L.position_at_end match_finished_block builder;
    L.build_phi value_block_phi_pairs "temp_match_phi" builder

  and generate_ir_clause match_llvalue match_finished_block (idx_str, match_check_block, next_match_check_block) = function
  | TA.BasePattClause { base_pattern; expr; loc } ->
    (* build basic blocks match_success *)
    let match_success_block = L.insert_block ctx ("match_success_" ^ idx_str) next_match_check_block in
    
    (* check if base_pattern matches expression and branch accordingly *)
    L.position_at_end match_check_block builder;
    let success_match_llvalue = generate_ir_base_pattern match_llvalue base_pattern in
    ignore(L.build_cond_br success_match_llvalue match_success_block next_match_check_block builder);

    (* fill success block *)
    L.position_at_end match_success_block builder;
    let success_llvalue = generate_ir_expr_aux expr in
    ignore(L.build_br match_finished_block builder);
    success_llvalue, match_success_block
  | TA.ConstrPattClause { constr_pattern; expr; loc } ->
    (* build basic blocks match_param_check and match_success *)
    let match_param_check_block = L.insert_block ctx ("match_param_check_" ^ idx_str) next_match_check_block in
    let match_success_block = L.insert_block ctx ("match_success_" ^ idx_str) next_match_check_block in

    (* check if constr_pattern matches expression and branch accordingly *)
    L.position_at_end match_check_block builder;
    let success_match_llvalue = generate_ir_constr_pattern match_llvalue match_param_check_block next_match_check_block constr_pattern in
    ignore(L.build_cond_br success_match_llvalue match_success_block next_match_check_block builder);

    (* fill success block *)
    L.position_at_end match_success_block builder;
    let success_llvalue = generate_ir_expr_aux expr in
    ignore(L.build_br match_finished_block builder);
    success_llvalue, match_success_block

  and generate_ir_base_pattern match_llvalue = function
  | TA.BP_INT { num } -> 
    L.build_icmp L.Icmp.Eq (const_int num) match_llvalue "pattern_comp" builder
  | TA.BP_FLOAT { num } -> 
    L.build_fcmp L.Fcmp.True (const_float num) match_llvalue "pattern_comp" builder
  | TA.BP_CHAR { chr } -> 
    L.build_icmp L.Icmp.Eq (const_char (int_of_char chr)) match_llvalue "pattern_comp" builder
  | TA.BP_BOOL { value } -> 
    L.build_icmp L.Icmp.Eq (const_bool value) match_llvalue "pattern_comp" builder
  | TA.BP_ID { name_sym; loc } ->
    let id_ptr = find_llvalue_ptr_of_var name_sym depth info_tbl in
    ignore(L.build_store match_llvalue id_ptr builder);
    const_bool true

  and generate_ir_constr_pattern match_llvalue match_param_check_block next_match_check_block (TA.CP_BASIC { ty; constr_sym; base_patterns; loc }) =
    let llname = llname_constr_of_constr_info constr_sym ty in
    let tag, constr_struct_pointer_lltype = match tbl_find_opt constr_info_tbl llname with
      | Some (tag, lltype) -> tag, lltype
      | None -> internal_error_of_msg_format (Some loc) "Some (tag, lltype)" "None" "constr_info_tbl" "pair"
    in

    (* check whether tags are equal *)
    let match_tag_ptr = L.build_struct_gep match_llvalue 0 "match_tag_ptr" builder in
    let match_tag = L.build_load match_tag_ptr "match_tag_load" builder in
    let match_cond = L.build_icmp L.Icmp.Eq (const_int tag) match_tag "tag_comp" builder in
    ignore(L.build_cond_br match_cond match_param_check_block next_match_check_block builder);

    (* fill match_param_check_block *)
    L.position_at_end match_param_check_block builder;

    (* cast userdef_struct pointer to specific constr struct pointer *)
    let match_constr_struct = L.build_pointercast match_llvalue constr_struct_pointer_lltype "matched_type_to_constr_cast" builder in
    print_llvalue "matched_casted_constr_struct" match_constr_struct;

    (* create list with match_llvalues of constructor params *)
    let load_from_constr_struct idx =
      let ptr = L.build_struct_gep match_constr_struct idx "temp_match_constr_param_load_ptr" builder in
      L.build_load ptr "temp_match_constr_param_load" builder
    in
    (* create and of all constructor params matches *)
    let create_and prev_and match_llvalue base_pattern = 
      let curr_cond = generate_ir_base_pattern match_llvalue base_pattern in
      L.build_and prev_and curr_cond "temp_constr_param_and" builder
    in
    let constr_params_of_match_llvalue = List.mapi (fun i _ -> load_from_constr_struct (i + 1)) base_patterns in
    (* return single condition of successful match or not *)
    List.fold_left2 create_and (const_bool true) constr_params_of_match_llvalue base_patterns
  in
  generate_ir_expr_aux expr
