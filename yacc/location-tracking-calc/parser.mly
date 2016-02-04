%{
open Printf
open Lexing
%}


/* OCamlyacc declarations */
%token NEWLINE
%token LPAREN RPAREN
%token <float> NUM
%token PLUS MINUS MULTIPLY DIVIDE CARET

/* precedence operators */
%left PLUS MINUS
%left MULTIPLY DIVIDE
%left NEG    /* negation */
%right CARET /* exponentiation */

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
    | exp DIVIDE exp      { if $3 <> 0.0 then $1 /. $3 
    else (
        let start_pos = Parsing.rhs_start_pos 3 in
        let end_pos = Parsing.rhs_end_pos 3 in
        printf "%d.%d-%d.%d: division by zero" 
            start_pos.pos_lnum (start_pos.pos_cnum - start_pos.pos_bol)
            end_pos.pos_lnum (end_pos.pos_cnum - end_pos.pos_bol);
        1.0
    )
    }
    | MINUS exp %prec NEG { -. $2 }
    | exp CARET exp       { $1 ** $3 }
    | LPAREN exp RPAREN   { $2 }
;

%%
