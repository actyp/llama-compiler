type symbol = Symbol.symbol

type loc = Error.lpos_pair

type con = Empty | Unify of Types.ty * Types.ty

type contree = def list

and def =
  | LetDefNonRec of { decs : dec list }
  | LetDefRec of { decs : dec list }

and dec =
  | ConstVarDec of { con : con; name_sym : symbol; value : expr }
  | FunctionDec of { con : con; name_sym : symbol; body : expr }
  | ArrayDec of { expr_cons : con list; dims_len_exprs : expr list }

and expr =
  | E_Trivial of loc
  | E_ArrayRef of { array_cons : con list; expr_cons : con list; name_sym : symbol; exprs : expr list; loc : loc }
  | E_ArrayDim of { con : con; name_sym : symbol; loc : loc }
  | E_Delete of { con : con; expr : expr; loc : loc }
  | E_FuncCall of { con : con; param_exprs : expr list; loc : loc }
  | E_ConstrCall of { con : con; param_exprs : expr list; loc : loc }
  | E_LetIn of { con : con; letdef : def; in_expr : expr; loc : loc }
  | E_BeginEnd of { con : con; expr : expr; loc : loc }
  | E_MatchedIF of { cons : con list; if_expr : expr; then_expr : expr; else_expr : expr; loc : loc }
  | E_WhileDoDone of { cons : con list; while_expr : expr; do_expr : expr; loc : loc }
  | E_ForDoDone of { cons : con list; start_expr : expr; end_expr : expr; do_expr : expr; loc : loc }
  | E_MatchWithEnd of { userdef_con : con; pat_cons : con list; expr_cons : con list; match_expr : expr; with_clauses : clause list; loc : loc }

and clause =
  | BasePattClause of { base_pattern : base_pattern; expr : expr }
  | ConstrPattClause of { constr_pattern : constr_pattern; expr : expr }

and base_pattern =
  BP_TRIVIAL of { loc : loc }

and constr_pattern =
  CP_BASIC of { con : con; constr_sym : symbol; base_patterns : base_pattern list; loc : loc }

(** [pprint contree] pretty prints constraint tree *)
val pprint : contree -> unit

(** [expr_loc e] extracts loc from expr [e] *)
val expr_loc : expr -> loc

(** [clause_locs c] returns the pair (base_pattern_loc, expr_loc) from clause [c] *)
val clause_locs : clause -> loc * loc

(** [base_pattern_loc bp] extracts the loc from base_pattern [bp] *)
val base_pattern_loc : base_pattern -> loc

(** [constr_pattern_loc cp] extracts the loc from constr_pattern [cp] *)
val constr_pattern_loc : constr_pattern -> loc
