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
  | REF of ty * unique              (* statically allocated ref *)
  | DYN_REF of ty * unique          (* dynamically allocated ref *)
  | ARRAY of int * ty               (* dimensions , ty, unique reference *)
  | FUNC of ty list * ty            (* param ty list, return type *)
  | USERDEF of symbol               (* user-defined type *)
  | CONSTR of ty list * ty * unique (* param ty list and user-defined type *)
  | VAR of symbol                   (* meta-var used for annotation *)
  | POLY of int                     (* meta-var used for polymorphic built-in functions; multiple variables
                                      in the same function differ, if necessary, from integer *)
[@@deriving show]

(** [ty_to_string t] converts type t to string *)
let rec ty_to_string = function
  | UNIT -> "unit"
  | INT -> "int"
  | CHAR -> "char"
  | BOOL -> "bool"
  | FLOAT -> "float"
  | REF (ty, _) -> ty_to_string ty ^ " ref"
  | DYN_REF (ty, _) -> ty_to_string ty ^ " ref (dynamic)"
  | ARRAY (ds, ty) -> array_dims_to_string ds ^ " of " ^ ty_to_string ty
  | FUNC (tys, ret_ty) -> param_tys_to_string tys ^ " -> " ^ ty_to_string ret_ty
  | USERDEF sym -> S.name sym
  | CONSTR (_, user_ty, _) -> ty_to_string user_ty
  | VAR sym -> S.name sym
  | POLY i -> "'p" ^ string_of_int i

(** [array_dims_to_string ds] converts dim number to stars '*' *)
and array_dims_to_string ds =
  let rec aux i stars = if i = 0 then stars else aux (i-1) (stars ^ ",*") in
  if ds <= 0
  then "generic array"
  else if ds = 1
  then "array"
  else "array [*" ^ (aux (ds-1) "") ^ "]"

(** [param_tys_to_string tys] converts function parameters to string *)
and param_tys_to_string tys =
  let paren ty = match ty with
    | FUNC _ -> "(" ^ ty_to_string ty ^ ")"
    | _ -> ty_to_string ty
  in
  String.concat " -> " (List.map paren tys)

(** [is_valid_type t] checks the validity of given type [t] *)
let rec is_valid_type = function
  | REF (ARRAY _, _) | DYN_REF (ARRAY _, _) -> false
  | REF (t, _) | DYN_REF (t, _) -> is_valid_type t
  | ARRAY (_, ARRAY _) -> false
  | ARRAY (d, t) -> d > 0 && is_valid_type t
  | FUNC (param_tys, FUNC _) -> false
  | FUNC (param_tys, ret_ty) -> List.for_all is_valid_type (ret_ty::param_tys)
  | CONSTR (tys, USERDEF _, _) -> List.for_all is_valid_type tys
  | CONSTR (_, _, _) -> false
  | _ -> true

(** [ty_symboltable] is the type for symbol -> ty Map *)
type ty_symboltable = ty S.symboltable

(** [currvarnum] is the current unused number of fresh variable *)
let currvarnum = ref 0

(** [freshVar ()] creates and returns a freshly created Var *)
let freshVar () =
  let name = "'t" ^ string_of_int !currvarnum in
  let s = S.symbol name in
  incr currvarnum;
  VAR s

(** [genericsymnum] is the current unused number of generic unhashed symbol *)
let genericsymnum = ref 0
let freshGenericSymbol (name: string) =
  let sym = (name, !genericsymnum) in
  incr genericsymnum;
  sym

(** [instantiate_func_ty t] return the FUNC type after converting all POLY types in
    function type [t] to fresh vars; if applied to a non function type [t] then [t] is returned *)
let rec instantiate_func_ty = function
  | FUNC (param_tys, ret_ty) ->
    let rec aux poly_fvs acc = function
      | [] ->
        let _, iret = instantiate_ty poly_fvs ret_ty in
        FUNC (rev [] acc, iret)
      | ty :: tys ->
        let poly_fvs', it = instantiate_ty poly_fvs ty in
        aux poly_fvs' (it :: acc) tys

    and rev acc = function
      | [] -> acc
      | h::t -> rev (h::acc) t

    and instantiate_ty poly_fvs = function
      | REF (ty, u) ->
        let poly_fvs', it = instantiate_ty poly_fvs ty in
        poly_fvs', REF (it, u)
      | DYN_REF (ty, u) ->
        let poly_fvs', it = instantiate_ty poly_fvs ty in
        poly_fvs', DYN_REF (it, u)
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
