{
    open Parser
    open Lexing

    let create_hashtable size init = 
        let tbl = Hashtbl.create size in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) init;
        tbl
    ;;

    let fun_table = create_hashtable 16 [
        ("sin", sin);
        ("cos", cos);
        ("tan", tan);
        ("asin", asin);
        ("acos", acos);
        ("atan", atan);
        ("log", log);
        ("exp", exp);
        ("sqrt", sqrt);
    ]
}

let ws = [' ' '\t' '\r']
let digit = ['0'-'9']
let ident = ['a'-'z' 'A'-'Z']
let ident_num = ['a'-'z' 'A'-'Z' '0'-'9']

rule token =
    parse 
    | ws                      { token lexbuf }
    | '\n'                    { NEWLINE }
    | digit+ | "." digit+ | digit+ "." digit* as num { 
        NUM (float_of_string num)
    }
    | '+'                      { PLUS }
    | '-'                      { MINUS }
    | '*'                      { MULTIPLY }
    | '('                      { LPAREN }
    | ')'                      { RPAREN }
    | '/'                      { DIVIDE }
    | '^'                      { CARET }
    | '('                      { LPAREN }
    | ')'                      { RPAREN }
    | '='                      { EQUALS }
    | ident ident_num* as word {
        try 
            let f = Hashtbl.find fun_table word in
            FUNCTION f
        with Not_found -> VAR word
    }
    | _ { token lexbuf }
    | eof { raise End_of_file }

