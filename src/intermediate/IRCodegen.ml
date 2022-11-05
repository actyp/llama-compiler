module Env = Environment
module Esc = Escape
module H = Hashtbl
module L = Llvm
module LAN = Llvm_analysis
module LBE = Llvm_all_backends
module LIP = Llvm_ipo
module LSO = Llvm_scalar_opts
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

(** [internal_error_of_msg_format loc_opt expected found func_name] invokes [internal_error] with a
    specified msg_format: '[expected] found as [found] in [func_name]' *)
let internal_error_of_msg_format loc_opt expected found func_name = 
  let msg_fmt = expected ^^ " %s found as " ^^ found ^^ " in " ^^ func_name in
  internal_error loc_opt msg_fmt

(** [global_str_tbl] is the hashtbl holding mappings of strings to their llvalues, in order to
    reuse same strings *)
let global_str_tbl: (string, L.llvalue) H.t = H.create 512

(** [constr_info_tbl] is the hashtbl holding mappings of constructor full names to their (index, lltype) pair.
    Full name of a constructor is <typename:occ_num:constr_name>*)
let constr_info_tbl: (string, (int * L.lltype)) H.t = H.create 512

(** [tbl_add tbl key entry] adds or overwrites the mapping [key] -> [entry] in hashtbl [tbl] *)
let tbl_add tbl key entry = H.replace tbl key entry

(** [tbl_find_opt tbl key] returns an option of the mapping of [key] in hashtbl [tbl] *)
and tbl_find_opt tbl key = H.find_opt tbl key

let pprint_to_file (filename: string) (llmodule: L.llmodule): unit = L.print_module filename llmodule

let pprint (llmodule: L.llmodule): unit = pprint_to_file "-" llmodule

(** [print_lltype msg lltype] prints to stdout '[msg] lltype: [lltype]' and flushes stdout. 
    May be used for debugging purposes, justifying the immediate stdout flush *)
let print_lltype msg lltype = Printf.printf "%s lltype: %s\n" msg (L.string_of_lltype lltype); flush stdout
(** [print_llvalue msg llvalue] prints to stdout '[msg] llvalue: [llvalue]' and flushes stdout. 
    May be used for debugging purposes, justifying the immediate stdout flush *)
and print_llvalue msg llvalue = Printf.printf "%s llvalue: %s\n" msg (L.string_of_llvalue llvalue); flush stdout

(* llvm initial info and optimization functions *)
let _ = LBE.initialize()
let ll_target_triple = LTG.Target.default_triple ()
let ll_target = LTG.Target.by_triple ll_target_triple
let ll_machine = LTG.TargetMachine.create ~triple:ll_target_triple ll_target
let ll_data_layout = Llvm_target.TargetMachine.data_layout ll_machine
let ll_opt_funs = [
  (* IPO Transforms *)
  LIP.add_argument_promotion; LIP.add_constant_merge; LIP.add_merge_functions; LIP.add_dead_arg_elimination;
  LIP.add_function_attrs; LIP.add_function_inlining; LIP.add_always_inliner; LIP.add_global_dce;
  LIP.add_global_optimizer; LIP.add_prune_eh; LIP.add_ipsccp; LIP.add_strip_dead_prototypes; LIP.add_strip_symbols; 

  (* Scalar Transforms *)
  LSO.add_aggressive_dce; LSO.add_alignment_from_assumptions; LSO.add_cfg_simplification; LSO.add_dead_store_elimination;
  LSO.add_scalarizer; LSO.add_merged_load_store_motion; LSO.add_gvn; LSO.add_ind_var_simplification;
  LSO.add_instruction_combination; LSO.add_jump_threading; LSO.add_licm; LSO.add_loop_deletion; LSO.add_loop_idiom;
  LSO.add_loop_rotation; LSO.add_loop_reroll; LSO.add_loop_unroll; LSO.add_loop_unswitch; LSO.add_memcpy_opt;
  LSO.add_partially_inline_lib_calls; LSO.add_lower_atomic; LSO.add_lower_switch; LSO.add_memory_to_register_promotion;
  LSO.add_reassociation; LSO.add_sccp; LSO.add_scalar_repl_aggregation; LSO.add_scalar_repl_aggregation_ssa;
  LSO.add_lib_call_simplification; LSO.add_tail_call_elimination; LSO.add_memory_to_register_demotion;
  LSO.add_verifier; LSO.add_correlated_value_propagation; LSO.add_early_cse; LSO.add_lower_expect_intrinsic;
  LSO.add_lower_constant_intrinsics; LSO.add_type_based_alias_analysis; LSO.add_scoped_no_alias_alias_analysis;
  LSO.add_basic_alias_analysis; LSO.add_unify_function_exit_nodes
]

(** [ctx] is the global context used by llvm *)
let ctx = L.global_context ()
(** [the_module] is the single module used by llvm *)
let the_module = L.create_module ctx "llama"
(** [builder] is the builder used by llvm to move around and generate code *)
let builder = L.builder ctx

(* llvm type definitions *)
let int_type = L.integer_type ctx 64
and char_type = L.integer_type ctx 8
and bool_type = L.integer_type ctx 1
and float_type = L.float_type ctx
and struct_type = L.struct_type ctx
and generic_pointer_type = L.pointer_type (L.integer_type ctx 8)

(* llvm const_type functions *)
let const_int i = L.const_int int_type i
and const_char c = L.const_int char_type c
and const_bool b = L.const_int bool_type (if b then 1 else 0)
and const_float f = L.const_float float_type f

(* unit type and unit value *)
let unit_type = bool_type
let unit_value = L.const_null unit_type

(* set of strings for operator names and external function names *)
module StringSet = Set.Make(String)

(** [string_set_of_list] is an alias to create a new StringSet from the empty set *)
let string_set_of_list = List.fold_left (fun set str -> StringSet.add str set) StringSet.empty

(** [unary_operator_name_set] is the [StringSet] containing unary operator names *)
let unary_operator_name_set = string_set_of_list Env.unary_operator_names
(** [binary_operator_name_set] is the [StringSet] containing binary operator names *)
and binary_operator_name_set = string_set_of_list Env.binary_operator_names
(** [external_function_name_set] is the [StringSet] containing external function names *)
and external_function_name_set = string_set_of_list Env.external_function_names

(** [is_unary_operator name] checks if [name] is in [unary_operator_name_set] *)
let is_unary_operator name = StringSet.mem name unary_operator_name_set
(** [is_binary_operator name] checks if [name] is in [binary_operator_name_set] *)
and is_binary_operator name = StringSet.mem name binary_operator_name_set
(** [is_external_function name] checks if [name] is in [external_function_name_set] *)
and is_external_function name = StringSet.mem name external_function_name_set

