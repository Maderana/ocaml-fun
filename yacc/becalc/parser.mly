%{ open Ast %}

%token <int> Num
%token <string> Id
%token TRUE, FALSE
%token LEFTPAREN, RIGHTPAREN
%token EOF
%token AND, OR, NEG

%left OR
%left AND
%nonassoc NEG

%type <Ast.expr> expr 

%start expr 

%%
expr: Id                        { Var($1) }
    | TRUE                      { Const true }
    | FALSE                     { Const false }
    | expr AND expr             { And($1, $3) }
    | expr OR expr              { Or($1,$3) }
    | NEG expr                  { Neg($2) }
    | LEFTPAREN expr RIGHTPAREN { $2 }
