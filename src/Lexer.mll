{
open Lexing
open Parser

let print_position lexbuf =
  Error.print_position (Format.err_formatter) (Error.PosContext (lexbuf.lex_start_p, lexbuf.lex_curr_p) )

let escaped_to_char str lexbuf = match str with
  | "\\n" -> '\n'
  | "\\t" -> '\t'
  | "\\r" -> '\r'
  | "\\0" -> '\000'
  | "\\\\"  -> '\\'
  | "\\'" -> '\''
  | "\\\""-> '"'
  | s     -> try
               Char.chr (int_of_string ("0"^s))
             with
               | _ -> print_position lexbuf; Error.fatal "unknown escaped character"
}

let digit       = ['0' - '9']
let llama_float = digit+('.'digit+(['e' 'E']['-' '+']?digit+)?)
let hexdig      = ['0'-'9''a'-'f''A'-'F']
let upCase      = ['A' - 'Z']
let lowCase     = ['a' - 'z']
let id          = ( upCase | lowCase | '_' | digit )
let white       = [' ' '\t' '\r']

rule lexer = parse
  (* whitespaces skipped *)
  | white+                            { lexer lexbuf }

  (* linefeeds increase line count *)
  | '\n'                              { new_line lexbuf; lexer lexbuf }

  (* integer *)
  | digit+ as num                     { INT(int_of_string num) }

  (* float *)
  | llama_float as fnum               { FLOAT(float_of_string fnum) }

  (* comments *)
  | "--"                              { parse_inline_comment lexbuf }
  | "(*"                              { parse_multiline_comment 0 lexbuf }

  (* keywords *)
  | "and"                             { AND }
  | "array"                           { ARRAY }
  | "begin"                           { BEGIN }
  | "bool"                            { BOOL }
  | "char"                            { TYPE_CHAR }
  | "delete"                          { DELETE }
  | "dim"                             { DIM }
  | "do"                              { DO }
  | "done"                            { DONE }
  | "downto"                          { DOWNTO }
  | "else"                            { ELSE }
  | "end"                             { END }
  | "false"                           { FALSE }
  | "float"                           { TYPE_FLOAT }
  | "for"                             { FOR }
  | "if"                              { IF }
  | "in"                              { IN }
  | "int"                             { TYPE_INT}
  | "let"                             { LET }
  | "match"                           { MATCH }
  | "mod"                             { MOD }
  | "mutable"                         { MUTABLE }
  | "new"                             { NEW }
  | "not"                             { NOT }
  | "of"                              { OF }
  | "rec"                             { REC }
  | "ref"                             { REF }
  | "then"                            { THEN }
  | "to"                              { TO }
  | "true"                            { TRUE }
  | "type"                            { TYPE }
  | "unit"                            { UNIT }
  | "while"                           { WHILE }
  | "with"                            { WITH }

  (* identifiers *)
  | lowCase+id* as id                 { ID(id) }
  | upCase+id*  as cid                { CID(cid) }

  (* operators *)
  | "->"                              { GIVES }
  | "="                               { STR_EQUAL }
  | "|"                               { BAR }
  | "+"                               { PLUS }
  | "-"                               { MINUS }
  | "*"                               { TIMES }
  | "/"                               { DIV }
  | "+."                              { FLOAT_PLUS }
  | "-."                              { FLOAT_MINUS }
  | "*."                              { FLOAT_TIMES }
  | "/."                              { FLOAT_DIV }
  | "**"                              { POWER }
  | "!"                               { EXCLAMATION_MARK }
  | ";"                               { SEMICOLON }
  | "&&"                              { OPERATOR_AND }
  | "||"                              { OR }
  | "<>"                              { STR_UNEQUAL }
  | "<"                               { LESS }
  | ">"                               { GREATER }
  | "<="                              { LESS_EQ }
  | ">="                              { GREATER_EQ }
  | "=="                              { NAT_EQUAL }
  | "!="                              { NAT_UNEQUAL }
  | ":="                              { ASSIGN }

  (* separators *)
  | "("                               { LPAREN }
  | ")"                               { RPAREN }
  | "["                               { LBRACKET }
  | "]"                               { RBRACKET }
  | ","                               { COMMA }
  | ":"                               { COLON }

  (* char *)
  | '\''                              { parse_char lexbuf }

  (* string *)
  | '"'                               { parse_string (Buffer.create 17) lexbuf }

  | eof                               { EOF }
  | _ as chr                          {
                                        print_position lexbuf;
                                        Error.warning "character (ASCII: 0x%X) cannot be parsed" (Char.code chr);
                                        lexer lexbuf
                                      }


