/* integer, float */

%token <int> INT
%token <float> FLOAT


/* keywords */

%token AND
%token ARRAY
%token BEGIN
%token BOOL
%token TYPE_CHAR
%token DELETE
%token DIM
%token DO
%token DONE
%token DOWNTO
%token ELSE
%token END
%token FALSE
%token TYPE_FLOAT
%token FOR
%token IF
%token IN
%token TYPE_INT
%token LET
%token MATCH
%token MOD
%token MUTABLE
%token NEW
%token NOT
%token OF
%token REC
%token REF
%token THEN
%token TO
%token TRUE
%token TYPE
%token UNIT
%token WHILE
%token WITH


/* identifiers */

%token <string> ID
%token <string> CID


/* operators */

%token GIVES
%token STR_EQUAL
%token BAR
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token FLOAT_PLUS
%token FLOAT_MINUS
%token FLOAT_TIMES
%token FLOAT_DIV
%token POWER
%token EXCLAMATION_MARK
%token SEMICOLON
%token OPERATOR_AND
%token OR
%token STR_UNEQUAL
%token LESS
%token GREATER
%token LESS_EQ
%token GREATER_EQ
%token NAT_EQUAL
%token NAT_UNEQUAL
%token ASSIGN


/* separators */

%token LPAREN
%token RPAREN
%token LBRACKET
%token RBRACKET
%token COMMA
%token COLON


/* character, string */

%token <char> CHAR
%token <string> STRING


%token EOF


/* associativity, priority */

%nonassoc IN
%left SEMICOLON
%nonassoc UIF
%nonassoc ELSE
%nonassoc ASSIGN
%left OR
%left OPERATOR_AND
%nonassoc STR_EQUAL STR_UNEQUAL LESS LESS_EQ GREATER GREATER_EQ NAT_EQUAL NAT_UNEQUAL

%left PLUS MINUS FLOAT_PLUS FLOAT_MINUS
%left TIMES DIV MOD FLOAT_TIMES FLOAT_DIV

%right POWER
%left UN
%nonassoc DELETE

%right GIVES
%left REF
%nonassoc OF


/* parsed types */

%start program
%type <Ast.ast> program
%type <Ast.def list> def_list
%type <Ast.def> letdef
%type <Ast.dec> def
%type <Ast.param> par
%type <Ast.def> typedef
%type <Ast.tdec> tdef
%type <Ast.constr> constr
%type <Ast._type> _type
%type <Ast.expr> base_expr
%type <Ast.expr> expr
%type <Ast.count_dir> count
%type <string> unop
%type <string> binop
%type <Ast.clause> clause
%type <Ast.base_pattern> base_pattern
%type <Ast.constr_pattern> constr_pattern
%%


/* patterns and semantic actions */

program:
  def_list EOF { $1 }
;

def_list:
  | /* nothing */    { [] }
  | letdef def_list  { $1 :: $2 }
  | typedef def_list { $1 :: $2 }
;

letdef:
  LET; option(REC { $loc }); def; list(AND def { $2 }) { Ast.LetDef {recur_opt = $2; decs = $3 :: $4; loc = $loc} }
;

def:
  | ID; option(COLON _type { $2 }); STR_EQUAL; expr       { Ast.ConstVarDec {name_sym = Symbol.symbol($1); ty_opt = $2; value = $4; loc = $loc} }
  | ID; par+; option(COLON _type { $2 }); STR_EQUAL; expr { Ast.FunctionDec {name_sym = Symbol.symbol($1); params = $2; result_ty_opt = $3; body = $5; loc = $loc} }
  | MUTABLE; ID; option(COLON _type { $2 })               { Ast.MutVarDec   {name_sym = Symbol.symbol($2); ty_opt = $3; loc = $loc($2)} }
  | MUTABLE; ID; LBRACKET; expr; list(COMMA expr { $2 }); RBRACKET; option(COLON _type { $2 })
                                                          { Ast.ArrayDec {name_sym = Symbol.symbol($2); dims_len_exprs = $4 :: $5; ty_opt = $7; loc = $loc($2) } }
;

