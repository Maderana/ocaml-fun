type token =
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | EOF
  | EQUALS
  | SEP
  | LITERAL of (int)
  | VARIABLE of (int)

val expr :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.expr
