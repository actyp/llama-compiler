module S = Symbol
module T = Types

(** [fun_ty param_tys ret_ty] creates a Types.FUNC from [param_tys] and [ret_ty] *)
let fun_ty (param_tys: T.ty list) (ret_ty: T.ty): T.ty = T.FUNC (param_tys, ret_ty)

let array_of_char_ty = T.ARRAY (1, T.CHAR)

(** [unary_operator_functions] is a list of pairs of unary operators and their types *)
let unary_operator_functions =
  [
    ("( ~+ )" , fun_ty [T.INT] T.INT);
    ("( ~- )" , fun_ty [T.INT] T.INT);
    ("( ~+. )", fun_ty [T.FLOAT] T.FLOAT);
    ("( ~-. )", fun_ty [T.FLOAT] T.FLOAT);
    ("( ! )"  , fun_ty [T.REF (T.POLY 1)] (T.POLY 1));
    ("( not )", fun_ty [T.BOOL] T.BOOL);
  ]

(** [binary_operator_functions] is a list of pairs of binary operators and their types *)
let binary_operator_functions =
  [
    ("( + )"  , fun_ty [T.INT; T.INT] T.INT);
    ("( - )"  , fun_ty [T.INT; T.INT] T.INT);
    ("( * )"  , fun_ty [T.INT; T.INT] T.INT);
    ("( / )"  , fun_ty [T.INT; T.INT] T.INT);
    ("( +. )" , fun_ty [T.FLOAT; T.FLOAT] T.FLOAT);
    ("( -. )" , fun_ty [T.FLOAT; T.FLOAT] T.FLOAT);
    ("( *. )" , fun_ty [T.FLOAT; T.FLOAT] T.FLOAT);
    ("( /. )" , fun_ty [T.FLOAT; T.FLOAT] T.FLOAT);
    ("( mod )", fun_ty [T.INT; T.INT] T.INT);
    ("( ** )" , fun_ty [T.FLOAT; T.FLOAT] T.FLOAT);
    ("( = )"  , fun_ty [T.POLY 1; T.POLY 1] T.BOOL);
    ("( <> )" , fun_ty [T.POLY 1; T.POLY 1] T.BOOL);
    ("( < )"  , fun_ty [T.POLY 1; T.POLY 1] T.BOOL);
    ("( > )"  , fun_ty [T.POLY 1; T.POLY 1] T.BOOL);
    ("( <= )" , fun_ty [T.POLY 1; T.POLY 1] T.BOOL);
    ("( >= )" , fun_ty [T.POLY 1; T.POLY 1] T.BOOL);
    ("( == )" , fun_ty [T.POLY 1; T.POLY 1] T.BOOL);
    ("( != )" , fun_ty [T.POLY 1; T.POLY 1] T.BOOL);
    ("( && )" , fun_ty [T.BOOL; T.BOOL] T.BOOL);
    ("( || )" , fun_ty [T.BOOL; T.BOOL] T.BOOL);
    ("( ; )"  , fun_ty [T.POLY 1; T.POLY 2] (T.POLY 2));
    ("( := )" , fun_ty [T.REF (T.POLY 1); (T.POLY 1)] T.UNIT);
  ]

(** [io_functions] is a list of pairs of i/o functions and their types *)
let io_functions =
  [
    ("print_int"   , fun_ty [T.INT] T.UNIT);
    ("print_bool"  , fun_ty [T.BOOL] T.UNIT);
    ("print_char"  , fun_ty [T.CHAR] T.UNIT);
    ("print_float" , fun_ty [T.FLOAT] T.UNIT);
    ("print_string", fun_ty [array_of_char_ty] T.UNIT);
    ("read_int"    , fun_ty [T.UNIT] T.INT);
    ("read_bool"   , fun_ty [T.UNIT] T.BOOL);
    ("read_char"   , fun_ty [T.UNIT] T.CHAR);
    ("read_float"  , fun_ty [T.UNIT] T.FLOAT);
    ("read_string" , fun_ty [array_of_char_ty] T.UNIT);
  ]

