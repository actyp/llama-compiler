module A = Ast
module TA = TypedAst

(** [annotate venv tenv ast] returns the TypedAst.env_tast
    generated from [venv], [tenv] and [ast] *)
val annotate : TA.venv -> TA.tenv -> A.ast -> TA.env_tast
