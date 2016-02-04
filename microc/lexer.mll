(* a Lexer for the microC language *)
{ 
    (* assumes the parser is parser.mly file *)
    open Parser 
}

let ws = [' ' '\t' '\r' '\n']
let digit = ['0'-'9']
let ident = ['a'-'z']
let ident_num = ['a'-'z' 'A'-'Z' '0'-'9' '_']

rule token = parse 
    | ws                            { token lexbuf }
    | "/*"                          { comment lexbuf }
    | '{'                           { LBRACE }
    | '}'                           { RBRACE }
    | '('                           { RPAREN }
    | ')'                           { LPAREN }
    | ';'                           { SEMICOLON }
    | ','                           { COMMA }
    | '>'                           { GT }
    | '<'                           { LT }
    | "<="                          { LTE }
    | ">="                          { GTE }
    | '='                           { ASSIGN }
    | "=="                          { EQUALS }
    | "!="                          { NOTEQUALS }
    | '-'                           { MINUS }
    | '+'                           { PLUS }
    | '*'                           { MULTIPLY }
    | '/'                           { DIVIDE }
    | "if"                          { IF }
    | "else"                        { ELSE }
    | "for"                         { FOR }
    | "int"                         { INT }
    | "while"                       { WHILE }
    | "return"                      { RETURN }
    | digit+ as num                 { LITERAL(int_of_string num) }
    | ident ident_num* '?'? as word { ID(word) }
    | eof                           { EOF }
    | _ as char                     { raise (Failure("illegal character: " ^ Char.escaped char )) }

and comment = parse
    | "*/"                          { token lexbuf }
    | _                             { comment lexbuf }
