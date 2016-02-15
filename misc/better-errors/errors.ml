(* File "errors.ml", line 3, characters 30-33:
   Error: Unbound value ish *)


let print_error_line line_no char_no fname = 
  let in_channel = open_in fname in
  let msg = Printf.sprintf "File: '%s', line %d, character %d:" fname line_no char_no in
  let print_caret line char_at = 
    let s = (String.make (char_at-1) ' ') ^ "^" in
    print_endline msg;
    print_endline line;
    print_endline s;
  in
  let rec aux c =
    let line = input_line in_channel in 
    if c != line_no then ()
    else print_caret line char_no;
    aux (c + 1)
  in
  try aux 1
  with End_of_file -> close_in in_channel
;;

print_error_line 5 3 Sys.argv.(1);;
