let print_with_newline x =
  begin print_int x; print_newline (); end
;;

let rec print_int_list = function
  | [] -> print_newline ()
  | [x] -> print_int x
  | x :: xs -> begin print_with_newline x; print_int_list xs; end
;;

print_int_list [1;2;3]

let rec print_list (print: 'a -> unit) l = function
  | [] -> print_newline () 
  | [x] -> print x
  | x :: xs -> begin print x; print_endline ""; print_int_list xs; end
;;


let print_every_other k l =  
  let rec aux i = function
    | [] -> print_newline ()
    | x :: xs -> 
      match i mod k with 
      | 0 -> begin print_with_newline x; aux (i + 1) xs end
      | _ -> aux (i + 1) xs 
  in
  aux 1 l
;;
 

print_every_other 2 [1; 2; 3; 4; 5; 6; 7; 8;];;