(** [get_or_build_global_string_pointer string_value] gets already built or builds new global string
    and returns a pointer to it *)
let get_or_build_global_string_pointer string_value =
  match tbl_find_opt global_str_tbl string_value with
  | Some string_ptr -> string_ptr
  | None ->
    let string_ptr = L.build_global_stringptr string_value "str" builder in
    tbl_add global_str_tbl string_value string_ptr;
    string_ptr

(** [frame_types_display_array] is a reference to an array holding the runtime 
    specific frame types, with respect to display array struct in order to obtain
    and cast the generic frame pointers from display array *)
let frame_types_display_array: (L.lltype array) ref = ref [||]

(** [build_display_array info_tbl] initializes [display array] struct and [frame_types_display_array] 
    with size equal to the max declaration depth of the functions in [info_tbl]. Display array struct
    is an array of generic frame pointers. On function call, the called function saves the old frame
    pointer at index equal to its declaration depth, stores its frame pointer -- casted to i8* --
    and on return restores the old generic frame pointer *)
let build_display_array info_tbl =
  let max_func_dec_depth = 
    let max_dec_depth = ref 0 in
    let update_max_of_pair _ = function
      | Esc.LocalVarInfo _ | Esc.EscVarInfo _ -> ()
      | Esc.FuncInfo { dec_depth } -> if dec_depth > !max_dec_depth then max_dec_depth := dec_depth
    in
    H.iter update_max_of_pair info_tbl;
    !max_dec_depth + 1
  in
  (* fill frame_types array with dummy type *)
  frame_types_display_array := Array.make max_func_dec_depth unit_type;
  let array_lltype = L.array_type generic_pointer_type max_func_dec_depth in
  ignore(L.define_global "display_array" (L.const_null array_lltype) the_module)

(** [load_from_display_array index] returns a generic frame pointer from display array at index [index].
    The user of this function is responsible to obtain the specific frame pointer type and cast the
    returned pointer accordingly, if needed *)
let load_from_display_array index =
  let display_array = match L.lookup_global "display_array" the_module with
    | None -> internal_error None "display array undefined in load_from_display_array"
    | Some llvalue -> llvalue
  in
  let elem_ptr = L.build_gep display_array [| const_int 0; const_int index |] "temp_display_array_element_gep" builder in
  L.build_load elem_ptr "display_array_ptr_load" builder

(** [store_to_display_array index frame_ptr] returns unit and stores to [frame_types_display_array] 
    the specific type of [frame_ptr] and then after casting the [frame_ptr] to i8* it stores it to
    display_array at index [index]. The user of this function is responsible to obtain the save the
    previous generic frame_ptr in display_array at index [index], in order to restore it later *)
let store_to_display_array index frame_ptr =
  (* update frame types *)
  Array.set !frame_types_display_array index (L.type_of frame_ptr);
  let display_array = match L.lookup_global "display_array" the_module with
    | None -> internal_error None "display array undefined in store_to_display_array"
    | Some llvalue -> llvalue
  in
  let elem_ptr = L.build_gep display_array [| const_int 0; const_int index |] "temp_display_array_element_gep" builder in
  let casted_frame_ptr = L.build_bitcast frame_ptr generic_pointer_type "casted_elem_frame_ptr" builder in
  ignore(L.build_store casted_frame_ptr elem_ptr builder)

(** [llname_userdef_of_userdef_ty ty] returns the full name of userdef type [ty], which is 'name:occ_num' *)
let rec llname_userdef_of_userdef_ty = function
  | T.USERDEF (name_sym, occ_num) -> (S.name name_sym) ^ ":" ^ (string_of_int occ_num)
  | _ -> internal_error_of_msg_format None "USERDEF" "other type" "llname_userdef_of_userdef_ty" "type"

(** [llname_constr_of_constr_info name_sym userdef_ty] returns the full name of a constructor from its [name_sym]
    and [userdef_ty], which is 'userdef_ty_name:occ_num:constr_name' *)
and llname_constr_of_constr_info name_sym userdef_ty =
  let userdef_ty_name =  llname_userdef_of_userdef_ty userdef_ty in
  userdef_ty_name ^ ":" ^ (S.name name_sym)

(** [llname_equality_fun_of_userdef_ty ty] returns the name of equality function for the userdef_ty [ty],
    which is '_<userdef_ty_name:occ_num>_equality_fun' *)
and llname_equality_fun_of_userdef_ty = function
  | T.USERDEF _ as ty -> "_" ^ (llname_userdef_of_userdef_ty ty) ^ "_equality"
  | _ -> internal_error_of_msg_format None "USERDEF" "other type" "llname_equality_fun_of_userdef_ty" "type"

(** [userdef_ty_of_constr_ty ty] returns the userdef ty of given constr ty [ty] *)
and userdef_ty_of_constr_ty = function
  | T.CONSTR (_, ty) -> ty
  | _ -> internal_error_of_msg_format None "CONSTR" "other type" "userdef_ty_of_constr_ty" "type"

(** [userdef_ty_of_constr c] returns the userdef ty of given TA.constr [c] *)
and userdef_ty_of_constr (TA.Constr { ty }) =
  userdef_ty_of_constr_ty ty

