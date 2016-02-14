type token =
  | Num of (int)
  | Id of (string)
  | TRUE
  | FALSE
  | LEFTPAREN
  | RIGHTPAREN
  | EOF
  | AND
  | OR
  | NEG

val expr :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.expr
