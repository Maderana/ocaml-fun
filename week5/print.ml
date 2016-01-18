let print_with_newline x =
  let _ = print_int x in 
  print_newline ()
;;

let rec print_int_list = function
  | [] -> print_newline ()
  | [x] -> print_int x
  | x :: xs -> 
    let _ = print_with_newline x in
    print_int_list xs
;;

print_int_list [1;2;3]

let rec print_list (print: 'a -> unit) l = function
  | [] -> print_newline () 
  | [x] -> print x
  | x :: xs -> 
    let _ = print x in
    let _ = print_endline "" in
    print_int_list xs
;;


let print_every_other k l =  
  let rec aux i = function
    | [] -> print_newline ()
    | x :: xs -> 
      match i mod k with 
      | 0 -> let _ = print_with_newline x in aux (i + 1) xs
      | _ -> aux (i + 1) xs 
  in
  aux 1 l
;;
 

print_every_other 2 [1; 2; 3; 4; 5; 6; 7; 8;];;
