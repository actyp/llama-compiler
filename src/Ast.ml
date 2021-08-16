(* Define Ast **)

type pos = int
[@@deriving show]

type symbol = Symbol.symbol
[@@deriving show]

type program = def list
[@@deriving show]

and def =
  | LetDef  of { recur_opt: pos option; decs: dec list; pos: pos }
  | TypeDef of { tdecs: tdec list; pos: pos }
[@@deriving show]

and dec =
  | ConstVarDec of { name: symbol; ty_opt: _type option; value: expr; pos: pos }
  | FunctionDec of { name: symbol; params: param list; result_ty_opt: _type option; body: expr; pos: pos }
  | MutVarDec   of { name: symbol; ty_opt: _type option; pos: pos }
  | ArrayDec    of { name: symbol; dims: expr list; ty_opt: _type option; pos: pos }
[@@deriving show]

and tdec = TypeDec of { name: symbol; constrs: constr list; pos: pos }
[@@deriving show]

and constr = Constr of { name: symbol; tys_opt: (_type list) option; pos: pos }
[@@deriving show]

and param = Param of { name: symbol; ty_opt: _type option; pos: pos }
[@@deriving show]

and _type =
  | TY_BASIC of { ty: symbol; pos: pos }
  | TY_FUNC  of { param_tys: _type list; pos: pos }
  | TY_REF   of { ty: _type; pos: pos }
  | TY_ARRAY of { dims_num_opt: int option; ty: _type; pos: pos }
  | TY_ID    of { ty: symbol; pos: pos }
[@@deriving show]

and base_expr =
  | BE_ID       of { name: symbol; pos: pos }
  | BE_CID      of { name: symbol; pos: pos }
  | BE_Int      of { value: int; pos: pos }
  | BE_Float    of { value: float; pos: pos }
  | BE_Char     of { value: char; pos: pos }
  | BE_String   of { value: string; pos: pos }
  | BE_True     of pos
  | BE_False    of pos
  | BE_Deref    of { base_expr: base_expr; pos: pos }
  | BE_Empty    of pos
  | BE_ArrayRef of { exprs: expr list; pos: pos }
  | BE_Nested   of { expr: expr; pos: pos }
[@@deriving show]

and expr =
  | E_Unop         of { unop: unop; expr: expr; pos: pos }
  | E_Binop        of { left_expr: expr; binop: binop; right_expr: expr; pos: pos }
  | E_ID_BES       of { id: symbol; base_exprs: base_expr list; pos: pos }
  | E_CID_BES      of { cid: symbol; base_exprs: base_expr list; pos: pos }
  | E_ArrayDim     of { dim: int option; array_name: symbol; pos: pos }
  | E_New          of { ty: _type; pos: pos }
  | E_Delete       of { expr: expr; pos: pos }
  | E_LetIn        of { letdef: def; in_expr: expr; pos: pos }
  | E_BeginEnd     of { expr: expr; pos: pos }
  | E_MatchedIF    of { if_expr: expr; then_expr: expr; else_expr: expr; pos: pos }
  | E_UnmatchedIF  of { if_expr: expr; then_expr: expr; pos: pos }
  | E_WhileDoDone  of { while_expr: expr; do_expr: expr; pos: pos }
  | E_ForDoDone    of { count_var: symbol; start_expr: expr; count_dir: count_dir; end_expr: expr; do_expr: expr; pos: pos }
  | E_MatchWithEnd of { match_expr: expr; with_clauses: clause list; pos: pos }
  | E_BaseExpr     of { base_expr: base_expr; pos: pos }
[@@deriving show]

and unop =
  | UN_PLUS
  | UN_MINUS
  | UN_FLOAT_PLUS
  | UN_FLOAT_MINUS
  | UN_DEREF
  | UN_NOT
[@@deriving show]

and binop =
  | BI_PLUS
  | BI_MINUS
  | BI_TIMES
  | BI_DIV
  | BI_FLOAT_PLUS
  | BI_FLOAT_MINUS
  | BI_FLOAT_TIMES
  | BI_FLOAT_DIV
  | BI_MOD
  | BI_POWER
  | BI_STR_EQUAL
  | BI_STR_UNEQUAL
  | BI_LESS
  | BI_GREATER
  | BI_LESS_EQ
  | BI_GREATER_EQ
  | BI_NAT_EQUAL
  | BI_NAT_UNEQUAL
  | BI_OPERATOR_AND
  | BI_OR
  | BI_SEMICOLON
  | BI_ASSIGN
[@@deriving show]

and count_dir =
  | TO of pos
  | DOWNTO of pos
[@@deriving show]

and clause =
  | BasePattClause   of { base_pattern: base_pattern; expr: expr; pos: pos }
  | ConstrPattClause of { constr_pattern: constr_pattern; expr: expr; pos: pos }
[@@deriving show]

and base_pattern =
  | BP_INT         of { num: int; pos: pos }
  | BP_PLUS_INT    of { num: int; pos: pos }
  | BP_MINUS_INT   of { num: int; pos: pos }
  | BP_FLOAT       of { num: float; pos: pos }
  | BP_PLUS_FLOAT  of { num: float; pos: pos }
  | BP_MINUS_FLOAT of { num: float; pos: pos }
  | BP_CHAR        of { chr: char; pos: pos }
  | BP_TRUE        of pos
  | BP_FALSE       of pos
  | BP_ID          of { id: symbol; pos: pos }
  | BP_CID         of { cid: symbol; pos: pos }
  | BP_NESTED      of { base_pattern: base_pattern; pos: pos }
[@@deriving show]

and constr_pattern =
  | CP_BASIC  of { constr_sym: symbol; base_patterns: base_pattern list; pos: pos }
  | CP_NESTED of { constr_pattern: constr_pattern; pos: pos }
[@@deriving show]


(*
Pretty print ast
 - [@@deriving show] after a type automatically creates show_<type_name> function
   for printing the type. These show_<type_name> functions are used after invoking
   show_program.
**)

let pprint (p: program) = Printf.printf "Program:\n %s\n" (show_program p)
