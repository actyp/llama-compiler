module CT = ConstraintTree
module TA = TypedAst

(** [collect env_tast] returns the ConstraintTree.contree using the environments and the
    typed ast of TypedAst.env_tast [env_tast] *)
val collect : TA.env_tast -> CT.contree
