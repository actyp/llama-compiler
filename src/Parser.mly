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
%type <Ast.program> program
%type <Ast.def list> def_list
%type <Ast.def> letdef
%type <Ast.dec> def
%type <Ast.param> par
%type <Ast.def> typedef
%type <Ast.tdec> tdef
%type <Ast.constr> constr
%type <Ast._type> _type
%type <Ast.base_expr> base_expr
%type <Ast.expr> expr
%type <Ast.count_dir> count
%type <Ast.unop> unop
%type <Ast.binop> binop
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
  LET; option(REC { $startofs($1) }); def; list(AND def { $2 }) { Ast.LetDef {recur_opt = $2; decs = $3 :: $4; pos = $startofs($1)} }
;

def:
  | ID; option(COLON _type { $2 }); STR_EQUAL; expr       { Ast.ConstVarDec {name = Symbol.symbol($1); ty_opt = $2; value = $4; pos = $startofs($1)} }
  | ID; par+; option(COLON _type { $2 }); STR_EQUAL; expr { Ast.FunctionDec {name = Symbol.symbol($1); params = $2; result_ty_opt = $3; body = $5; pos = $startofs($1)} }
  | MUTABLE; ID; option(COLON _type { $2 })               { Ast.MutVarDec   {name = Symbol.symbol($2); ty_opt = $3; pos = $startofs($2)} }
  | MUTABLE; ID; LBRACKET; expr; list(COMMA expr { $2 }); RBRACKET; option(COLON _type { $2 })
                                                          { Ast.ArrayDec {name = Symbol.symbol($2); dims = $4 :: $5; ty_opt = $7; pos = $startofs($2) } }
;

par:
  | ID                            { Ast.Param({name = Symbol.symbol($1); ty_opt = None;    pos = $startofs($1)}) }
  | LPAREN ID COLON _type RPAREN  { Ast.Param({name = Symbol.symbol($2); ty_opt = Some $4; pos = $startofs($2)}) }
;

typedef:
  TYPE; tdef; list(AND tdef { $2 }) { Ast.TypeDef {tdecs = $2 :: $3; pos = $startofs($1)} }
;

tdef:
  ID; STR_EQUAL; constr; list(BAR constr { $2 }) { Ast.TypeDec {name = Symbol.symbol($1); constrs = $3 :: $4; pos = $startofs($1)} }
;

constr:
  CID; option(OF; _type+ { $2 }) { Ast.Constr {name = Symbol.symbol($1); tys_opt = $2; pos = $startofs($1)} }
;

_type:
  | UNIT                   { Ast.TY_BASIC({ty = Symbol.symbol("UNIT");  pos = $startofs($1)}) }
  | TYPE_INT               { Ast.TY_BASIC({ty = Symbol.symbol("INT");   pos = $startofs($1)}) }
  | TYPE_CHAR              { Ast.TY_BASIC({ty = Symbol.symbol("CHAR");  pos = $startofs($1)}) }
  | BOOL                   { Ast.TY_BASIC({ty = Symbol.symbol("BOOL");  pos = $startofs($1)}) }
  | TYPE_FLOAT             { Ast.TY_BASIC({ty = Symbol.symbol("FLOAT"); pos = $startofs($1)}) }
  | LPAREN _type RPAREN    { $2 }
  | _type GIVES _type      { Ast.TY_FUNC({param_tys = [$1; $3]; pos = $startofs($1)}) }
  | _type REF              { Ast.TY_REF({ty = $1; pos = $startofs($1)}) }
  | ARRAY; option(LBRACKET; TIMES; list(COMMA TIMES { () }); RBRACKET { 1 + List.length $3 }); OF; _type
                           { Ast.TY_ARRAY({dims_num_opt = $2; ty = $4; pos = $startofs($4)}) }
  | ID                     { Ast.TY_ID({ty = Symbol.symbol($1); pos = $startofs($1)}) }
;

base_expr:
  | ID                                                    { Ast.BE_ID       {name = Symbol.symbol($1); pos = $startofs($1)} }
  | CID                                                   { Ast.BE_CID      {name = Symbol.symbol($1); pos = $startofs($1)} }
  | INT                                                   { Ast.BE_Int      {value = $1; pos = $startofs($1)} }
  | FLOAT                                                 { Ast.BE_Float    {value = $1; pos = $startofs($1)} }
  | CHAR                                                  { Ast.BE_Char     {value = $1; pos = $startofs($1)} }
  | STRING                                                { Ast.BE_String   {value = $1; pos = $startofs($1)} }
  | TRUE                                                  { Ast.BE_True     $startofs($1) }
  | FALSE                                                 { Ast.BE_False    $startofs($1) }
  | EXCLAMATION_MARK; base_expr                           { Ast.BE_Deref    {base_expr = $2; pos = $startofs($1)} }
  | LPAREN RPAREN                                         { Ast.BE_Empty    $startofs($1) }
  | ID; LBRACKET; expr; list(COMMA expr { $2 }); RBRACKET { Ast.BE_ArrayRef {exprs = $3 :: $4; pos = $startofs($1)} }
  | LPAREN; expr; RPAREN                                  { Ast.BE_Nested   {expr = $2; pos = $startofs($1)} }
;

