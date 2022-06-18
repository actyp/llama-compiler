module S = Symbol

type symbol = S.symbol
[@@deriving show]

type ty =
  | UNIT
  | INT
  | CHAR
  | BOOL
  | FLOAT
  | REF of ty
  | DYN_REF of ty
  | ARRAY of int * ty
  | FUNC of ty list * ty
  | USERDEF of symbol * int
  | CONSTR of ty list * ty
  | VAR of symbol
  | POLY of int

[@@deriving show]

type ty_symboltable = ty S.symboltable

let rec ty_to_string = function
  | UNIT -> "unit"
  | INT -> "int"
  | CHAR -> "char"
  | BOOL -> "bool"
  | FLOAT -> "float"
  | REF ty -> paren ty ^ " ref"
  | DYN_REF ty -> paren ty ^ " ref (dynamic)"
  | ARRAY (ds, ty) -> array_dims_to_string ds ^ " of " ^ paren ty
  | FUNC (tys, ret_ty) -> param_tys_to_string tys ^ " -> " ^ paren ret_ty
  | USERDEF (sym, i) -> if i <= 1 then S.name sym else S.name sym ^ " (def #" ^ string_of_int i ^ ")"
  | CONSTR (_, user_ty) -> ty_to_string user_ty
  | VAR sym -> S.name sym
  | POLY i -> "'p" ^ string_of_int i

(** [paren ty] returns [ty_to_string ty] in parenthesis when needed *)
and paren ty =
  match ty with
  | REF _ | DYN_REF _  | ARRAY _ | FUNC _ -> "(" ^ ty_to_string ty ^ ")"
  | _ -> ty_to_string ty

(** [array_dims_to_string ds] converts dim number to stars '*' *)
and array_dims_to_string ds =
  let rec aux i stars = if i = 0 then stars else aux (i-1) (stars ^ ",*") in
  if ds <= 0
  then "generic array"
  else if ds = 1
  then "array"
  else "array [*" ^ (aux (ds-1) "") ^ "]"

(** [param_tys_to_string tys] converts function parameters to string *)
and param_tys_to_string tys = String.concat " -> " (List.map paren tys)

let rec is_valid_type = function
  | REF (ARRAY _) | DYN_REF (ARRAY _) -> false
  | REF t | DYN_REF t -> is_valid_type t
  | ARRAY (_, ARRAY _) -> false
  | ARRAY (d, t) -> d >= 0 && is_valid_type t (* d = 0 is the generic array type *)
  | FUNC (param_tys, FUNC _) -> false
  | FUNC (param_tys, ret_ty) -> List.for_all is_valid_type (ret_ty::param_tys)
  | CONSTR (tys, USERDEF _) -> List.for_all is_valid_type tys
  | CONSTR (_, _) -> false
  | _ -> true

(** [currvarnum] is the current unused number of fresh variable *)
let currvarnum = ref 0

let freshVar () =
  let name = "'t" ^ string_of_int !currvarnum in
  let s = S.symbol name in
  incr currvarnum;
  VAR s

(** [genericsymnum] is the current unused number of generic unhashed symbol *)
let genericsymnum = ref 0

let freshGenericType (name: string) =
  let sym = (name, !genericsymnum) in
  incr genericsymnum;
  USERDEF (sym, 0)

let rec instantiate_func_ty = function
  | FUNC (param_tys, ret_ty) ->
    let rec aux poly_fvs acc = function
      | [] ->
        let _, iret = instantiate_ty poly_fvs ret_ty in
        FUNC (List.rev acc, iret)
      | ty :: tys ->
        let poly_fvs', it = instantiate_ty poly_fvs ty in
        aux poly_fvs' (it :: acc) tys

    and instantiate_ty poly_fvs = function
      | REF ty ->
        let poly_fvs', it = instantiate_ty poly_fvs ty in
        poly_fvs', REF it
      | DYN_REF ty ->
        let poly_fvs', it = instantiate_ty poly_fvs ty in
        poly_fvs', DYN_REF it
      | ARRAY (i, ty) ->
        let poly_fvs', it = instantiate_ty poly_fvs ty in
        poly_fvs', ARRAY (i, it)
      | FUNC _ as t -> poly_fvs, instantiate_func_ty t
      | POLY i as p -> begin
        match List.assoc_opt p poly_fvs with
        | Some fv -> poly_fvs, fv
        | None -> let fv = freshVar () in ((p, fv) :: poly_fvs), fv end
      | _ as t -> poly_fvs, t
    in
    aux [] [] param_tys
  | _ as t -> t
