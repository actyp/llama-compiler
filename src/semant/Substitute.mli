module TA = TypedAst
module U = Unify

(** [substitute_and_typecheck tast st] given the annotated_ast [tast] and the subst_tbl [st]
    traverses the tree and substitutes and typechecks -- when needed -- the type variables
    returning the final typed ast *)
val substitute_and_typecheck : TA.tast -> U.subst_tbl -> TA.tast
