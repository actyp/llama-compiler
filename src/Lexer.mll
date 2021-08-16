{
open Lexing
open Parser
open Error

let print_position lexbuf =
  print_position (Format.err_formatter) (PosPoint lexbuf.lex_curr_p)

let escaped_to_char str = match str with
    "\\n" -> '\n'
  | "\\t" -> '\t'
  | "\\r" -> '\r'
  | "\\0" -> '\000'
  | "\\"  -> '\\'
  | "\\'" -> '\''
  | "\\\""-> '"'
  | s     -> try
               Char.chr (int_of_string ("0"^s))
             with
               | _ -> raise (Invalid_argument "escaped_to_char")
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
                                        error  "character (ASCII: 0x%X) cannot be parsed" (Char.code chr);
                                        lexer lexbuf
                                      }


and parse_multiline_comment level = parse
  | "*)"                              {
                                        if level == 0 then lexer lexbuf
                                        else parse_multiline_comment (level-1) lexbuf
                                      }

  | "(*"                              { parse_multiline_comment (level+1) lexbuf }
  | '\n'                              { new_line lexbuf; parse_multiline_comment level lexbuf }

  | eof                               { print_position lexbuf; fatal "unterminated comment at the end-of-file"; EOF }
  | _                                 { parse_multiline_comment level lexbuf }


and parse_inline_comment = parse
  | '\n'                              { new_line lexbuf; lexer lexbuf }
  | eof                               { EOF }
  | _                                 { parse_inline_comment lexbuf }


and parse_char = parse
  | (('\\' ['n' 't' 'r' '0' '\\' '\'' '"']) as esc) '\''
                                      { CHAR(escaped_to_char esc) }

  | "\\" (('x' hexdig hexdig) as esc) '\''
                                      { CHAR(escaped_to_char esc) }

  | (_ as chr) '\''                   { CHAR(chr) }
  | eof                               { fatal "unterminated char at the end-of-file"; EOF }

  | _                                 { print_position lexbuf; error "invalid escape sequence"; lexer lexbuf }


and parse_string buf = parse
  | '"'                               { STRING(Buffer.contents buf) }

  | ('\\' ['n' 't' 'r' '0' '\\' '\'' '"']) as esc
                                      { Buffer.add_char buf (escaped_to_char esc); parse_string buf lexbuf }

  | "\\" (('x' hexdig hexdig) as esc) { Buffer.add_char buf (escaped_to_char esc); parse_string buf lexbuf }

  | '\n'                              { print_position lexbuf; fatal "multiline string"; EOF }
  | eof                               { fatal "unterminated string at the end-of-file"; EOF }

  | _ as chr                          { Buffer.add_char buf chr; parse_string buf lexbuf }
