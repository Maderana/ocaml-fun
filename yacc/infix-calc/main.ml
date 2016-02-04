let main ()  =
  try 
    let lexbuf = Lexing.from_channel stdin in
    while true do
      let _ = Parser.input Lexer.token lexbuf in
      flush stdout;
    done
  with End_of_file -> exit 0
;;

let _ = main ();;