expr:
  | unop expr %prec UN                                       { Ast.E_Unop         {unop = $1; expr = $2; pos = $startofs($1)} }
  | expr binop expr                                          { Ast.E_Binop        {left_expr = $1; binop = $2; right_expr = $3; pos = $startofs($1)} }
  | ID; base_expr+                                           { Ast.E_ID_BES       {id = Symbol.symbol($1); base_exprs = $2; pos = $startofs($1)} }
  | CID; base_expr+                                          { Ast.E_CID_BES      {cid = Symbol.symbol($1); base_exprs = $2; pos = $startofs($1)} }
  | DIM; INT?; ID                                            { Ast.E_ArrayDim     {dim = $2; array_name = Symbol.symbol($3); pos = $startofs($1)} }
  | NEW; _type                                               { Ast.E_New          {ty = $2; pos = $startofs($1)} }
  | DELETE; expr                                             { Ast.E_Delete       {expr = $2; pos = $startofs($1)} }
  | letdef; IN; expr                                         { Ast.E_LetIn        {letdef = $1; in_expr = $3; pos = $startofs($2)} }
  | BEGIN; expr; END                                         { Ast.E_BeginEnd     {expr = $2; pos = $startofs($1)} }
  | IF; expr; THEN; expr; ELSE; expr                         { Ast.E_MatchedIF    {if_expr = $2; then_expr = $4; else_expr = $6; pos = $startofs($1)} }
  | IF; expr; THEN; expr %prec UIF                           { Ast.E_UnmatchedIF  {if_expr = $2; then_expr = $4; pos = $startofs($1)} }
  | WHILE; expr; DO; expr; DONE                              { Ast.E_WhileDoDone  {while_expr = $2; do_expr = $4; pos = $startofs($1)} }
  | FOR; ID; STR_EQUAL; expr; count; expr; DO; expr; DONE    { Ast.E_ForDoDone    {count_var = Symbol.symbol($2); start_expr = $4; count_dir = $5; end_expr = $6; do_expr = $8; pos = $startofs($1)} }
  | MATCH; expr; WITH; clause; list(BAR; clause { $2 }); END { Ast.E_MatchWithEnd {match_expr = $2; with_clauses = $4 :: $5; pos = $startofs($1)} }
  | base_expr                                                { Ast.E_BaseExpr     {base_expr = $1; pos = $startofs($1)} }
;

count:
  | TO     { Ast.TO     $startofs($1) }
  | DOWNTO { Ast.DOWNTO $startofs($1) }
;

%inline unop:
  | PLUS             { Ast.UN_PLUS }
  | MINUS            { Ast.UN_MINUS }
  | FLOAT_PLUS       { Ast.UN_FLOAT_PLUS }
  | FLOAT_MINUS      { Ast.UN_FLOAT_MINUS }
  | EXCLAMATION_MARK { Ast.UN_DEREF }
  | NOT              { Ast.UN_NOT }
;

%inline binop:
  | PLUS         { Ast.BI_PLUS }
  | MINUS        { Ast.BI_MINUS }
  | TIMES        { Ast.BI_TIMES }
  | DIV          { Ast.BI_DIV }
  | FLOAT_PLUS   { Ast.BI_FLOAT_PLUS }
  | FLOAT_MINUS  { Ast.BI_FLOAT_MINUS }
  | FLOAT_TIMES  { Ast.BI_FLOAT_TIMES }
  | FLOAT_DIV    { Ast.BI_FLOAT_DIV }
  | MOD          { Ast.BI_MOD }
  | POWER        { Ast.BI_POWER }
  | STR_EQUAL    { Ast.BI_STR_EQUAL }
  | STR_UNEQUAL  { Ast.BI_STR_UNEQUAL }
  | LESS         { Ast.BI_LESS }
  | GREATER      { Ast.BI_GREATER }
  | LESS_EQ      { Ast.BI_LESS_EQ }
  | GREATER_EQ   { Ast.BI_GREATER_EQ }
  | NAT_EQUAL    { Ast.BI_NAT_EQUAL }
  | NAT_UNEQUAL  { Ast.BI_NAT_UNEQUAL }
  | OPERATOR_AND { Ast.BI_OPERATOR_AND }
  | OR           { Ast.BI_OR }
  | SEMICOLON    { Ast.BI_SEMICOLON }
  | ASSIGN       { Ast.BI_ASSIGN }
;

clause:
  | base_pattern; GIVES; expr   { Ast.BasePattClause   { base_pattern = $1; expr = $3; pos = $startofs($1)} }
  | constr_pattern; GIVES; expr { Ast.ConstrPattClause { constr_pattern = $1; expr = $3; pos = $startofs($1)} }
;

base_pattern:
  | INT                          { Ast.BP_INT {num = $1; pos = $startofs($1)} }
  | PLUS INT                     { Ast.BP_PLUS_INT {num = $2; pos = $startofs($1)} }
  | MINUS INT                    { Ast.BP_MINUS_INT {num = $2; pos = $startofs($1)} }
  | FLOAT                        { Ast.BP_FLOAT {num = $1; pos = $startofs($1)} }
  | FLOAT_PLUS FLOAT             { Ast.BP_PLUS_FLOAT {num = $2; pos = $startofs($1)} }
  | FLOAT_MINUS FLOAT            { Ast.BP_MINUS_FLOAT {num = $2; pos = $startofs($1)} }
  | CHAR                         { Ast.BP_CHAR {chr = $1; pos = $startofs($1)} }
  | TRUE                         { Ast.BP_TRUE $startofs($1) }
  | FALSE                        { Ast.BP_FALSE $startofs($1) }
  | ID                           { Ast.BP_ID {id = Symbol.symbol($1); pos = $startofs($1)} }
  | CID                          { Ast.BP_CID {cid = Symbol.symbol($1); pos = $startofs($1)} }
  | LPAREN; base_pattern; RPAREN { Ast.BP_NESTED {base_pattern = $2; pos = $startofs($1)} }
;

constr_pattern:
  | CID; base_pattern+             { Ast.CP_BASIC  {constr_sym = Symbol.symbol($1); base_patterns = $2; pos = $startofs($1)} }
  | LPAREN; constr_pattern; RPAREN { Ast.CP_NESTED {constr_pattern = $2; pos = $startofs($1)} }
;
