type token =
  | LBRACE
  | RBRACE
  | COMMA
  | SEMICOLON
  | LPAREN
  | RPAREN
  | PLUS
  | MINUS
  | MULTIPLY
  | DIVIDE
  | NEQ
  | EQ
  | GT
  | LT
  | GTE
  | LTE
  | ASSIGN
  | IF
  | ELSE
  | WHILE
  | FOR
  | RETURN
  | INT
  | EOF
  | LITERAL of (int)
  | ID of (string)

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
