module T = Types

type loc = Error.lpos_pair

type symbol = Symbol.symbol

type tast = def list

and def =
  | LetDefNonRec of { decs : dec list; loc : loc }
  | LetDefRec of { recur : loc; decs : dec list; loc : loc }
  | TypeDef of { tdecs : tdec list; loc : loc }

and dec =
  | ConstVarDec of { ty : T.ty; name_sym : symbol; value : expr; loc : loc }
  | FunctionDec of { ty : T.ty; name_sym : symbol; params : param list; body : expr; loc : loc }
  | MutVarDec of { ty : T.ty; name_sym : symbol; loc : loc }
  | ArrayDec of { ty : T.ty; name_sym : symbol; dims_len_exprs : expr list; loc : loc }

and tdec =
    TypeDec of { name_sym : symbol; constrs : constr list; loc : loc }

and constr = Constr of { ty : T.ty; name_sym : symbol; index:int; loc : loc }

and param = Param of { ty : T.ty; name_sym : symbol; loc : loc }

and expr =
  | E_ID of { ty : T.ty; name_sym : symbol; loc : loc }
  | E_Int of { ty : T.ty; value : int; loc : loc }
  | E_Float of { ty : T.ty; value : float; loc : loc }
  | E_Char of { ty : T.ty; value : char; loc : loc }
  | E_String of { ty : T.ty; value : string; loc : loc }
  | E_BOOL of { ty : T.ty; value : bool; loc : loc }
  | E_Unit of { ty : T.ty; loc : loc }
  | E_ArrayRef of { ty : T.ty; name_sym : symbol; exprs : expr list; loc : loc }
  | E_ArrayDim of { ty : T.ty; dim : int; name_sym : symbol; loc : loc }
  | E_New of { ty : T.ty; loc : loc }
  | E_Delete of { ty : T.ty; expr : expr; loc : loc }
  | E_FuncCall of { ty : T.ty; name_sym : symbol; param_exprs : expr list; loc : loc }
  | E_ConstrCall of { ty : T.ty; name_sym : symbol; param_exprs : expr list; loc : loc }
  | E_LetIn of { ty : T.ty; letdef : def; in_expr : expr; loc : loc }
  | E_BeginEnd of { ty : T.ty; expr : expr; loc : loc }
  | E_MatchedIF of { ty : T.ty; if_expr : expr; then_expr : expr; else_expr : expr; loc : loc }
  | E_WhileDoDone of { ty : T.ty; while_expr : expr; do_expr : expr; loc : loc }
  | E_ForDoDone of { ty : T.ty; count_var_sym : symbol; start_expr : expr; count_dir : count_dir; end_expr : expr; do_expr : expr; loc : loc }
  | E_MatchWithEnd of { ty : T.ty; match_expr : expr; with_clauses : clause list; loc : loc }

and count_dir =
  | TO of loc
  | DOWNTO of loc

and clause =
  | BasePattClause of { base_pattern : base_pattern; expr : expr; loc : loc }
  | ConstrPattClause of { constr_pattern : constr_pattern; expr : expr; loc : loc }

and base_pattern =
  | BP_INT of { ty : T.ty; num : int; loc : loc }
  | BP_FLOAT of { ty : T.ty; num : float; loc : loc }
  | BP_CHAR of { ty : T.ty; chr : char; loc : loc }
  | BP_BOOL of { ty : T.ty; value : bool; loc : loc }
  | BP_ID of { ty : T.ty; name_sym : symbol; loc : loc }

and constr_pattern =
    CP_BASIC of { ty : T.ty; constr_sym : symbol; base_patterns : base_pattern list; loc : loc }

(** [venv] is a mapping from value variables to types *)
type venv = T.ty_symboltable

(** [tenv] is a mapping from type variables to types *)
and tenv = T.ty_symboltable

(** [env_tast] is the tast but every def node is accompanied by it's starting venv and tenv *)
and env_tast = (venv * tenv * def) list

(** [tast_from_env_tast env_tast] returns the tast from [env_tast] *)
val tast_from_env_tast : env_tast -> def list

(** [pprint tast] pretty prints typed ast *)
val pprint : tast -> unit

(** [from_ast_type t] converts ast _type [t] to typed ast _type *)
val from_ast_type : Ast._type -> T.ty

(** [from_ast_count_dir c] returns the TypedAst.count_dir from Ast.count_dir [c] *)
val from_ast_count_dir : Ast.count_dir -> count_dir

(** [expr_ty e] extracts [ty] from expr [e] *)
val expr_ty : expr -> T.ty

(** [clause_ty c] extracts [ty] from clause [c] *)
val clause_tys : clause -> T.ty * T.ty

(** [base_pattern_ty bp] extracts [ty] from base_pattern [bp] *)
val base_pattern_ty : base_pattern -> T.ty

(** [constr_pattern_ty bp] extracts [ty] from constr_pattern [cp] *)
val constr_pattern_ty : constr_pattern -> T.ty
