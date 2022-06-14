module Esc = Escape
module L = Llvm
module TA = TypedAst

(** [pprint_to_file filename llmodule] prints the llvm module [llmodule] to file [filename] *)
val pprint_to_file: string -> L.llmodule -> unit

(** [pprint llmodule] prints the llvm module [llmodule] to stdout *)
val pprint: L.llmodule -> unit

(** [generate_ir opt tast info_tbl] returns the generated llvm module from the given [tast] and [info_tbl].
    Optimizations are enabled if [opt] is true *)
val generate_ir: bool -> TA.tast -> Esc.info_tbl_t -> L.llmodule