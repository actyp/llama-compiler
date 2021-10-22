module S = Symbol
module T = Types

(** [initial_envs ()] returns the initial (venv, tenv) tuple *)
val initial_envs : unit -> T.ty_symboltable * T.ty_symboltable

(** [is_valid_binary func_sym param_ty] checks the parameter validity of the single
    parameter Types.ty [param_ty] of function's Symbol.symbol [func_sym] *)
val is_valid_binary : S.symbol -> T.ty -> bool

(** [hint_str func_sym] returns the corresponding hint string for function
    with Symbol.symbol [func_sym] *)
val hint_str : S.symbol -> string