(** [mathematical_functions] is a list of pairs of mathematical functions and their types *)
let mathematical_functions =
  [
    ("abs" , fun_ty [T.INT] T.INT);
    ("fabs", fun_ty [T.FLOAT] T.FLOAT);
    ("sqrt", fun_ty [T.FLOAT] T.FLOAT);
    ("sin" , fun_ty [T.FLOAT] T.FLOAT);
    ("cos" , fun_ty [T.FLOAT] T.FLOAT);
    ("tan" , fun_ty [T.FLOAT] T.FLOAT);
    ("atan", fun_ty [T.FLOAT] T.FLOAT);
    ("exp" , fun_ty [T.FLOAT] T.FLOAT);
    ("ln"  , fun_ty [T.FLOAT] T.FLOAT);
    ("pi"  , fun_ty [T.UNIT] T.FLOAT);
  ]

(** [increment_functions] is a list of pairs of increment functions and their types *)
let increment_functions =
  [
    ("incr", fun_ty [T.REF T.INT] T.UNIT);
    ("decr", fun_ty [T.REF T.INT] T.UNIT);
  ]

(** [conversion_functions] is a list of pairs of conversion functions and their types *)
let conversion_functions =
  [
    ("float_of_int", fun_ty [T.INT] T.FLOAT);
    ("int_of_float", fun_ty [T.FLOAT] T.INT);
    ("round"       , fun_ty [T.FLOAT] T.INT);
    ("int_of_char" , fun_ty [T.CHAR] T.INT);
    ("char_of_int" , fun_ty [T.INT] T.CHAR);
  ]


(** [string_management_functions] is a list of pairs of string management functions and their types *)
let string_management_functions =
  [
    ("strlen", fun_ty [array_of_char_ty] T.INT);
    ("strcmp", fun_ty [array_of_char_ty; array_of_char_ty] T.INT);
    ("strcpy", fun_ty [array_of_char_ty; array_of_char_ty] T.UNIT);
    ("strcat", fun_ty [array_of_char_ty; array_of_char_ty] T.UNIT);
  ]

(** [inner_util_functions] is a list of pairs of util functions and their types.
    These functions are external, but not exposed to the user, they are used internally *)
let inner_util_functions = 
  [
    ("pow" , fun_ty [T.FLOAT; T.FLOAT] T.FLOAT);
    ("exit_with_error", fun_ty [array_of_char_ty; T.INT] T.UNIT);
  ]

(** [function_names func_list] returns a list containing only the names of the [func_list] *)
let function_names func_list = List.map (fun (name, _) -> name) func_list

let unary_operator_names = function_names unary_operator_functions

let binary_operator_names = function_names binary_operator_functions

let external_functions = [
  io_functions; mathematical_functions; increment_functions; conversion_functions;
  string_management_functions; inner_util_functions
]

let external_function_names = external_functions |> List.flatten |> function_names
  
let initial_envs () =
  let rec augment_env env = function
    | [] -> env
    | (s, ty) :: rest -> augment_env (S.enter env (S.symbol s) ty) rest
  in
  let venv_pairs = [
    unary_operator_functions; binary_operator_functions; io_functions;
    mathematical_functions; increment_functions; conversion_functions;
    string_management_functions ] in
  let venv: T.ty_symboltable = List.fold_left augment_env S.empty venv_pairs in
  let tenv: T.ty_symboltable = S.empty in
  venv, tenv

let is_valid_binary func_sym param_ty =
  let non_array_func_ty = function
    | T.ARRAY _ | T.FUNC _ -> false
    | _ -> true

  and int_float_char_ty = function
    | T.INT | T.FLOAT | T.CHAR -> true
    | _ -> false
  in
  match S.name func_sym with
  | "( = )"  | "( <> )" -> non_array_func_ty param_ty
  | "( < )"  | "( > )"  -> int_float_char_ty param_ty
  | "( <= )" | "( >= )" -> int_float_char_ty param_ty
  | "( == )" | "( != )" -> non_array_func_ty param_ty
  | _ -> true

let hint_str func_sym =
  let hint_of_str str = "Hint: " ^ str
  and non_array_func_params = "Array and function types are not allowed as parameters"
  and int_float_char_params = "Only int, float and char types are allowed as parameters"
  in
  match S.name func_sym with
  | "( = )"  | "( <> )" -> hint_of_str non_array_func_params
  | "( < )"  | "( > )"  -> hint_of_str int_float_char_params
  | "( <= )" | "( >= )" -> hint_of_str int_float_char_params
  | "( == )" | "( != )" -> hint_of_str non_array_func_params
  | _ -> ""
