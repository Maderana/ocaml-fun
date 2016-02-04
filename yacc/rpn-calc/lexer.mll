{
    open Rpcalc (* assumes the parser file is "rpcalc.mly" *)
}

let ws = [' ' '\t' '\r']
let digit = ['0'-'9']
let digits = digit+
let letter = ['a'-'z']
let break = [';'][';']

rule token = 
    parse 
    | ws { token lexbuf }
    | '\n' { NEWLINE }
    | digit+
    | '.' digit+ 
    | digit+ '.' digit* as num { NUM (float_of_string num) }
    | '+' { PLUS }
    | '-' { MINUS }
    | '*' { MULT }
    | '/' { DIV }
    | '^' { CARET }
    | 'n' { UMINUS }
    | _ { token lexbuf} 
    | eof { raise End_of_file }


