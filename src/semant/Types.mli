module S = Symbol

type symbol = S.symbol

type unique = unit ref

type ty =
  | UNIT
  | INT
  | CHAR
  | BOOL
  | FLOAT
  | REF of ty * unique              (* statically allocated ref *)
  | DYN_REF of ty * unique          (* dynamically allocated ref *)
  | ARRAY of int * ty               (* dimensions, ty *)
  | FUNC of ty list * ty            (* param ty list, return type *)
  | USERDEF of symbol * int         (* user-defined type: symbol, currently active occurence number >= 1 *)
  | CONSTR of ty list * ty * unique (* param ty list and user-defined type *)
  | VAR of symbol                   (* meta-var used for annotation *)
  | POLY of int                     (* meta-var used for polymorphic built-in functions; multiple variables
                                      in the same function differ, if necessary, from integer *)

(** [pp_symbol fmt t] pretty prints ty [t] with formatter [fmt] *)
val pp_ty : Format.formatter -> ty -> unit

(** [ty_symboltable] is the type for symbol -> ty symboltable *)
type ty_symboltable = ty S.symboltable

(** [ty_to_string t] converts type t to string *)
val ty_to_string : ty -> string

(** [is_valid_type t] checks the validity of given type [t] *)
val is_valid_type : ty -> bool

(** [freshVar ()] creates and returns a freshly created Var *)
val freshVar : unit -> ty

(** [freshGenericType name] returns a [USERDEF ((name, _), 0)] as a generic user-defined type *)
val freshGenericType : string -> ty

(** [instantiate_func_ty t] return the FUNC type after converting all POLY types in
    function type [t] to fresh vars; if applied to a non function type [t] then [t] is returned *)
val instantiate_func_ty : ty -> ty
