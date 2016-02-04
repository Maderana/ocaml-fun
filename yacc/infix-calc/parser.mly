%{

open Printf

(* called by the parser function on error *)
let parse_error s = 
    print_endline s;
    flush stdout
;;

%}


%token NEWLINE
%token <float> NUM
%token PLUS MINUS MULTIPLY DIVIDE CARET
%token LPAREN RPAREN

%left PLUS MINUS
%left MULTIPLY DIVIDE
%left NEG    /* negation */
%right CARET /* exponentiation */
%left LPAREN RPAREN

%start input
%type <unit> input

/* Grammar follows */

%%
input: 
    | /* empty */ { }
    | input line { }
;

line:
    | NEWLINE {}
    | exp NEWLINE { printf "\t = %.10g \n" $1; flush stdout }
;

exp:
    | NUM                 { $1 }
    | exp PLUS exp        { $1 +. $3 }
    | exp MINUS exp       { $1 -. $3 }
    | exp MULTIPLY exp    { $1 *. $3 }
    | exp DIVIDE exp      { $1 /. $3 }
    | MINUS exp %prec NEG { -. $2 }
    | exp CARET exp       { $1 ** $3 }
    | LPAREN exp RPAREN   { $2 }
;
