module H = Hashtbl
module S = Symbol
module T = Types
module TA = TypedAst

(** [tbl_entry] type holding infos about escaping vars and functions *)
type tbl_entry =
  | TempVarInfo of { dec_depth: int; esc_flag: bool; func_sym: S.symbol }
  | VarInfo of { dec_depth: int; func_sym: S.symbol; esc_offset: int }
  | FuncInfo of { dec_depth: int; esc_list: (S.symbol * T.ty) list }

(** [info_tbl_t] type of hashtbl, mapping ints (obtained from symbols) to [tbl_entry] *)
type info_tbl_t = (int, tbl_entry) H.t

(** [analyse tast] traverses and analyses TypedAst returning the [info_tbl_t] hashtbl
    containing information about escaping variables and all functions *)
val analyse: TA.tast -> info_tbl_t

(** [pprint tbl] pretty prints (in random order) the mappings of [tbl] *)
val pprint: info_tbl_t -> unit
