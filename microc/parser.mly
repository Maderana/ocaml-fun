%{
    open Ast
%}

/* OCamlyacc Declarations */

/* token definitions */
%token LBRACE RBRACE COMMA SEMICOLON LPAREN RPAREN PLUS MINUS MULTIPLY DIVIDE
%token GT LT GTE LTE ASSIGN EQUALS 
%token IF ELSE WHILE FOR RETURN 

/* entrypoint */
%start program
%type <Ast.program> program

%%

