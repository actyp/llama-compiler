module H = Hashtbl
module L = Llvm
module S = Symbol
module T = Types
module TA = TypedAst

(** [info] type holding infos about escaping vars and functions 
    Note: llvalue_opt is None for all after the analysis and 
    will be filled dynamically on IRCodegen *)
type info =
  | LocalVarInfo of { name_sym: S.symbol; ty: T.ty; dec_depth: int; func_sym: S.symbol; llvalue_opt: L.llvalue option } 
  | EscVarInfo of { name_sym: S.symbol; ty: T.ty; dec_depth: int; func_sym: S.symbol; frame_offset: int }
  | FuncInfo of { name_sym: S.symbol; ty: T.ty; dec_depth: int; local_list: (S.symbol * T.ty) list; esc_list: (S.symbol * T.ty) list }

(** [info_tbl_t] type of hashtbl, mapping ints (obtained from symbols) to [info] *)
type info_tbl_t = (int, info) H.t

(** [tbl_add tbl name_sym entry] adds/overwrites the mapping int (of [name_sym]) -> [entry]
    in info_tbl_t [tbl] *)
val tbl_add: info_tbl_t -> S.symbol -> info -> unit

(** [tbl_find_opt info_tbl name_sym] returns the info option of looking up in 
    info_tbl_t [info_tbl] for the key (= int of name_sym symbol) binding *)
val tbl_find_opt: info_tbl_t -> S.symbol -> info option

(** [analyse tast] traverses and analyses TypedAst returning the [info_tbl_t] hashtbl
    containing information about escaping variables and all functions *)
val analyse: TA.tast -> info_tbl_t

(** [pprint tbl] pretty prints (in random order) the mappings of [tbl] *)
val pprint: info_tbl_t -> unit
