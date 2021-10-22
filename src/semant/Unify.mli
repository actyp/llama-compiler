module CT = ConstraintTree
module H = Hashtbl
module T = Types

(** [subst_tbl] is the type of Types.ty to Types.ty Hashtbl used for Types.VAR to Types.ty mapping *)
type subst_tbl = (T.ty, T.ty) H.t

(** [pprint st] pretty-prints the given subst_tbl [st] *)
val pprint : subst_tbl -> unit

(** [unify_and_solve contree] traverses ConstaintTree.contree [contree], solves the constraints
    and returns the resulting [subst_tbl] *)
val unify_and_solve : CT.contree -> subst_tbl
