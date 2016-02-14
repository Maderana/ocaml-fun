{ open Parser }

rule token = parse
  | [' ' '\t' '\n']    { token lexbuf } (* skip spaces *)
  | "("                { LEFTPAREN}
  | ")"                { RIGHTPAREN}
  | "&&"               { AND }
  | "||"               { OR }
  | "-"                { NEG }
  | "true"             { TRUE }
  | "false"            { FALSE }
  | ['0'-'9']+ as num  { Num(int_of_string num) }
  | ['A'-'Z' 'a'-'z' '_']['A'-'Z' 'a'-'z' '0'-'9' '_']* as str { Id(str) }
  | _ as chr           { failwith ("lex error: "^(Char.escaped chr))}
  | eof                { EOF }
