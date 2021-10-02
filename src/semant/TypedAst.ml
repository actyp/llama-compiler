(** Define Typed Ast *)

module T = Types

type loc = Error.lpos * Error.lpos
[@@deriving show]

type symbol = Symbol.symbol
[@@deriving show]

type tast = def list
[@@deriving show]

and def =
  | LetDefNonRec of { decs: dec list; loc: loc }
  | LetDefRec of { recur: loc; decs: dec list; loc: loc }
  | TypeDef of { tdecs: tdec list; loc: loc }
[@@deriving show]

and dec =
  | ConstVarDec of { ty: T.ty; name_sym: symbol; value: expr; loc: loc }
  | FunctionDec of { ty: T.ty; name_sym: symbol; params: param list; body: expr; loc: loc }
  | MutVarDec   of { ty: T.ty; name_sym: symbol; loc: loc }
  | ArrayDec    of { ty: T.ty; name_sym: symbol; dims_len_exprs: expr list; loc: loc }
[@@deriving show]

and tdec = TypeDec of { name_sym: symbol; constrs: constr list; loc: loc }
[@@deriving show]

and constr = Constr of { ty: T.ty; name_sym: symbol; loc: loc }
[@@deriving show]

and param = Param of { ty: T.ty; name_sym: symbol; loc: loc }
[@@deriving show]

and expr =
  | E_ID           of { ty: T.ty; name_sym: symbol; loc: loc }
  | E_Int          of { ty: T.ty; value: int; loc: loc }
  | E_Float        of { ty: T.ty; value: float; loc: loc }
  | E_Char         of { ty: T.ty; value: char; loc: loc }
  | E_String       of { ty: T.ty; value: string; loc: loc }
  | E_BOOL         of { ty: T.ty; value: bool; loc: loc }
  | E_Unit         of { ty: T.ty; loc: loc }
  | E_ArrayRef     of { ty: T.ty; name_sym: symbol; exprs: expr list; loc: loc }
  | E_FuncCall     of { ty: T.ty; name_sym: symbol; param_exprs: expr list; loc: loc }
  | E_ConstrCall   of { ty: T.ty; name_sym: symbol; param_exprs: expr list; loc: loc }
  | E_ArrayDim     of { ty: T.ty; dim: int; name_sym: symbol; loc: loc }
  | E_New          of { ty: T.ty; loc: loc }
  | E_Delete       of { ty: T.ty; expr: expr; loc: loc }
  | E_LetIn        of { ty: T.ty; letdef: def; in_expr: expr; loc: loc }
  | E_BeginEnd     of { ty: T.ty; expr: expr; loc: loc }
  | E_MatchedIF    of { ty: T.ty; if_expr: expr; then_expr: expr; else_expr: expr; loc: loc }
  | E_WhileDoDone  of { ty: T.ty; while_expr: expr; do_expr: expr; loc: loc }
  | E_ForDoDone    of { ty: T.ty; count_var_sym: symbol; start_expr: expr; count_dir: count_dir; end_expr: expr; do_expr: expr; loc: loc }
  | E_MatchWithEnd of { ty: T.ty; match_expr: expr; with_clauses: clause list; loc: loc }
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
  | BP_INT         of { ty: T.ty; num: int; loc: loc }
  | BP_FLOAT       of { ty: T.ty; num: float; loc: loc }
  | BP_CHAR        of { ty: T.ty; chr: char; loc: loc }
  | BP_BOOL        of { ty: T.ty; value: bool; loc: loc }
  | BP_ID          of { ty: T.ty; name_sym: symbol; loc: loc }
[@@deriving show]

and constr_pattern =
  CP_BASIC of { ty: T.ty; constr_sym: symbol; base_patterns: base_pattern list; loc: loc }
[@@deriving show]

(** [pprint tast] pretty prints typed ast *)
let pprint (tast: tast) = Printf.printf "Typed Ast:\n %s\n" (show_tast tast)

(** [from_ast_type t] converts ast _type [t] to typed ast _type *)
let rec from_ast_type (t: Ast._type) = match t with
  | Ast.TY_UNIT   -> T.UNIT
  | Ast.TY_INT    -> T.INT
  | Ast.TY_CHAR   -> T.CHAR
  | Ast.TY_BOOL   -> T.BOOL
  | Ast.TY_FLOAT  -> T.FLOAT
  | Ast.TY_FUNC _ -> from_func_type t
  | Ast.TY_REF ty -> T.REF (from_ast_type ty, ref ())
  | Ast.TY_ARRAY { dims_num_opt; ty } -> T.ARRAY (dopt_to_num dims_num_opt, (from_ast_type ty))
  | Ast.TY_ID ty_sym -> T.USERDEF ty_sym

(** [from_func_type t] returns Types.FUNC type corresponding to Ast.TY_FUNC [t] *)
and from_func_type t =
  let rec rev acc = function
   | [] -> acc
   | l :: ls -> rev (l :: acc) ls

  and aux t params = match t with
    | Ast.TY_FUNC { from_ty; to_ty } ->
      let par = from_ast_type from_ty in
      aux to_ty (par::params)
    | ret_ty ->
      T.FUNC (rev [] params, from_ast_type ret_ty)
  in
  aux t []

(** [dnopt_to_num d] returns the corresponding array dimensions or 1 if they are missing *)
and dopt_to_num (d: int option) = match d with
  | Some n -> n
  | None -> 1

(** [from_ast_count_dir c] returns the TypedAst.count_dir from Ast.count_dir [c] *)
and from_ast_count_dir = function
  | Ast.TO loc -> TO loc
  | Ast.DOWNTO loc -> DOWNTO loc

(** [expr_ty e] extracts [ty] from expr [e] *)
let rec expr_ty = function
  | E_ID { ty } | E_Int { ty } | E_Float { ty } | E_Char { ty } | E_String { ty } | E_BOOL { ty } | E_Unit { ty }
  | E_ArrayRef { ty } | E_FuncCall { ty } | E_ConstrCall { ty } | E_ArrayDim { ty } | E_New { ty } | E_Delete { ty }
  | E_LetIn { ty } | E_BeginEnd { ty } | E_MatchedIF { ty } | E_WhileDoDone  { ty } | E_ForDoDone { ty }
  | E_MatchWithEnd { ty } ->
    ty

(** [clause_ty c] extracts [ty] from clause [c] *)
and clause_tys = function
  | BasePattClause { base_pattern; expr } -> (base_pattern_ty base_pattern, expr_ty expr)
  | ConstrPattClause { constr_pattern; expr } -> (constr_pattern_ty constr_pattern, expr_ty expr)

(** [base_pattern_ty bp] extracts [ty] from base_pattern [bp] *)
and base_pattern_ty = function
  | BP_INT { ty } | BP_FLOAT { ty } | BP_CHAR { ty }
  | BP_BOOL { ty } | BP_ID { ty } ->
    ty

(** [constr_pattern_ty bp] extracts [ty] from constr_pattern [cp] *)
and constr_pattern_ty = function
  | CP_BASIC { ty } -> ty