(** [lltype_of_ty ty] returns the corresponding lltype of given Types.ty [ty] *)
let rec lltype_of_ty: T.ty -> L.lltype = function
  | T.UNIT -> unit_type
  | T.INT -> int_type
  | T.CHAR -> char_type
  | T.BOOL -> bool_type
  | T.FLOAT -> float_type
  | T.REF ty| T.DYN_REF ty -> L.pointer_type (lltype_of_ty ty)
  | T.ARRAY (dims, ty) ->
    (* array type is a pointer to a struct { pointer to array, dim1 size, ..., dimN size } *)
    let rec gen_int_type_list curr_dim curr_tys = 
      if curr_dim = dims then curr_tys else gen_int_type_list (curr_dim + 1) (int_type :: curr_tys)
    in
    let array_ptr = L.pointer_type(lltype_of_ty ty) in
    let struct_elem_list = array_ptr :: (gen_int_type_list 0 []) in
    struct_type (Array.of_list struct_elem_list) |> L.pointer_type
  | T.FUNC (param_tys, ret_ty) ->
    (* function type is a pointer to an llvm function type*)
    let param_lltypes = Array.of_list (List.map lltype_of_ty param_tys) in
    let ret_lltype = lltype_of_ty ret_ty in
    L.function_type ret_lltype param_lltypes |> L.pointer_type
  | T.USERDEF (name_sym, occ_num) as ty -> 
    (* userdef type is pointer to a named struct, 'name:occ_num' = { int_tag; largest constructor type size } 
       (implementing tagged union), created elsewhere and only queried from here *)
    let userdef_type_name = llname_userdef_of_userdef_ty ty in
    begin match L.type_by_name the_module userdef_type_name with
      | Some lltype -> L.pointer_type lltype
      | None -> L.pointer_type (L.named_struct_type ctx userdef_type_name) (* just declare the opaque type *)
    end
  | T.CONSTR (param_tys, userdef_ty) ->
    (* type constructor is pointer to a struct { int_tag; param_ty1; ...,  param_tyN} 
       following on the implementation of tagged union *)
    let param_lltypes = List.map lltype_of_ty param_tys in
    struct_type (Array.of_list (int_type :: param_lltypes)) |> L.pointer_type
  | T.VAR _ -> unit_type
  | T.POLY _ -> internal_error None "poly type encountered in lltype_of_ty"

(** [declare_external_functions ()] iterates and declares the external functions Env.external_functions *)
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

(** [declare_function name_sym func_ty] declares function with Types.ty [func_ty] and name taken from [name_sym] *)
and declare_function name_sym func_ty =
  let func_internal_error expected found name_sym =
    internal_error_of_msg_format None expected found "declare_function" (S.name name_sym)
  in
  let func_type = match func_ty with
    | T.FUNC _ -> lltype_of_ty func_ty |> L.element_type
    | _ -> func_internal_error "Types.FUNC" "other type" name_sym
  in
  let func = L.declare_function (S.name name_sym) func_type the_module in
  func

(** [build_utility_funs ()] builds some utility functions, specifically
    - declares: GC_init, GC_malloc, GC_register_finalizer
    - defines: _free_array_of_malloc, _runtime_error, _binary_int_division, _binary_float_division *)
and build_utility_funs () =
  let void_type = L.void_type ctx
  in
  let declare_garbage_collection_funs () =  
    (* declare GC_init *)
    let func_lltype = L.function_type generic_pointer_type [| |] in
    ignore(L.declare_function "GC_init" func_lltype the_module);

    (* declare GC_malloc *)
    let func_lltype = L.function_type generic_pointer_type [| int_type |] in
    ignore(L.declare_function "GC_malloc" func_lltype the_module);

    (* declare GC_register_finalizer *)
    let func_ptr_type = L.function_type void_type [| generic_pointer_type; generic_pointer_type |] |> L.pointer_type in
    let func_params =
      [|
        generic_pointer_type; (* object pointer -- obj_ptr *)
        func_ptr_type; (* register function to use f(obj_ptr, cd_ptr) *)
        generic_pointer_type; (* cd pointer -- cd_ptr -- may be NULL *)
        L.pointer_type func_ptr_type; (* pointer to old func pointer -- may be NULL *)
        L.pointer_type generic_pointer_type (* pointer to old cd pointer -- may be NULL *)
      |]
    in
    let func_lltype = L.function_type void_type func_params in
    ignore(L.declare_function "GC_register_finalizer" func_lltype the_module)
  in
  let build_free_array_of_malloc_fun () = 
    (* declare function *)
    let func_name = "_free_array_of_malloc" in
    let func_lltype = L.function_type void_type [| generic_pointer_type; generic_pointer_type |] in
    let func = L.declare_function func_name func_lltype the_module in

    (* create basic_block entry *)
    let entry_block = L.append_block ctx "entry" func in

    (* take first param -- uncasted array_struct_ptr *)
    let generic_ptr = L.param func 0 in
    let cast_type = struct_type [| generic_pointer_type; int_type |] |> L.pointer_type in

    (* fill entry_block *)
    L.position_at_end entry_block builder;
    let array_struct_ptr = L.build_bitcast generic_ptr cast_type "array_struct_ptr" builder in
    let malloc_array_ptr_gep = L.build_struct_gep array_struct_ptr 0 "malloc_array_ptr_gep" builder in
    let malloc_array_ptr = L.build_load malloc_array_ptr_gep "malloc_array_ptr" builder in
    ignore(L.build_free malloc_array_ptr builder);
    ignore(L.build_ret_void builder)
  in
  let build_runtime_error_fun () =
    (* declare function *)
    let func_name = "_runtime_error" in
    let func_lltype = L.function_type void_type [| L.pointer_type char_type; int_type |] in
    let func = L.declare_function func_name func_lltype the_module in

    (* create basic_block entry *)
    let entry_block = L.append_block ctx "entry" func in

    (* take params *)
    let array_ptr = L.param func 0 in
    let array_size = L.param func 1 in

    (* fill entry_block *)
    L.position_at_end entry_block builder;
    (* build array struct *)
    let struct_ptr_llty = lltype_of_ty Env.array_of_char_ty in
    let struct_ptr = build_array_struct "array_struct_ptr" struct_ptr_llty None None (Some array_ptr) [array_size] in
    
    (* build error code *)
    let error_code = const_int 1 in

    (* find and call external function 'lla_exit_with_error_call' *)
    let func = find_function_in_module "lla_exit_with_error" in
    ignore(L.build_call func [| struct_ptr; error_code |] "lla_exit_with_error_call" builder);
    ignore(L.build_ret_void builder)
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
    ignore(L.build_ret ret builder)
  in
  declare_garbage_collection_funs ();
  build_free_array_of_malloc_fun ();
  build_runtime_error_fun ();
  build_division_fun ("_binary_int_division", 0) int_type (L.build_icmp L.Icmp.Eq (const_int 0)) L.build_sdiv;
  build_division_fun ("_binary_float_division", 0)  float_type (L.build_fcmp L.Fcmp.Oeq (const_float 0.0)) L.build_fdiv

(** [build_runtime_error msg] generates ir in order to call '_runtime_error' function *)
and build_runtime_error msg =
  (* get or build error char array *)
  let error_str = "Runtime Error: " ^ msg ^ "\n" in
  let str_size_with_zeros = String.length error_str + 1 in
  let array_ptr = get_or_build_global_string_pointer error_str in
  let array_size = const_int str_size_with_zeros in

  (* find and call util function '_runtime_error' *)
  let func = find_function_in_module "_runtime_error" in
  ignore(L.build_call func [| array_ptr; array_size |] "" builder)

