(** Define Ast *)

type loc = Error.lpos_pair
[@@deriving show]

type symbol = Symbol.symbol
[@@deriving show]

type ast = def list
[@@deriving show]

and def =
  | LetDef  of { recur_opt: loc option; decs: dec list; loc: loc }
  | TypeDef of { tdecs: tdec list; loc: loc }
[@@deriving show]

and dec =
  | ConstVarDec of { name_sym: symbol; ty_opt: _type option; value: expr; loc: loc }
  | FunctionDec of { name_sym: symbol; params: param list; result_ty_opt: _type option; body: expr; loc: loc }
  | MutVarDec   of { name_sym: symbol; ty_opt: _type option; loc: loc }
  | ArrayDec    of { name_sym: symbol; dims_len_exprs: expr list; ty_opt: _type option; loc: loc }
[@@deriving show]

and tdec = TypeDec of { name_sym: symbol; constrs: constr list; loc: loc }
[@@deriving show]

and constr = Constr of { name_sym: symbol; tys_opt: (_type list) option; loc: loc }
[@@deriving show]

and param = Param of { name_sym: symbol; ty_opt: _type option; loc: loc }
[@@deriving show]

and _type =
  | TY_UNIT
  | TY_INT
  | TY_CHAR
  | TY_BOOL
  | TY_FLOAT
  | TY_FUNC  of { from_ty: _type; to_ty: _type; }
  | TY_REF   of _type
  | TY_ARRAY of { dims_num_opt: int option; ty: _type; }
  | TY_ID    of symbol
[@@deriving show]

and expr =
  | E_ID           of { name_sym: symbol; loc: loc }
  | E_Int          of { value: int; loc: loc }
  | E_Float        of { value: float; loc: loc }
  | E_Char         of { value: char; loc: loc }
  | E_String       of { value: string; loc: loc }
  | E_BOOL         of { value: bool; loc: loc }
  | E_Unit         of loc
  | E_ArrayRef     of { name_sym: symbol; exprs: expr list; loc: loc }
  | E_ArrayDim     of { dim_opt: int option; name_sym: symbol; loc: loc }
  | E_New          of { ty: _type; loc: loc }
  | E_Delete       of { expr: expr; loc: loc }
  | E_FuncCall     of { name_sym: symbol; param_exprs: expr list; loc: loc }
  | E_ConstrCall   of { name_sym: symbol; param_exprs: expr list; loc: loc }
  | E_LetIn        of { letdef: def; in_expr: expr; loc: loc }
  | E_BeginEnd     of { expr: expr; loc: loc }
  | E_MatchedIF    of { if_expr: expr; then_expr: expr; else_expr: expr; loc: loc }
  | E_WhileDoDone  of { while_expr: expr; do_expr: expr; loc: loc }
  | E_ForDoDone    of { count_var_sym: symbol; start_expr: expr; count_dir: count_dir; end_expr: expr; do_expr: expr; loc: loc }
  | E_MatchWithEnd of { match_expr: expr; with_clauses: clause list; loc: loc }
[@@deriving show]

and count_dir =
  | TO of loc
  | DOWNTO of loc
[@@deriving show]

and clause =
  | BasePattClause   of { base_pattern: base_pattern; expr: expr; loc: loc }
  | ConstrPattClause of { constr_pattern: constr_pattern; expr: expr; loc: loc }
[@@deriving show]

and base_pattern =
  | BP_INT         of { num: int; loc: loc }
  | BP_FLOAT       of { num: float; loc: loc }
  | BP_CHAR        of { chr: char; loc: loc }
  | BP_BOOL        of { value: bool; loc: loc}
  | BP_ID          of { name_sym: symbol; loc: loc }
[@@deriving show]

and constr_pattern =
  CP_BASIC of { constr_sym: symbol; base_patterns: base_pattern list; loc: loc }
[@@deriving show]

(**
[pprint ast] pretty prints ast
 - [@@deriving show] after a type automatically generates pp_<type_name> and show_<type_name>
   functions. show_<type_name> functions are used recursively after invoking show_ast.
*)
let pprint (ast: ast) = Printf.printf "Ast:\n %s\n" (show_ast ast)
