exception Terminate

type lpos = Lexing.position
val pp_lpos : Format.formatter -> lpos -> unit

type lpos_pair = lpos * lpos
val pp_lpos_pair : Format.formatter -> lpos_pair -> unit

type position =
  | PosPoint of lpos
  | PosContext of lpos * lpos
  | PosDummy

(** [position_point lpos] returns [PosPoint lpos] *)
val position_point : lpos -> position

(** [position_context (lp1, lp2)] returns [PosContext (lp1, lp2)] *)
val position_context : lpos * lpos -> position

(** [position_dummy] is PosDummy *)
val position_dummy : position

(** [print_position fmt pos] prints with formatter [fmt] position [pos] *)
val print_position : Format.formatter -> position -> unit

(** [internal_raw (fname, lnum) fmt [args]] prints internal error message based on
    filename string [fname] and line number [lnum] and applies [args] to formatter [fmt].
    Raises: Terminate *)
val internal_raw : string * int -> ('a, Format.formatter, unit, unit, unit, 'b) format6 -> 'a

(** [fatal fmt [args]] prints fatal error and applies [args] to formatter [fmt]
    Raises: Terminate *)
val fatal : ('a, Format.formatter, unit, unit, unit, 'b) format6 -> 'a

(** [error fmt [args]] prints error and applies [args] to formatter [fmt]
    Raises: Terminate in case of many errors *)
val error : ('a, Format.formatter, unit, unit, unit, unit) format6 -> 'a

(** [warning fmt [args]] prints warning and applies [args] to formatter [fmt]
    It has a threshold of warnings shown *)
val warning : ('a, Format.formatter, unit, unit, unit, unit) format6 -> 'a

(** [message fmt [args]] prints the message applying [args] to formatter [fmt] *)
val message : ('a, Format.formatter, unit, unit, unit, unit) format6 -> 'a

(** [pos_fatal_error lpos_pair] prints the error location obtained from [lpos_pair]
    and returns [fatal] function to apply to remaining arguments *)
val pos_fatal_error :
  lpos_pair -> ('a, Format.formatter, unit, unit, unit, 'b) format6 -> 'a

(** [pos_warning_error lpos_pair] prints the error location obtained from [lpos_pair]
    and returns [warning] function to apply to remaining arguments *)
val pos_warning_error :
  lpos_pair -> ('a, Format.formatter, unit, unit, unit, unit) format6 -> 'a