par:
  | ID                            { Ast.Param {name_sym = Symbol.symbol($1); ty_opt = None;    loc = $loc} }
  | LPAREN ID COLON _type RPAREN  { Ast.Param {name_sym = Symbol.symbol($2); ty_opt = Some $4; loc = $loc($2)} }
;

typedef:
  TYPE; tdef; list(AND tdef { $2 }) { Ast.TypeDef {tdecs = $2 :: $3; loc = $loc} }
;

tdef:
  ID; STR_EQUAL; constr; list(BAR constr { $2 }) { Ast.TypeDec {name_sym = Symbol.symbol($1); constrs = $3 :: $4; loc = $loc} }
;

constr:
  CID; option(OF; _type+ { $2 }) { Ast.Constr {name_sym = Symbol.symbol($1); tys_opt = $2; loc = $loc} }
;

_type:
  | UNIT                   { Ast.TY_UNIT  }
  | TYPE_INT               { Ast.TY_INT   }
  | TYPE_CHAR              { Ast.TY_CHAR  }
  | BOOL                   { Ast.TY_BOOL  }
  | TYPE_FLOAT             { Ast.TY_FLOAT }
  | LPAREN _type RPAREN    { $2 }
  | _type GIVES _type      { Ast.TY_FUNC {from_ty = $1; to_ty = $3} }
  | _type REF              { Ast.TY_REF $1 }
  | ARRAY; option(LBRACKET; TIMES; list(COMMA TIMES { () }); RBRACKET { 1 + List.length $3 }); OF; _type
                           { Ast.TY_ARRAY {dims_num_opt = $2; ty = $4} }
  | ID                     { Ast.TY_ID (Symbol.symbol($1)) }
;

base_expr:
  | ID                                                       { Ast.E_ID         {name_sym = Symbol.symbol($1); loc = $loc} }
  | CID                                                      { Ast.E_ConstrCall {name_sym = Symbol.symbol($1); param_exprs = []; loc = $loc} }
  | INT                                                      { Ast.E_Int        {value = $1; loc = $loc} }
  | FLOAT                                                    { Ast.E_Float      {value = $1; loc = $loc} }
  | CHAR                                                     { Ast.E_Char       {value = $1; loc = $loc} }
  | STRING                                                   { Ast.E_String     {value = $1; loc = $loc} }
  | TRUE                                                     { Ast.E_BOOL       {value = true; loc = $loc} }
  | FALSE                                                    { Ast.E_BOOL       {value = false; loc = $loc} }
  | LPAREN RPAREN                                            { Ast.E_Unit       $loc }
  | ID; LBRACKET; expr; list(COMMA expr { $2 }); RBRACKET    { Ast.E_ArrayRef   {name_sym = Symbol.symbol($1); exprs = $3 :: $4; loc = $loc} }
  | LPAREN; expr; RPAREN                                     { $2 }
;

par_expr:
  | base_expr                                                { $1 }
  | EXCLAMATION_MARK; base_expr                              { Ast.E_FuncCall {name_sym = Symbol.symbol("( ! )"); param_exprs = [$2]; loc = $loc} }
;

expr:
  | unop expr %prec UN                                       { Ast.E_FuncCall     {name_sym = Symbol.symbol($1); param_exprs = [$2]; loc = $loc} }
  | expr binop expr                                          { Ast.E_FuncCall     {name_sym = Symbol.symbol($2); param_exprs = [$1; $3]; loc = $loc} }
  | ID; par_expr+                                            { Ast.E_FuncCall     {name_sym = Symbol.symbol($1); param_exprs = $2; loc = $loc} }
  | CID; par_expr+                                           { Ast.E_ConstrCall   {name_sym = Symbol.symbol($1); param_exprs = $2; loc = $loc} }
  | DIM; INT?; ID                                            { Ast.E_ArrayDim     {dim_opt = $2; array_name_sym = Symbol.symbol($3); loc = $loc} }
  | NEW; _type                                               { Ast.E_New          {ty = $2; loc = $loc} }
  | DELETE; expr                                             { Ast.E_Delete       {expr = $2; loc = $loc} }
  | letdef; IN; expr                                         { Ast.E_LetIn        {letdef = $1; in_expr = $3; loc = $loc($2)} }
  | BEGIN; expr; END                                         { Ast.E_BeginEnd     {expr = $2; loc = $loc} }
  | IF; expr; THEN; expr; ELSE; expr                         { Ast.E_MatchedIF    {if_expr = $2; then_expr = $4; else_expr = $6; loc = $loc} }
  | IF; expr; THEN; expr %prec UIF                           { Ast.E_MatchedIF    {if_expr = $2; then_expr = $4; else_expr = Ast.E_Unit $loc; loc = $loc} }
  | WHILE; expr; DO; expr; DONE                              { Ast.E_WhileDoDone  {while_expr = $2; do_expr = $4; loc = $loc} }
  | FOR; ID; STR_EQUAL; expr; count; expr; DO; expr; DONE    { Ast.E_ForDoDone    {count_var_sym = Symbol.symbol($2); start_expr = $4; count_dir = $5; end_expr = $6; do_expr = $8; loc = $loc} }
  | MATCH; expr; WITH; clause; list(BAR; clause { $2 }); END { Ast.E_MatchWithEnd {match_expr = $2; with_clauses = $4 :: $5; loc = $loc} }
  | base_expr                                                { $1 }