(** [find_function_in_module name] returns the llvalue of function [name] *)
and find_function_in_module name =
  (* add 'lla_' prefix in case of external function *)
  let func_name = if is_external_function name then "lla_" ^ name else name in
  match L.lookup_function func_name the_module with
    | Some f -> f
    | None -> internal_error None "function %s not found in the_module" name

(** [build_gc_malloc lltype name casted_res array_size_opt] build a call to GC_malloc of size of [lltype],
    or of array_size -- if provided as option. If [casted_res] is true the returned i8* from function call
    is casted to lltype* (same behaviour as L.build_malloc) before return, else i8* is returned *)
and build_gc_malloc lltype name casted_res array_size_opt =
  let llsize = match array_size_opt with
    | Some size -> size
    | None ->
      let abi_size_of llty = LTG.DataLayout.abi_size llty ll_data_layout |> Int64.to_int in
      lltype |> abi_size_of |> const_int
  in
  let func = find_function_in_module "GC_malloc" in
  let malloc_ptr = L.build_call func [| llsize |] "GC_malloc_call" builder in
  if casted_res
  then
    (* return an lltype_ptr, same as normal malloc. e.g. for lltype = i8* return i8** *)
    let cast_type = L.pointer_type lltype in
    L.build_bitcast malloc_ptr cast_type name builder
  else
    malloc_ptr

(** [build_gc_register_finalizer gc_malloc_ptr] registers the function [_free_array_of_malloc] as finalizer at [gc_malloc_ptr].
    The provided [gc_malloc_ptr] is only useful when the cast to {i8*, i64}* can be performed. The [_free_array_of_malloc]
    function will cast the [gc_malloc_ptr] to {i8*, i64}* and take its i8*. This pointer should point at non-garbage-collected
    heap allocated with normal malloc *)
and build_gc_register_finalizer gc_malloc_ptr =
  let func = find_function_in_module "GC_register_finalizer" in
  let free_func = find_function_in_module "_free_array_of_malloc" in
  let null_ptr = generic_pointer_type |> L.const_null  in
  let null_ptr_ptr = generic_pointer_type |> L.pointer_type  |> L.const_null in
  let null_func_ptr_ptr = free_func |> L.type_of |> L.pointer_type |> L.const_null in
  ignore(L.build_call func [| gc_malloc_ptr; free_func; null_ptr; null_func_ptr_ptr; null_ptr_ptr |] "" builder)

(** [build_func_frame_vars name_sym func_ty info_tbl] declares the function if needed, builds its basic blocks,
    builds its function frame with escaping variables, allocates its local variables in entry block *)
