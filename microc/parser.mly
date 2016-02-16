%{ open Ast %}

/* OCamlyacc Declarations */

/* token definitions */
%token LBRACE RBRACE COMMA SEMICOLON LPAREN RPAREN 
%token PLUS MINUS MULTIPLY DIVIDE NEQ EQ
%token GT LT GTE LTE ASSIGN
%token IF ELSE WHILE FOR RETURN INT
%token EOF

%token <int> LITERAL
%token <string> ID

%nonassoc NOELSE 
%nonassoc ELSE
%right ASSIGN 
%left EQ NEQ
%left GTE LTE LT GT
%left PLUS MINUS
%left MULTIPLY DIVIDE

/* entrypoint */
%start program
%type <Ast.program> program

%%

/* a program is a set of declarations
   followed by an EOF */
program:
    decls EOF { $1 }

/***************
  DECLARATIONS
****************/
decls:
    | /* nothing */ { [], [] }
    | decls vdecl { ($2 :: fst $1), snd $1 }
    | decls fdecl { fst $1, ($2 :: snd $1) }

/* a function declaration */
fdecl:
    ID LPAREN formal_opt RPAREN LBRACE vdecl_list stmt_list RBRACE
    {{fname = $1;           /* string */
      formals = $3;         /* list of strings */
      locals = List.rev $6; /* list of strings */
      body = List.rev $7}}  /* list of statements */

/* either a blank or list of formal list of args */
formal_opt:
    | /* nothing */ { [] }
    | formal_list { List.rev $1 }

/* either a single ID or a list of comma separated IDs */
formal_list:
    | ID { [$1] }
    | formal_list COMMA ID { $3 :: $1 }

/* either a blank or list of var declarations */
vdecl_list:
    | /* nothing */ { [] }
    | vdecl_list vdecl { $2 :: $1 }

/* a variable declaration is like: int a; */
vdecl:
    INT ID SEMICOLON { $2 }

/************
  STATEMENTS 
*************/

stmt_list:
    | /* nothing */ { [] }
    | stmt_list stmt { $2 :: $1 }

stmt:
    | expr SEMICOLON { Expr($1) }
    | RETURN expr SEMICOLON { Return($2) }
    | LBRACE stmt_list RBRACE { Block(List.rev $2) }
    | IF LPAREN expr RPAREN stmt %prec NOELSE { If($3, $5, Block([])) }
    | IF LPAREN expr RPAREN stmt ELSE stmt { If($3, $5, $7) }
    | FOR LPAREN expr_opt SEMICOLON expr_opt SEMICOLON expr_opt RPAREN stmt 
        { For($3, $5, $7, $9) }
    | WHILE LPAREN expr RPAREN stmt { While($3, $5) }

expr_opt:
    | /* nothing */ { Noexpr }
    | expr { $1 }


/**************
  EXPRESSIONS 
**************/
expr:
    | LITERAL          { Literal($1) }
    | ID               { Id($1) }
    | expr PLUS   expr { Binop($1, Add,   $3) }
    | expr MINUS  expr { Binop($1, Sub,   $3) }
    | expr MULTIPLY  expr { Binop($1, Mult,  $3) }
    | expr DIVIDE expr { Binop($1, Div,   $3) }
    | expr EQ     expr { Binop($1, Equal, $3) }
    | expr NEQ    expr { Binop($1, Neq,   $3) }
    | expr LT     expr { Binop($1, Less,  $3) }
    | expr LTE    expr { Binop($1, Leq,   $3) }
    | expr GT     expr { Binop($1, Greater,  $3) }
    | expr GTE    expr { Binop($1, Geq,   $3) }
    | ID ASSIGN expr   { Assign($1, $3) }
    | ID LPAREN actuals_opt RPAREN { Call($1, $3) }
    | LPAREN expr RPAREN { $2 }

actuals_opt:
    | /* nothing */ { [] }
    | actuals_list  { List.rev $1 }

actuals_list:
    | expr  { [$1] }
    | actuals_list COMMA expr  { $3 :: $1 }
