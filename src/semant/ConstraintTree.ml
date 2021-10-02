(** Define  ConstraintTree *)

module T = Types

type symbol = Symbol.symbol
[@@deriving show]

type loc = Error.lpos * Error.lpos
[@@deriving show]

type con = Empty | Unify of T.ty * T.ty
[@@deriving show]

type contree = def list
[@@deriving show]

and def =
  | LetDefNonRec of { decs: dec list }
  | LetDefRec of { decs: dec list }
[@@deriving show]

and dec =
  | ConstVarDec of { con: con; name_sym: symbol; value: expr }
  | FunctionDec of { con: con; name_sym: symbol; body: expr }
  | ArrayDec    of { expr_cons: con list; dims_len_exprs: expr list }
[@@deriving show]

and expr =
  | E_Trivial      of loc
  | E_ArrayRef     of { array_cons: con list; expr_cons: con list; name_sym: symbol; exprs: expr list; loc: loc }
  | E_FuncCall     of { con: con; param_exprs: expr list; loc: loc }
  | E_ConstrCall   of { con: con; param_exprs: expr list; loc: loc }
  | E_ArrayDim     of { con: con; name_sym: symbol; loc: loc }
  | E_Delete       of { con: con; expr: expr; loc: loc }
  | E_LetIn        of { con: con; letdef: def; in_expr: expr; loc: loc }
  | E_BeginEnd     of { con: con; expr: expr; loc: loc }
  | E_MatchedIF    of { cons: con list; if_expr: expr; then_expr: expr; else_expr: expr; loc: loc }
  | E_WhileDoDone  of { cons: con list; while_expr: expr; do_expr: expr; loc: loc }
  | E_ForDoDone    of { cons: con list; start_expr: expr; end_expr: expr; do_expr: expr; loc: loc }
  | E_MatchWithEnd of { userdef_con: con; pat_cons: con list; expr_cons: con list; match_expr: expr;
                        with_clauses: clause list; loc: loc }
[@@deriving show]

and clause =
  | BasePattClause   of { base_pattern: base_pattern; expr: expr }
  | ConstrPattClause of { constr_pattern: constr_pattern; expr: expr }
[@@deriving show]

and base_pattern =
  | BP_TRIVIAL of { loc: loc }
[@@deriving show]

and constr_pattern =
  CP_BASIC of { con: con; constr_sym: symbol; base_patterns: base_pattern list; loc: loc }
[@@deriving show]

(** [pprint contree] pretty prints constraint tree *)
let pprint (contree: contree) = Printf.printf "Constraint tree:\n %s\n" (show_contree contree)

(** [expr_loc e] extracts loc from expr [e] *)
let rec expr_loc = function
  | E_Trivial loc | E_ArrayRef { loc } | E_FuncCall { loc } | E_ConstrCall { loc } | E_ArrayDim { loc }
  | E_Delete { loc } | E_LetIn { loc } | E_BeginEnd { loc } | E_MatchedIF { loc } | E_WhileDoDone { loc }
  | E_ForDoDone { loc } | E_MatchWithEnd { loc } ->
    loc

(** [clause_locs c] returns the pair (base_pattern_loc, expr_loc) from clause [c] *)
and clause_locs = function
  | BasePattClause   { base_pattern; expr }   -> (base_pattern_loc base_pattern, expr_loc expr)
  | ConstrPattClause { constr_pattern; expr } -> (constr_pattern_loc constr_pattern, expr_loc expr)

(** [base_pattern_loc bp] extracts the loc from base_pattern [bp] *)
and base_pattern_loc = function
  | BP_TRIVIAL { loc } -> loc

(** [constr_pattern_loc cp] extracts the loc from constr_pattern [cp] *)
and constr_pattern_loc = function
  | CP_BASIC { loc } -> loc
