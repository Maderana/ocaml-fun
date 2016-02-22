{ open Printf }

let digit = ['0'-'9']
let exp = ['e' 'E'] ['+' '-']?
let digits = digit*

rule token = parse
    | digits '.' digits
    | digits '.'? digits exp digit+
    as num { printf "Value: %f\n" (float_of_string num);
                      token lexbuf }
    | [' ' '\t' '\n'] { token lexbuf; }
    | _  as c { printf "Unrecognized character: %c\n" c;
                token lexbuf }
    | eof { }


{
    let testcases = ["1."; "0.5e-2";".3e+3";".2"; "1e4"; "3.4E-2";
                    "4"; "54" ] in

    let main s = 
        Printf.printf "Original: %s, " s;
        let lexbuf = Lexing.from_string s in token lexbuf
    in
    List.iter (fun s -> main s) testcases;;

}
