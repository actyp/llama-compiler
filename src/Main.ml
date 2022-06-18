(** Usage message of llamac *)
let usage_msg = String.concat " " ["Usage:"; Sys.argv.(0); "[-flag] [--option] filename"]

(** llc exetutable *)
let llc_exe = "llc"

(** clang exetutable *)
and clang_exe = "clang"

(** runtime library files *)
and liblla_file = "src/runtime/liblla.a"
and libgc_file = "src/runtime/libgc.a"

(** Variable for input file *)
let filename = ref ""

(** Types of output options *)
type output_option = Lex | Parse | Infer | IR | Asm | ToFiles

(** Variable for option selection *)
let output_opt: output_option ref = ref ToFiles

(** [select_opt outp _] changes the value of [output_opt] to [outp] *)
let select_opt outp _ = output_opt := outp

let optmz_flag = ref false

(** command line options *)
let speclist = Arg.align [
  ("\nFlags & Options:", Arg.Unit ignore, " ");
  ("-O", Arg.Set optmz_flag, " Llvm IR Optimization flag");
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
  lexbuf.Lexing.lex_curr_p <- { lexbuf.Lexing.lex_curr_p with pos_fname = !filename };
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
let ir_only_fun in_ch optmz = IRCodegen.pprint (gen_ir in_ch optmz)

(** [gen_asm in_ch optmz to_stdout_only] generates and outputs assembly to std_out if [to_stdout_only] is true
    or generates and stores to file <filename'>.imm the llvm IR, to file <filename'>.asm the assembly and 
    generates the final executable file <filename'>, where <filename'> i the <filename> without file extension *)
let gen_asm in_ch optmz to_stdout_only = 
  let exec_and_check_cmd cmd =
    let exit_with_msg msg =
      let prefix = "Error: Execution of command '" ^ cmd ^ "'"in
      Printf.printf "%s %s\n" prefix msg;
      close_exit in_ch 1
    in
    match Unix.system cmd with
      | WEXITED code when code <> 0 -> exit_with_msg ("returned code: " ^ (string_of_int code))
      | WSIGNALED signum -> exit_with_msg ("killed by signal with number: " ^ (string_of_int signum))
      | WSTOPPED signum -> exit_with_msg ("stopped by signal with number: " ^ (string_of_int signum))
      | _ -> ()
  in
  let filename_without_extension = Filename.remove_extension !filename in

  let ir_filename = filename_without_extension ^ ".imm" in
  let ir_module = gen_ir in_ch optmz in
  IRCodegen.pprint_to_file ir_filename ir_module;
  
  let asm_filename = filename_without_extension ^ ".asm" in
  let to_asm_cmd = Printf.sprintf "%s --relocation-model=pic -o %s %s" llc_exe asm_filename ir_filename in
  exec_and_check_cmd to_asm_cmd;

  if to_stdout_only then begin
    let cat_cmd = Printf.sprintf "cat %s" asm_filename in
    exec_and_check_cmd cat_cmd;
    let rm_cmd = Printf.sprintf "rm %s %s" ir_filename asm_filename in
    exec_and_check_cmd rm_cmd
  end
  else begin
    let exe_filename = filename_without_extension ^ ".out" in
    (* -lm is the link to math library 'libm' used by liblla.a file *)
    let to_exe_cmd = Printf.sprintf "%s -o %s %s %s %s -lm" clang_exe exe_filename asm_filename libgc_file liblla_file in
    exec_and_check_cmd to_exe_cmd
  end

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
  | IR -> ir_only_fun in_ch !optmz_flag
  | Asm -> gen_asm in_ch !optmz_flag true
  | ToFiles -> gen_asm in_ch !optmz_flag false
