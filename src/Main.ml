(** Usage message of llamac *)
let usage_msg = String.concat " " ["Usage:"; Sys.argv.(0); "[-flag] [--option] filename"]

(** Variable for input file *)
let filename = ref ""

(** Types of output options *)
type output_opt = Lex | Parse | Infer | IR | Asm | ToFiles

(** Variable for option selection *)
let output_opt: output_opt ref = ref ToFiles

(** [select_opt outp _] changes the value of [output_opt] to [outp] *)
let select_opt outp _ = output_opt := outp

let optmz_flag = ref false

(** command line options *)
let speclist = Arg.align [
  ("\nFlags & Options:", Arg.Unit ignore, " ");
  ("-O", Arg.Set optmz_flag, " Optimization flag");
  ("-i", Arg.Unit (select_opt IR), " Output of LLVM IR to std_out");
  ("-f", Arg.Unit (select_opt Asm), " Output of assembly to std_out");
  ("--lex", Arg.Unit (select_opt Lex) , " Lexical analysis only");
  ("--parse", Arg.Unit (select_opt Parse), " Parsing and printing AST only");
  ("--infer", Arg.Unit (select_opt Infer), " Printing type-inferred AST only");
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
    let env_annotated_ast = Annotate.annotate venv tenv ast in
    let annotated_ast = TypedAst.tast_from_env_tast env_annotated_ast in
    env_annotated_ast
    |> Constraint.collect
    |> Unify.unify_and_solve
    |> Substitute.substitute_and_typecheck annotated_ast
  with Error.Terminate ->
    close_exit in_ch 1

(** [infer_only_fun in_ch] generates and pretty prints the TypedAST of input channel [in_ch] *)
let infer_only_fun in_ch = TypedAst.pprint (gen_typed_ast in_ch)

(** [gen_ir in_ch] generates the LLVM IR given the input channel [in_ch] *)
let gen_ir in_ch optmz =
  let tast = gen_typed_ast in_ch in
  try
    let conv_tast = AConversion.convert tast in
    conv_tast
    |> Escape.analyse
    |> IRCodegen.generate_ir optmz conv_tast
  with Error.Terminate ->
    close_exit in_ch 1

(** [ir_out_fun in_ch] generates and outputs to std_out the LLVM IR of input channel [in_ch] *)
let ir_out_fun in_ch optmz = IRCodegen.pprint (gen_ir in_ch optmz)

(** [parse_cmd_line ()] parses command line arguments and returns the in_channel
    after opening [filename], while handling any error occured *)
let parse_cmd_line () =
  try
    Arg.parse speclist (fun f -> filename := f) usage_msg;
    if !filename <> ""
    then open_in !filename
    else raise (Sys_error ("filename is empty"))
  with
    Sys_error msg ->
      Printf.eprintf "%s: %s.\n" Sys.argv.(0) msg;
      Arg.usage speclist usage_msg;
      exit(1)

(** [main] parses command line arguments and behaves accordingly *)
let main =
  let in_ch = parse_cmd_line () in
  match !output_opt with
  | Lex -> lex_only_fun in_ch
  | Parse -> parse_only_fun in_ch
  | Infer -> infer_only_fun in_ch
  | IR -> ir_out_fun in_ch !optmz_flag
  | Asm -> ()
  | ToFiles -> ()