and parse_multiline_comment level = parse
  | "*)"                              {
                                        if level == 0 then lexer lexbuf
                                        else parse_multiline_comment (level-1) lexbuf
                                      }

  | "(*"                              { parse_multiline_comment (level+1) lexbuf }
  | '\n'                              { new_line lexbuf; parse_multiline_comment level lexbuf }

  | eof                               { print_position lexbuf; Error.fatal "unterminated comment at the end-of-file" }
  | _                                 { parse_multiline_comment level lexbuf }


and parse_inline_comment = parse
  | '\n'                              { new_line lexbuf; lexer lexbuf }
  | eof                               { EOF }
  | _                                 { parse_inline_comment lexbuf }


and parse_char = parse
  | (('\\' ['n' 't' 'r' '0' '\\' '\'' '"']) as esc) '\''
                                      { CHAR(escaped_to_char esc lexbuf) }

  | '\\' (('x' hexdig hexdig) as esc) '\''
                                      { CHAR(escaped_to_char esc lexbuf) }

  | (_ as chr) '\''                   { CHAR(chr) }
  | eof                               { Error.fatal "unterminated char at the end-of-file" }

  | _                                 { print_position lexbuf; Error.error "invalid escape sequence"; lexer lexbuf }


and parse_string buf = parse
  | '"'                               { STRING(Buffer.contents buf) }

  | ('\\' ['n' 't' 'r' '0' '\\' '\'' '"']) as esc
                                      { Buffer.add_char buf (escaped_to_char esc lexbuf); parse_string buf lexbuf }

  | "\\" (('x' hexdig hexdig) as esc) { Buffer.add_char buf (escaped_to_char esc lexbuf); parse_string buf lexbuf }

  | '\n'                              { print_position lexbuf; Error.fatal "multiline string" }
  | eof                               { Error.fatal "unterminated string at the end-of-file" }

  | _ as chr                          { Buffer.add_char buf chr; parse_string buf lexbuf }

{
  let string_of_token token =
    match token with
      | WITH -> "WITH"
      | WHILE -> "WHILE"
      | UNIT -> "UNIT"
      | TYPE_INT -> "TYPE_INT"
      | TYPE_FLOAT -> "TYPE_FLOAT"
      | TYPE_CHAR -> "TYPE_CHAR"
      | TYPE -> "TYPE"
      | TRUE -> "TRUE"
      | TO -> "TO"
      | TIMES -> "TIMES"
      | THEN -> "THEN"
      | STRING(s) -> Printf.sprintf "STRING (%s)" s
      | SEMICOLON -> "SEMICOLON"
      | RPAREN -> "RPAREN"
      | REF -> "REF"
      | REC -> "REC"
      | RBRACKET -> "RBRACKET"
      | POWER -> "POWER"
      | PLUS -> "PLUS"
      | OR -> "OR"
      | OPERATOR_AND -> "OPERATOR_AND"
      | OF -> "OF"
      | NOT -> "NOT"
      | NEW -> "NEW"
      | STR_UNEQUAL -> "STR_UNEQUAL"
      | NAT_UNEQUAL -> "NAT_UNEQUAL"
      | MUTABLE -> "MUTABLE"
      | MOD -> "MOD"
      | MINUS -> "MINUS"
      | MATCH -> "MATCH"
      | LPAREN -> "LPAREN"
      | LET -> "LET"
      | LESS_EQ -> "LESS_EQ"
      | LESS -> "LESS"
      | LBRACKET
      | INT(_) -> "INT"
      | IN -> "IN"
      | IF -> "IF"
      | ID(_) -> "ID"
      | GREATER_EQ -> "GREATER_EQ"
      | GREATER -> "GREATER"
      | GIVES -> "GIVES"
      | FOR -> "FOR"
      | FLOAT_TIMES -> "FLOAT_TIMES"
      | FLOAT_PLUS -> "FLOAT_PLUS"
      | FLOAT_MINUS -> "FLOAT_MINUS"
      | FLOAT_DIV -> "FLOAT_DIV"
      | FLOAT(_) -> "FLOAT"
      | FALSE -> "FALSE"
      | EXCLAMATION_MARK -> "EXCLAMATION_MARK"
      | STR_EQUAL -> "STR_EQUAL"
      | NAT_EQUAL -> "NAT_EQUAL"
      | EOF -> "EOF"
      | END -> "END"
      | ELSE -> "ELSE"
      | DOWNTO -> "DOWNTO"
      | DONE -> "DONE"
      | DO -> "DO"
      | DIV -> "DIV"
      | DIM -> "DIM"
      | DELETE -> "DELETE"
      | COMMA -> "COMMA"
      | COLON -> "COLON"
      | CID(_) -> "CID"
      | CHAR(_) -> "CHAR"
      | BOOL -> "BOOL"
      | BEGIN -> "BEGIN"
      | BAR -> "BAR"
      | ASSIGN -> "ASSIGN"
      | ARRAY -> "ARRAY"
      | AND -> "AND"
}
