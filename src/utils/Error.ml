open Format
open Lexing

exception Terminate

let numErrors = ref 0
let maxErrors = ref 10
let flagWarnings = ref true
let numWarnings = ref 0
let maxWarnings = ref 200

type lpos = Lexing.position

let pp_lpos ppf (lpos: lpos) = match lpos with
  { pos_fname; pos_lnum; pos_bol; pos_cnum; } ->
    fprintf ppf "{pos_fname = \"%s\"; pos_lnum = %d; pos_bol = %d; pos_cnum = %d}"
      pos_fname pos_lnum pos_bol pos_cnum

type lpos_pair = lpos * lpos
[@@deriving show]

type position =
    PosPoint   of lpos
  | PosContext of lpos * lpos
  | PosDummy

let position_point lpos = PosPoint lpos
let position_context ((lpos_start, lpos_end): lpos_pair) = PosContext (lpos_start, lpos_end)
let position_dummy = PosDummy

let print_position ppf pos =
  match pos with
  | PosPoint lpos ->
      fprintf ppf "@[line %d,@ character %d:@]@ " lpos.pos_lnum (lpos.pos_cnum - lpos.pos_bol)
  | PosContext (lpos_start, lpos_end) ->
      if lpos_start.pos_fname != lpos_end.pos_fname then
        fprintf ppf "@[file \"%s\",@ line %d,@ character %d to@ file %s,@ line %d,@ character %d:@]@ "
          lpos_start.pos_fname lpos_start.pos_lnum (lpos_start.pos_cnum - lpos_start.pos_bol) 
          lpos_end.pos_fname lpos_end.pos_lnum (lpos_end.pos_cnum - lpos_end.pos_bol)
      else if lpos_start.pos_lnum != lpos_end.pos_lnum then
        fprintf ppf "@[file \"%s\", line %d,@ character %d to@ line %d,@ character %d:@]@ "
          lpos_start.pos_fname 
          lpos_start.pos_lnum (lpos_start.pos_cnum - lpos_start.pos_bol)
          lpos_end.pos_lnum (lpos_end.pos_cnum - lpos_end.pos_bol)
      else if lpos_start.pos_cnum - lpos_start.pos_bol != lpos_end.pos_cnum - lpos_end.pos_bol then
        fprintf ppf "@[file \"%s\", line %d,@ characters %d to %d:@]@ "
          lpos_start.pos_fname lpos_start.pos_lnum
          (lpos_start.pos_cnum - lpos_start.pos_bol) (lpos_end.pos_cnum - lpos_end.pos_bol)
      else
        fprintf ppf "@[file \"%s\", line %d, character %d:@]@ "
        lpos_start.pos_fname lpos_start.pos_lnum (lpos_start.pos_cnum - lpos_start.pos_bol)
  | PosDummy ->
      ()

let no_out buf pos len = ()
let no_flush () = ()
let null_formatter = make_formatter no_out no_flush

let internal fmt =
  let fmt = "@[<v 2>Internal error: " ^^ fmt ^^ "@]@;@?" in
  incr numErrors;
  let cont ppf = raise Terminate in
  kfprintf cont err_formatter fmt

and fatal fmt =
  let fmt = "@[<v 2>Fatal error: " ^^ fmt ^^ "@]@;@?" in
  incr numErrors;
  let cont ppf = raise Terminate in
  kfprintf cont err_formatter fmt

and error fmt =
  let fmt = "@[<v 2>Error: " ^^ fmt ^^ "@]@;@?" in
  incr numErrors;
  if !numErrors >= !maxErrors then
    let cont ppf =
      eprintf "Too many errors, aborting...\n";
      raise Terminate
    in
    kfprintf cont err_formatter fmt
  else
    eprintf fmt

and warning fmt =
  let fmt = "@[<v 2>Warning: " ^^ fmt ^^ "@]@;@?" in
  if !flagWarnings then
  begin
    incr numWarnings;
    if !numWarnings >= !maxWarnings then
      let cont ppf =
        eprintf "Too many warnings, no more will be shown...\n";
        flagWarnings := false
      in
      kfprintf cont err_formatter fmt
    else
      eprintf fmt
  end
  else
    fprintf null_formatter fmt

and message fmt =
  let fmt = "@[<v 2>" ^^ fmt ^^ "@]@;@?" in
  eprintf fmt

let pos_internal_error loc =
  print_position (err_formatter) (position_context loc);
  fatal

and pos_fatal_error loc =
  print_position (err_formatter) (position_context loc);
  fatal

and pos_warning_error loc =
  print_position (err_formatter) (position_context loc);
  warning
