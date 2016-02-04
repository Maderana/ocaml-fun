/* A Reverse polish notation calculator */

%{ 
open Printf

(* called by the parser function on error *)
let parse_error s = 
    print_endline s;
    flush stdout
;;

 %}

/* terminal and non terminal declarations */

%token <float> NUM
%token PLUS MINUS MULT DIV CARET UMINUS
%token NEWLINE

%start input
%type <unit> input

%%

input: 
    | /* empty */ { }
    | input line { }
;

line:
    | NEWLINE {}
    | exp NEWLINE { printf "\t%.10g\n" $1; flush stdout }
;

exp: 
    | NUM { $1 }
    | exp exp PLUS { $1 +. $2 }
    | exp exp MINUS { $1 -. $2 }
    | exp exp MULT { $1 *. $2 }
    | exp exp DIV { $1 /. $2 }
    /* exponentation */
    | exp exp CARET { $1 ** $2 }
    /* Unary minus */
    | exp UMINUS { -. $1 }
;

