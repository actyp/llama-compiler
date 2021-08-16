open Parser
open Lexer

let main =
  let lexbuf = Lexing.from_channel stdin in
  let ast = Parser.program Lexer.lexer lexbuf in
    Ast.pprint ast
