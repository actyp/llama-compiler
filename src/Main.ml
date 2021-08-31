(** Usage message of llama *)
let usage_msg = "Usage: llama [--lex-only | --parse-only] <file>"

(** Variable for input file *)
let filename = ref ""

(** Variable for --lex-only option *)
let lex_only_opt = ref false

(** Variable for --parse-only option*)
let parse_only_opt = ref false

(** Function applied to filename provided *)
let anon_fun f = filename := f

(** command line options for llama *)
let speclist = [
  ("--lex-only", Arg.Set lex_only_opt, "Lexical analysis only");
  ("--parse-only", Arg.Set parse_only_opt, "Parsing and printing AST only");
]

(** [close_exit in_ch cd] closes abruptly channel [in_ch] and exits with code [cd] *)
let close_exit in_ch cd =
  close_in_noerr in_ch;
  exit(cd)

(** [lex_only_fun in_ch] performs only lexical analysis
    (printing tokens and lexems) on input channel [in_ch]  *)
let lex_only_fun in_ch =
  let lexbuf = Lexing.from_channel in_ch in
  let rec loop () =
    try
      let token = Lexer.lexer lexbuf in
      Printf.printf "Token: %s, Lexeme: \"%s\"\n"
        (Lexer.string_of_token token) (Lexing.lexeme lexbuf);
      if token <> Parser.EOF then loop ()
    with Error.Terminate ->
      close_in_noerr in_ch;
      exit(1)
  in
    Printf.printf "\n~~ Tokens and Lexemes ~~\n";
    loop ()

(** [gen_ast in_ch] parses the input channel [in_ch] and returns the AST *)
let gen_ast in_ch =
  let lexbuf = Lexing.from_channel in_ch in
  try
    Parser.program Lexer.lexer lexbuf
  with
    | Error.Terminate ->
        close_exit in_ch 1
    | _ ->
        Lexer.print_position lexbuf;
        Error.error "Syntax error";
        close_exit in_ch 1

(** [parse_only_fun in_ch] just creates and pretty prints the AST of input channel [in_ch] *)
let parse_only_fun in_ch = Ast.pprint (gen_ast in_ch)

(** [open_file f] tries to open file [f] handling any system error exception *)
let open_file f =
  try
    open_in f
  with Sys_error(msg) ->
    Printf.printf "System error%s\n" msg;
    exit(1)

(** [main] function parses command line arguments and behaves accordingly *)
let main =
  Arg.parse speclist anon_fun usage_msg;
  let in_ch = open_file !filename in
  if !lex_only_opt
  then lex_only_fun in_ch
  else if !parse_only_opt
  then parse_only_fun in_ch
