{ open Parser }

let ws = [' ' '\t' '\r' '\n']
let digit = ['0'-'9']
let digits = digit+
let letter = ['a'-'z']
let break = [';'][';']

rule token = 
    parse 
    | ws            { token lexbuf }
    | '+'           { PLUS }
    | '-'           { MINUS }
    | '*'           { TIMES }
    | '/'           { DIVIDE }
    | '='           { EQUALS }
    | '^'           { POWER }
    | break         { EOF}
    | ','           { SEP }
    | digits as lit { LITERAL(int_of_string lit) }
    | letter as lit { VARIABLE(int_of_char lit - 97) }
    | eof           { EOF }
