{
    open Parser (* assumes the parser file is "parser.mly" *)
    open Lexing
    let incr_lineno lexbuf = 
        let pos = lexbuf.lex_curr_p in
        lexbuf.lex_curr_p <- { pos with
            pos_lnum = pos.pos_lnum + 1;
            pos_bol = pos.pos_cnum;
        }
}

let ws = [' ' '\t' '\r']
let digit = ['0'-'9']
let digits = digit+
let letter = ['a'-'z']
let break = [';'][';']

rule token = 
    parse 
    | ws                       { token lexbuf }
    | '\n'                     { incr_lineno lexbuf; NEWLINE }
    | digit+ | '.' digit+
    | digit+ '.' digit* as num { NUM (float_of_string num) }
    | '+'                      { PLUS }
    | '-'                      { MINUS }
    | '*'                      { MULTIPLY }
    | '('                      { LPAREN }
    | ')'                      { RPAREN }
    | '/'                      { DIVIDE }
    | '^'                      { CARET }
    | _                        { token lexbuf}
    | eof                      { raise End_of_file }