;

count:
  | TO     { Ast.TO     $loc }
  | DOWNTO { Ast.DOWNTO $loc }
;

%inline unop:
  | PLUS             { "( ~+ )"  }
  | MINUS            { "( ~- )"  }
  | FLOAT_PLUS       { "( ~+. )" }
  | FLOAT_MINUS      { "( ~-. )" }
  | EXCLAMATION_MARK { "( ! )"   }
  | NOT              { "( not )" }
;

%inline binop:
  | PLUS         { "( + )"   }
  | MINUS        { "( - )"   }
  | TIMES        { "( * )"   }
  | DIV          { "( / )"   }
  | FLOAT_PLUS   { "( +. )"  }
  | FLOAT_MINUS  { "( -. )"  }
  | FLOAT_TIMES  { "( *. )"  }
  | FLOAT_DIV    { "( /. )"  }
  | MOD          { "( mod )" }
  | POWER        { "( ** )"  }
  | STR_EQUAL    { "( = )"   }
  | STR_UNEQUAL  { "( <> )"  }
  | LESS         { "( < )"   }
  | GREATER      { "( > )"   }
  | LESS_EQ      { "( <= )"  }
  | GREATER_EQ   { "( >= )"  }
  | NAT_EQUAL    { "( == )"  }
  | NAT_UNEQUAL  { "( != )"  }
  | OPERATOR_AND { "( && )"  }
  | OR           { "( || )"  }
  | SEMICOLON    { "( ; )"   }
  | ASSIGN       { "( := )"  }
;

clause:
  | base_pattern; GIVES; expr   { Ast.BasePattClause   { base_pattern = $1; expr = $3; loc = $loc} }
  | constr_pattern; GIVES; expr { Ast.ConstrPattClause { constr_pattern = $1; expr = $3; loc = $loc} }
;

base_pattern:
  | INT                          { Ast.BP_INT {num = $1; loc = $loc} }
  | PLUS INT                     { Ast.BP_INT {num = $2; loc = $loc} }
  | MINUS INT                    { Ast.BP_INT {num = -$2; loc = $loc} }
  | FLOAT                        { Ast.BP_FLOAT {num = $1; loc = $loc} }
  | FLOAT_PLUS FLOAT             { Ast.BP_FLOAT {num = $2; loc = $loc} }
  | FLOAT_MINUS FLOAT            { Ast.BP_FLOAT {num = -.$2; loc = $loc} }
  | CHAR                         { Ast.BP_CHAR {chr = $1; loc = $loc} }
  | TRUE                         { Ast.BP_BOOL {value = true; loc = $loc} }
  | FALSE                        { Ast.BP_BOOL {value = false; loc = $loc} }
  | ID                           { Ast.BP_ID {name_sym = Symbol.symbol($1); loc = $loc} }
  | LPAREN; base_pattern; RPAREN { $2 }
;

constr_pattern:
  | CID; base_pattern*             { Ast.CP_BASIC {constr_sym = Symbol.symbol($1); base_patterns = $2; loc = $loc} }
  | LPAREN; constr_pattern; RPAREN { $2 }
;
