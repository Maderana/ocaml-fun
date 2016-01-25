type token =
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | EOF
  | EQUALS
  | SEP
  | POWER
  | LITERAL of (int)
  | VARIABLE of (int)

val expr :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.expr