and build_func_frame_vars name_sym func_ty info_tbl =
  let func_internal_error expected found name_sym =
    internal_error_of_msg_format None expected found "build_func_frame_vars" (S.name name_sym)
  in
  let func_dec_depth, local_list, esc_list = match Esc.tbl_find_opt info_tbl name_sym with
    | None -> func_internal_error "function" "None" name_sym
    | Some Esc.LocalVarInfo _ -> func_internal_error "function" "LocalVarInfo" name_sym
    | Some Esc.EscVarInfo _ -> func_internal_error "function" "EscVarInfo" name_sym
    | Some Esc.FuncInfo { dec_depth; local_list; esc_list } -> dec_depth, local_list, esc_list
  in
  let build_frame_alloc esc_list =
    let prev_frame_ptr = load_from_display_array func_dec_depth in
    let esc_list_lltypes = List.map (fun (_, ty) -> lltype_of_ty ty) esc_list in
    (* allocate new frame in stack, because it won't outlive its function *)
    let frame_type = struct_type (Array.of_list esc_list_lltypes) in
    let frame_ptr = L.build_alloca frame_type (S.name name_sym ^ ":frame_ptr") builder in
    (* store frame_ptr to display array *)
    store_to_display_array func_dec_depth frame_ptr;
    prev_frame_ptr
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
  (* in case of main function call GC_init *)
  let _ = if (S.name name_sym) = "main" then
    let func = find_function_in_module "GC_init" in
    ignore(L.build_call func [| |] "" builder)
  in
  let prev_frame_ptr = build_frame_alloc esc_list in
  alloc_locals local_list;
  ignore(L.build_br body_block builder);
  ignore(L.position_at_end body_block builder);
  func_dec_depth, prev_frame_ptr

(** [find_llvalue_ptr name_sym current_depth info_tbl on_call] searches in [info_tbl] to find the llvalue
    of the varible with name from [name_sym]. [current_depth] is used in case of escaping variable to 
    traverse through function frames and [on_call] is used when searching a function llvalue, in case of
    searching in order not to call the function, a function pointer is returned else the function itself *)
and find_llvalue_ptr name_sym current_depth info_tbl on_call = 
  let func_internal_error expected found =
    internal_error_of_msg_format None expected found "find_llvalue_ptr" (S.name name_sym)
  in
  let rec find_declaration_frame_ptr dec_depth =
    let parent_depth = dec_depth - 1 in
    let generic_frame_ptr = load_from_display_array parent_depth in
    let frame_type = Array.get !frame_types_display_array parent_depth in
    L.build_bitcast generic_frame_ptr frame_type "casted_frame_ptr" builder
  in
  match Esc.tbl_find_opt info_tbl name_sym with
  | None -> func_internal_error "var" "None"
  | Some Esc.FuncInfo _ ->
    find_function_in_module (S.name name_sym)
  | Some Esc.LocalVarInfo { ty; llvalue_opt } ->
    (* assuming info_tbl is correct, a local is found only in local scope while parsing *)
    begin match llvalue_opt with
    | None -> func_internal_error "local" "None" (* should have been allocated on its function entry block *)
    | Some llvalue_ptr -> match ty with
      (* llvalue_ptr is function pointer so if on_call load function else return function pointer *)
      | T.FUNC _ -> if on_call then L.build_load llvalue_ptr "function_param_temp_load" builder else llvalue_ptr
      | _ -> llvalue_ptr
    end
  | Some Esc.EscVarInfo { ty; dec_depth; frame_offset } ->
    let name = S.name name_sym in
    let dec_frame_ptr = find_declaration_frame_ptr dec_depth in
    let load_ptr = L.build_struct_gep dec_frame_ptr frame_offset (name ^ ":temp_gep") builder in
    match ty with
      (* load_ptr is function pointer so if on_call load function else return function pointer *)
      | T.FUNC _ -> if on_call then L.build_load load_ptr "function_param_temp_load" builder else load_ptr
      | _ -> load_ptr

(** [build_func_return ret_llvalue] generates ir for the return expression of current function, returning value [ret_llvalue] 
    and pops its function frame from [function_frames] *)
and build_func_return (func_dec_depth, prev_frame_ptr) ret_llvalue =
  store_to_display_array func_dec_depth prev_frame_ptr;
  ignore(L.build_ret ret_llvalue builder)
  
(** [build_array_struct struct_ptr_name struct_ptr_llty struct_ptr_ptr_opt struct_ptr_opt array_ptr_opt dims_len_llvalues] 
    generates ir and builds the struct_ptr pointing to struct like {[array_ptr]; dim_llvalue1; dim_llvalue2; ...; dim_llvalueN}
    having name [struct_ptr_name]. Parameters are options, which if provided they are assembled together and not generated from scratch.
    [dims_len_llvalues] is a list of llvalues regarding dim sizes of the array pointed by array_ptr. [struct_ptr_ptr_opt] is an option
    for struct_pointer_pointer, which if provided the struct_ptr_ptr is made to point to newly generated struct, else nothing happens *)
and build_array_struct struct_ptr_name struct_ptr_llty struct_ptr_ptr_opt struct_ptr_opt array_ptr_opt dims_len_llvalues =
  let store_to_struct ll_struct index value =
    let ptr = L.build_struct_gep ll_struct index "temp_struct_store_ptr" builder in
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
      let func = builder |> L.insertion_block |> L.block_parent in
      let array_failed_block = L.append_block ctx "array_dec_dim_check_failed" func in
      let array_success_block = L.append_block ctx "array_dec_dim_check_success" func in

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
      let elem_type = struct_llty |> L.struct_element_types |> fun arr -> Array.get arr 0 |> L.element_type in
      (*  allocate array in non-garbage-collected heap using normal malloc, because of misbehaviour on allocating it
          on garbage-collected heap, thus this array will be deallocated upon garbage-collection of the whole struct
          and after calling the registered finalizer function to free the heap allocated memory of malloc. *)
      L.build_array_malloc elem_type array_size "array_ptr" builder
  in
  (* get or build struct *)
  let struct_ptr = match struct_ptr_opt with
    | Some ptr -> ptr
    | None -> 
      let malloc_ptr = build_gc_malloc struct_llty struct_ptr_name false None in
      (* register finalizer to act upon garbage collection *)
      build_gc_register_finalizer malloc_ptr;
      (* return casted pointer *)
      let cast_type = L.pointer_type struct_llty in
      L.build_bitcast malloc_ptr cast_type struct_ptr_name builder
  in
  (* store struct in possible provided struct_ptr_ptr *)
  let _ = match struct_ptr_ptr_opt with
    | None -> ()
    | Some struct_ptr_ptr -> ignore(L.build_store struct_ptr struct_ptr_ptr builder);
  in
  List.iteri (fun i llv -> store_to_struct struct_ptr i llv) (array_ptr :: dims_len_llvalues);
  struct_ptr

(** [build_equality_check is_struct p1_ll p2_ll] generates ir for the equality of llvalues
    [p1_ll] and [p2_ll]. [is_struct], if true, refers to structural equality (=) else to 
    natural equality (==) *)
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

(** [build_unary_operator name_sym param_exprs generate_ir_fun] generate ir for the unary_operator
  with name in [name_sym] and single TA.expr in [param_exprs] provided the function to generate ir
  for the param_expr [generate_ir_fun] *)
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
    | "( ~-. )" -> L.build_fmul (const_float (-1.0)) param_ll "unary_float_neg_mul" builder
    | "( ! )" -> L.build_load param_ll "unary_ref" builder
    | "( not )" -> L.build_not param_ll "unary_not" builder
    | _ -> internal_error None "unsupported unary operator: %s" op_name

(** [build_binary_operator name_sym param_exprs generate_ir_fun] generate ir for the binary_operator
  with name in [name_sym] and two TA.expr in [param_exprs] provided the function to generate ir
  for the param_exprs [generate_ir_fun] *)
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
    let func = current_block |> L.block_parent in
    let non_short_block = L.append_block ctx "logical_non_short_circuit" func in
    let continue_block = L.append_block ctx "logical_continue" func in
    
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

(** [create_named_type_structs_and_equality_fun tdec] fills the opaque types of the userdef struct type and
    constructor struct types and creates the type equality function of TA.TypeDec [tdec] *)
and create_named_type_structs_and_equality_fun (TA.TypeDec { name_sym; constrs }) =
  let userdef_ty =  constrs |> List.hd |> userdef_ty_of_constr in
  let constr_lltypes = List.map (fun (TA.Constr { ty }) -> lltype_of_ty ty |> L.element_type) constrs in

  let create_userdef_named_struct_type () =
    let abi_size_of llty = LTG.DataLayout.abi_size llty ll_data_layout |> Int64.to_int in
    let largest_lltype_of t1 t2 = if (abi_size_of t1) > (abi_size_of t2) then t1 else t2 in
    let largest_lltype = List.fold_left largest_lltype_of (List.hd constr_lltypes) constr_lltypes in
    (* opaque type *)
    let struct_lltype =  userdef_ty |> lltype_of_ty |> L.element_type in
    (* opaque type obtains body and becomes struct type *)
    L.struct_set_body struct_lltype (L.struct_element_types largest_lltype) false
  
  and create_constr_named_struct_types () =
    let create_constr_named_struct_type (TA.Constr { name_sym; index }) lltype =
      let struct_name = llname_constr_of_constr_info name_sym userdef_ty in
      let struct_lltype = L.named_struct_type ctx struct_name in
      L.struct_set_body struct_lltype (L.struct_element_types lltype) false;
      (* tag == index + 1, because index is zero-based and tag is not *)
      tbl_add constr_info_tbl struct_name (index + 1, L.pointer_type struct_lltype)
    in
    List.iter2 create_constr_named_struct_type constrs constr_lltypes
  
  and build_equality_fun () =
    (* store previous_block in order to return in the end *)
    let previous_block = builder |> L.insertion_block in

    (* get already declared function *)
    let func_name = llname_equality_fun_of_userdef_ty userdef_ty in
    let func = find_function_in_module func_name in

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
    
    (* create case and basic_block for every constructor and fill its basic block *)
    let add_constr_to_switch (TA.Constr { ty; name_sym; index }) =
      let constr_name = llname_constr_of_constr_info name_sym userdef_ty in
      let constr_struct_pointer_lltype = match tbl_find_opt constr_info_tbl constr_name with
        | Some (_, lltype) -> lltype
        | None -> internal_error None "Constructor %s not yet defined in add_constr_to_switch" constr_name
      in

      (* create case block and add switch case *)
      let case_block = L.insert_block ctx ("case_" ^ constr_name) error_block in
      let tag_llvalue = const_int (index + 1) in
      L.add_case switch tag_llvalue case_block;
      
      (* fill case block *)
      L.position_at_end case_block builder;
      
      (* cast structs to current constructor *)
      let s1_constr_struct = L.build_pointercast s1 constr_struct_pointer_lltype "s1_constr_type_cast" builder in
      let s2_constr_struct = L.build_pointercast s2 constr_struct_pointer_lltype "s2_constr_type_cast" builder in
      
      (* take list of constr_param Types.tys *)
      let constr_param_tys = match ty with
        | T.CONSTR (param_tys, _) -> param_tys
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
  build_display_array info_tbl;
  declare_external_functions ();
  build_utility_funs ();

  let prev_frame_info = build_func_frame_vars ("main", 0) (T.FUNC ([], T.INT)) info_tbl in
  
  (* generate ir for the program -- body of main function *)
  let init_depth = 0 in
  List.iter (generate_ir_def (init_depth + 1) info_tbl) tast;
  
  build_func_return prev_frame_info (const_int 0);

  (* check for optimizations *)
  let _ = if opt then begin
    let pm = L.PassManager.create () in
    List.iter (fun opt_f -> opt_f pm) ll_opt_funs;
    ignore(L.PassManager.run_module the_module pm);
  end
  in
  
  (* verify and return module *)
  match LAN.verify_module the_module with
  | None -> the_module
  | Some reason -> pprint the_module; internal_error None "Verification error: %s" reason

(** [generate_ir_def depth info_tbl def] generates ir for the given TA.def [def] in current_depth [depth], with [info_tbl] *)
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
      let userdef_ty = constrs |> List.hd |> userdef_ty_of_constr in
      let userdef_struct_pointer =  lltype_of_ty userdef_ty in
      (* declare equality function also, in case of recursive types *)
      let func_lltype = L.function_type bool_type [| userdef_struct_pointer; userdef_struct_pointer |] in
      let func_name = llname_equality_fun_of_userdef_ty userdef_ty in
      ignore(L.declare_function func_name func_lltype the_module)
    in
    List.iter ensure_declared_userdef_type tdecs; (* decalare non-yet-declared custom types *)
    List.iter create_named_type_structs_and_equality_fun tdecs (* create struct types for opaque declared userdef type and constructor types *)

(** [generate_ir_dec depth info_tbl dec] generates ir for the given TA.dec [dec] in current_depth [depth], with [info_tbl] *)
and generate_ir_dec depth info_tbl = function
  | TA.ConstVarDec { name_sym; value } ->
    let llvalue = generate_ir_expr depth info_tbl value in
    let llvalue_ptr = find_llvalue_ptr name_sym depth info_tbl false in
    ignore(L.build_store llvalue llvalue_ptr builder)
  | TA.FunctionDec { ty; name_sym; params; body } ->
    let current_block = L.insertion_block builder in
    let prev_frame_info = build_func_frame_vars name_sym ty info_tbl in
    List.iteri (generate_ir_param name_sym depth info_tbl) params;
    let ret_llvalue = generate_ir_expr (depth + 1) info_tbl body in
    build_func_return prev_frame_info ret_llvalue;
    L.position_at_end current_block builder
  | TA.MutVarDec { ty; name_sym } ->
    let lltype = lltype_of_ty ty |> L.element_type in
    let llvalue_ptr_ptr = find_llvalue_ptr name_sym depth info_tbl false in
    let llvalue_ptr_name = (S.name name_sym) ^ "_alloca_ptr" in
    (* allocate value to garbage-collected-heap *)
    let llvalue_ptr = build_gc_malloc lltype llvalue_ptr_name true None in
    ignore(L.build_store llvalue_ptr llvalue_ptr_ptr builder)
  | TA.ArrayDec { ty; name_sym; dims_len_exprs } ->
    let struct_ptr_ptr = find_llvalue_ptr name_sym depth info_tbl false in
    let struct_ptr_llty = (lltype_of_ty ty) in
    let struct_ptr_name = (S.name name_sym) ^ "_struct_ptr" in
    let dims_len_llvalues = List.map (generate_ir_expr depth info_tbl) dims_len_exprs in
    ignore(build_array_struct struct_ptr_name struct_ptr_llty (Some struct_ptr_ptr) None None dims_len_llvalues)

(** [generate_ir_param depth info_tbl param_index param] generates ir for the given TA.param [param] of function with symbol [func_sym],
    having param index [param_index] in current_depth [depth], with [info_tbl] *)
and generate_ir_param func_name_sym depth info_tbl param_index (Param { name_sym }) =
  let func = find_function_in_module (S.name func_name_sym) in
  let param_llvalue_ptr = find_llvalue_ptr name_sym depth info_tbl false in
  let param_llvalue = L.param func param_index in
  ignore(L.build_store param_llvalue param_llvalue_ptr builder)

(** [generate_ir_expr depth info_tbl expr] generates ir for the given TA.expr [expr] in current_depth [depth], with [info_tbl]
    and returns the generated llvalue of the expression *)
and generate_ir_expr depth info_tbl expr: L.llvalue =
  let rec generate_ir_expr_aux = function
  | TA.E_ID  { ty; name_sym } ->
    let llvalue_ptr = find_llvalue_ptr name_sym depth info_tbl false in
    begin match ty with
      | T.FUNC _ -> llvalue_ptr (* return function pointer and do not load the function *)
      | _ -> L.build_load llvalue_ptr "temp_id_load" builder
    end
  | TA.E_Int  { ty; value } -> 
    L.const_int (lltype_of_ty ty) value
  | TA.E_Float { ty; value } -> 
    L.const_float (lltype_of_ty ty) value
  | TA.E_Char { ty; value } -> 
    L.const_int (lltype_of_ty ty) (int_of_char value)
  | TA.E_String  { ty; value } ->
    (* create or get char array pointer and create its size *)
    let array_ptr = get_or_build_global_string_pointer value in
    let str_size_with_zeros = String.length value + 1 in
    let array_size = const_int str_size_with_zeros in
    (* create struct info *)
    let struct_ptr_llty = lltype_of_ty ty in
    let struct_ptr_name = "string_struct_ptr" in
    (* create and fill struct with array_ptr and size and return struct_ptr *)
    build_array_struct struct_ptr_name struct_ptr_llty None None (Some array_ptr) [array_size]
  | TA.E_BOOL { ty; value } -> 
    L.const_int (lltype_of_ty ty) (if value then 1 else 0)
  | TA.E_Unit _ -> 
    unit_value
  | TA.E_ArrayRef { name_sym; exprs } ->
    (* create basic blocks array_ref_bound_check_failed, array_ref_bound_check_success *)
    let func = builder |> L.insertion_block |> L.block_parent in
    let array_failed_block = L.append_block ctx "array_ref_bound_check_failed" func in
    let array_success_block = L.append_block ctx "array_ref_bound_check_success" func in

    (* get array_struct_ptr and generate dim expressions *)
    let struct_ptr_ptr = find_llvalue_ptr name_sym depth info_tbl false in
    let struct_ptr = L.build_load struct_ptr_ptr "array_struct_ptr" builder in
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
    (* calculate array_index = last_expr_num + Σ(expr_num * next_dim_size) *)
    let first_exprs_ll, last_expr_ll = split_last_elem [] exprs_ll in
    let next_dim_sizes = List.tl dim_sizes_ll in
    let array_index = List.fold_left2 add_dim_offset last_expr_ll first_exprs_ll next_dim_sizes in
    
    (* return requested array element pointer -- done with gep *)
    let array_ptr = load_from_array_struct 0 in
    L.build_gep array_ptr [| array_index |] "temp_array_element_gep" builder
  | TA.E_ArrayDim { dim; name_sym } ->
    (* bound check if 1 <= dim <= dimNum *)
    let struct_ptr_ptr = find_llvalue_ptr name_sym depth info_tbl false in
    let struct_ptr = L.build_load struct_ptr_ptr "array_struct_ptr" builder in

    (* remove first element which is array pointer *)
    let dimNum = struct_ptr |> L.type_of |> L.element_type |> L.struct_element_types |> Array.length |> fun d -> d - 1 in

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
    (* allocate to garbage-collected-heap a struct_ptr -- then this points to allocated structs in garbage-collected-heap *)
    let struct_ptr_lltype = lltype_of_ty ty |> L.element_type in
    build_gc_malloc struct_ptr_lltype "temp_malloc_for_new" true None
  | TA.E_Delete { expr } ->
    (* provide a pointer to allocated struct_ptr in garbage-collected-heap *)
    let struct_ptr_ptr = generate_ir_expr_aux expr in
    (* store null to struct_ptr_ptr -- let garbage collection sweep the allocated struct *)
    let null_struct_ptr = L.type_of struct_ptr_ptr |> L.element_type |> L.const_null in
    ignore(L.build_store null_struct_ptr struct_ptr_ptr builder);
    unit_value
  | TA.E_FuncCall { ty; name_sym; param_exprs } ->
    if is_unary_operator (S.name name_sym) 
      then build_unary_operator name_sym param_exprs generate_ir_expr_aux
    else if is_binary_operator (S.name name_sym)
      then build_binary_operator name_sym param_exprs generate_ir_expr_aux
    else
      let callee = find_llvalue_ptr name_sym depth info_tbl true in
      let param_llvalues = List.map generate_ir_expr_aux param_exprs in
      L.build_call callee (Array.of_list param_llvalues) "temp_call" builder
  | TA.E_ConstrCall { ty; name_sym; param_exprs; loc} ->
    let userdef_struct_pointer_lltype = lltype_of_ty ty in
    let userdef_struct_lltype = L.element_type userdef_struct_pointer_lltype in
    let llname = llname_constr_of_constr_info name_sym ty in
    let tag, constr_struct_pointer_lltype = match tbl_find_opt constr_info_tbl llname with
      | Some (tag, lltype) -> tag, lltype
      | None -> internal_error_of_msg_format (Some loc) "Some (tag, lltype)" "None" "constr_info_tbl" "pair"
    in

    (* allocate userdef struct in garbage-collected-heap *)
    let userdef_struct_ptr = build_gc_malloc userdef_struct_lltype ("userdef_struct_ptr:" ^ (S.name name_sym)) true None in
    
    (* store tag *)
    let tag_ptr = L.build_struct_gep userdef_struct_ptr 0 "userdef_struct_tag_ptr" builder in
    ignore(L.build_store (const_int tag) tag_ptr builder);

    if List.length param_exprs > 0 then begin
      (* cast userdef_struct pointer to specific constr struct pointer *)
      let constr_struct_ptr = L.build_pointercast userdef_struct_ptr constr_struct_pointer_lltype "constr_struct_ptr" builder in

      (* store all other parameters to constr_struct *)
      let param_llvalues = List.map generate_ir_expr_aux param_exprs in
      let store_to_constr_struct idx value =
        let ptr = L.build_struct_gep constr_struct_ptr idx "temp_constr_struct_store_ptr" builder in
        ignore(L.build_store value ptr builder)
      in
      List.iteri (fun idx llvalue -> store_to_constr_struct (idx + 1) llvalue) param_llvalues
    end;

    (* return the userdef struct alloca pointer *)
    userdef_struct_ptr
  | TA.E_LetIn { letdef; in_expr} ->
    generate_ir_def depth info_tbl letdef;
    generate_ir_expr depth info_tbl in_expr
  | TA.E_BeginEnd { expr } ->
    generate_ir_expr_aux expr
  | TA.E_MatchedIF { if_expr; then_expr; else_expr } ->
    (* build basic blocks then, else and merge *)
    let func = builder |> L.insertion_block |> L.block_parent in
    let then_block = L.append_block ctx "if_then" func in
    let else_block = L.append_block ctx "if_else" func in
    let merge_block = L.append_block ctx "if_merge" func in

    (* build condition *)
    let cond_llvalue = generate_ir_expr_aux if_expr in
    ignore(L.build_cond_br cond_llvalue then_block else_block builder);

    (* fill then block *)
    L.position_at_end then_block builder;
    let then_llvalue = generate_ir_expr_aux then_expr in
    (* block might have changed *)
    let end_of_then_block = builder |> L.insertion_block in
    ignore(L.build_br merge_block builder);

    (* fill else block *)
    L.move_block_after end_of_then_block else_block;
    L.position_at_end else_block builder;
    let else_llvalue = generate_ir_expr_aux else_expr in
    (* block might have changed *)
    let end_of_else_block = builder |> L.insertion_block in
    ignore(L.build_br merge_block builder);

    (* fill merge block *)
    (* keep visual block order and move after_block *)
    L.move_block_after end_of_else_block merge_block;
    L.position_at_end merge_block builder;
    (* build phi node on merge block and return phi value *)
    L.build_phi [(then_llvalue, end_of_then_block); (else_llvalue, end_of_else_block)] "temp_phi" builder
  | TA.E_WhileDoDone  { while_expr; do_expr; loc} ->
    (* build basic blocks check, body and after *)
    let func = builder |> L.insertion_block |> L.block_parent in
    let check_block = L.append_block ctx "while_check" func in
    let body_block = L.append_block ctx "while_body" func in
    let after_block = L.append_block ctx "while_after" func in
    ignore(L.build_br check_block builder);

    (* fill check block *)
    L.position_at_end check_block builder;
    let cond_llvalue = generate_ir_expr_aux while_expr in
    ignore(L.build_cond_br cond_llvalue body_block after_block builder);

    (* fill body block *)
    L.position_at_end body_block builder;
    ignore(generate_ir_expr_aux do_expr);
    (* block might have changed *)
    let end_of_body_block = builder |> L.insertion_block in
    (* build branch from current end_of_body block to check_block *)
    ignore(L.build_br check_block builder);

    (* keep visual block order and move after_block *)
    L.move_block_after end_of_body_block after_block;
    (* position builder at after block and return unit value *)
    L.position_at_end after_block builder;
    unit_value
  | TA.E_ForDoDone { count_var_sym; start_expr; count_dir; end_expr; do_expr; loc } ->
    (* build basic blocks check, body and after *)
    let pre_loop_block = builder |> L.insertion_block in
    let func =  pre_loop_block |> L.block_parent in
    let check_block = L.append_block ctx "for_check" func in
    let body_block = L.append_block ctx "for_body" func in
    let after_block = L.append_block ctx "for_after" func in

    (* count_var and step value *)
    let count_var_ptr = find_llvalue_ptr count_var_sym depth info_tbl false in
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

    (* fill check block *)
    L.position_at_end check_block builder;
    let loop_llvalue = L.build_empty_phi int_type "loop_var" builder in
    ignore(L.build_store loop_llvalue count_var_ptr builder);
    L.add_incoming (start_llvalue, pre_loop_block) loop_llvalue;
    let cond_llvalue = cond_llfun loop_llvalue end_llvalue "cond" builder in
    ignore(L.build_cond_br cond_llvalue body_block after_block builder);

    (* fill body block *)
    L.position_at_end body_block builder;
    ignore(generate_ir_expr_aux do_expr);
    (* block might have changed *)
    let end_of_body_block = builder |> L.insertion_block in
    (* increment loop value in a new variable and add to phi *)
    let next_llvalue = step_llfun loop_llvalue step_llvalue "next_loop_var" builder in
    L.add_incoming (next_llvalue, end_of_body_block) loop_llvalue;
    (* create branch to check block in current end_of_body_block *)
    ignore(L.build_br check_block builder);
    
    (* keep visual block order and move after_block *)
    L.move_block_after end_of_body_block after_block;
    (* position builder at after block and return unit value *)
    L.position_at_end after_block builder;
    unit_value
  | TA.E_MatchWithEnd { ty; match_expr; with_clauses; loc } ->
    let func = builder |> L.insertion_block |> L.block_parent in
    
    let rec create_match_check_blocks start finish acc =
      let block_name = "match_check_" ^ (string_of_int (start + 1)) in
      if start = finish then List.rev acc
      else create_match_check_blocks (start + 1) finish ((L.append_block ctx block_name func) :: acc)
    in 
    let prepend_index_string = List.mapi (fun i (b1, b2) -> (string_of_int (i + 1), b1, b2)) in

    (* generate ir for match value *)
    let match_llvalue = generate_ir_expr_aux match_expr in

    (* create match_check blocks for every clause and match failed block *)
    let match_check_blocks = create_match_check_blocks 0 (List.length with_clauses) [] in
    let match_failed_block = L.append_block ctx "match_failed" func in

    (* create (current, next) pairs of blocks for every clause *)
    let match_next_check_blocks = (List.tl match_check_blocks) @ [match_failed_block] in
    let match_block_pairs  = List.map2 (fun b1 b2 -> b1, b2) match_check_blocks match_next_check_blocks |> prepend_index_string in

    (* create finish block *)
    let match_finished_block = L.append_block ctx "match_finished" func in

    (* generate all clauses *)
    ignore(L.build_br (List.hd match_check_blocks) builder);
    let value_block_phi_pairs = List.map2 (generate_ir_clause match_llvalue match_finished_block) match_block_pairs with_clauses in

    (* fill match_failed block *)
    (* keep visual block order and move match_failed_block *)
    let rec get_last_block = function
      | [] -> internal_error None "empty pairs provided in get_last_block"
      | [(_, b)] -> b 
      | p :: ps -> get_last_block ps
    in
    let last_end_of_success_block = get_last_block value_block_phi_pairs in
    L.move_block_after last_end_of_success_block match_failed_block;
    L.position_at_end match_failed_block builder;
    build_runtime_error "Given expression could not be matched with some clause";
    ignore(L.build_br match_failed_block builder);
    
    (* fill match_finished block *)
    (* keep visual block order and move match_finished_block *)
    L.move_block_after match_failed_block match_finished_block;
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
      (* block might have changed *)
      let end_of_success_block = builder |> L.insertion_block in
      ignore(L.build_br match_finished_block builder);

      (* return phi pair *)
      success_llvalue, end_of_success_block
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
      (* block might have changed *)
      let end_of_success_block = builder |> L.insertion_block in
      ignore(L.build_br match_finished_block builder);
      
      (* return phi pair*)
      success_llvalue, end_of_success_block

  and generate_ir_base_pattern match_llvalue = function
    | TA.BP_INT { num } -> 
      L.build_icmp L.Icmp.Eq (const_int num) match_llvalue "pattern_comp" builder
    | TA.BP_FLOAT { num } -> 
      L.build_fcmp L.Fcmp.Oeq (const_float num) match_llvalue "pattern_comp" builder
    | TA.BP_CHAR { chr } -> 
      L.build_icmp L.Icmp.Eq (const_char (int_of_char chr)) match_llvalue "pattern_comp" builder
    | TA.BP_BOOL { value } -> 
      L.build_icmp L.Icmp.Eq (const_bool value) match_llvalue "pattern_comp" builder
    | TA.BP_ID { name_sym; loc } ->
      let id_ptr = find_llvalue_ptr name_sym depth info_tbl false in
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
