module S = Symbol

type symbol = S.symbol
[@@deriving show]

type unique = unit ref
[@@deriving show]

type ty =
  | UNIT
  | INT
  | CHAR
  | BOOL
  | FLOAT
  | REF of ty
  | ARRAY of int * ty * unique (* dimensions, ty, unique reference *)
  | FUNC of ty list * ty  (* param ty list, return type *)
  | USERDEF of symbol
  | VAR of symbol (* meta-var used for annotation *)
[@@deriving show]

(** [is_valid_type t] checks the validity of given type [t] *)
let rec is_valid_type = function
  | REF (ARRAY _) -> false
  | REF t -> is_valid_type t
  | ARRAY (_, ARRAY _, _) -> false
  | ARRAY (d, t, _) -> d > 0 && is_valid_type t
  | FUNC (param_tys, FUNC _) -> false
  | FUNC (param_tys, ret_ty) -> List.for_all is_valid_type (ret_ty::param_tys)
  | _ -> true

(** [ty_symboltable] is the type for symbol -> ty Map *)
type ty_symboltable = ty S.symboltable

(* Implementation of fresh-variable creation like [Var 't0] *)
let currvarnum = ref 0

(** [freshVar ()] creates and returns a freshly created Var *)
let freshVar () =
  let name = "'t" ^ string_of_int !currvarnum in
  let s = S.symbol name in
  incr currvarnum;
  VAR s

(** [resetFresh ()] resets the counter referencing fresh vars *)
let resetFresh () = currvarnum := 0
