let usage_msg = "Usage: llama [--lex-only | --parse-only] <file>"

let filename = ref ""
let lex_only_opt = ref false
let parse_only_opt = ref false

let anon_fun f = filename := f
let speclist = [
  ("--lex-only", Arg.Set lex_only_opt, "Lexical analysis only");
  ("--parse-only", Arg.Set parse_only_opt, "Parsing and printing AST only");
]

let close_exit in_ch cd =
  close_in_noerr in_ch;
  exit(cd)

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

let parse_only_fun in_ch = Ast.pprint (gen_ast in_ch)

let open_file f =
  try
    open_in f
  with Sys_error(msg) ->
    Printf.printf "System error%s\n" msg;
    exit(1)

let main =
  Arg.parse speclist anon_fun usage_msg;
  let in_ch = open_file !filename in
  if !lex_only_opt then lex_only_fun in_ch
  else if !parse_only_opt then parse_only_fun in_ch
