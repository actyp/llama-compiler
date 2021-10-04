(** Usage message of llama *)
let usage_msg = "Usage: llama [--lex-only | --parse-only | --infer-only] <file>"

(** Variable for input file *)
let filename = ref ""

(** Variable for --lex-only option *)
let lex_only_opt = ref false

(** Variable for --parse-only option*)
let parse_only_opt = ref false

(** Variable for --infer-only option*)
let infer_only_opt = ref false

(** Function applied to filename provided *)
let anon_fun f = filename := f

(** command line options for llama *)
let speclist = [
  ("--lex-only", Arg.Set lex_only_opt, "Lexical analysis only");
  ("--parse-only", Arg.Set parse_only_opt, "Parsing and printing AST only");
  ("--infer-only", Arg.Set infer_only_opt, "Printing type-inferred AST only");
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
      close_exit in_ch 1
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

(** [parse_only_fun in_ch] generates and pretty prints the AST of input channel [in_ch] *)
let parse_only_fun in_ch = Ast.pprint (gen_ast in_ch)

(** [gen_typed_ast in_ch] generates the typed ast given the input channel [in_ch] *)
let gen_typed_ast in_ch =
  let ast = gen_ast in_ch in
  let venv, tenv = Environment.initial_envs () in
  try
    let venv', tenv', annotated_ast = Annotate.annotate venv tenv ast in
    let contree = Constraint.collect venv' tenv' annotated_ast in
    let subst_tbl = Unify.unify_and_solve contree in
    let typed_ast = Substitute.substitute_and_typecheck annotated_ast subst_tbl in
    typed_ast
  with Error.Terminate ->
    close_exit in_ch 1

(** [infer_only_fun in_ch] generates and pretty prints the TypedAST of input channel [in_ch] *)
let infer_only_fun in_ch = TypedAst.pprint (gen_typed_ast in_ch)

(** [open_file f] tries to open file [f] handling any system error exception *)
let open_file f =
  try
    open_in f
  with Sys_error(msg) ->
    Printf.printf "System error: %s\n" msg;
    exit(1)

(** [main] parses command line arguments and behaves accordingly *)
let main =
  Arg.parse speclist anon_fun usage_msg;
  let in_ch = open_file !filename in
  if !lex_only_opt
  then lex_only_fun in_ch
  else if !parse_only_opt
  then parse_only_fun in_ch
  else if !infer_only_opt
  then infer_only_fun in_ch
