{
    open Parser (* assumes the parser file is "parser.mly" *)
}

let ws = [' ' '\t' '\r']
let digit = ['0'-'9']
let digits = digit+
let letter = ['a'-'z']
let break = [';'][';']

rule token = 
    parse 
    | ws                       { token lexbuf }
    | '\n'                     { NEWLINE }
    | digit+ | '.' digit+
    | digit+ '.' digit* as num { NUM (float_of_string num) }
    | '+'                      { PLUS }
    | '-'                      { MINUS }
    | '*'                      { MULTIPLY }
    | '/'                      { DIVIDE }
    | '^'                      { CARET }
    | _                        { token lexbuf}
    | eof                      { raise End_of_file }


