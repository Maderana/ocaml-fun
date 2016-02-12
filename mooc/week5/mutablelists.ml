type 'a xlist = 
  { mutable pointer: 'a cell }
and 'a cell = 
  | Nil
  | List of 'a * 'a xlist
;;

exception Empty_xlist;;

(* returns a new empty list *)
let nil () = { pointer = Nil };;

let cons x rest = 
  { pointer = List (x, rest) } ;;

let single_list = { pointer = List (1, nil ()) };;
let long_list = 
  { pointer = 
      List (1, { pointer = 
                   List (2, { pointer = 
                                List (3, nil ()) })}) }
 ;;

let head l = 
  match l.pointer with 
  | Nil -> raise Empty_xlist
  | List (x, _) -> x
;;

let tail l = 
  match l.pointer with
  | Nil -> raise Empty_xlist
  | List (_, xs) -> xs
;;

try head (nil ()) with 
| Empty_xlist -> "yup.. got an exception"
;;

head single_list;;
tail long_list;;


let add x l = l.pointer <- List (x, {pointer = l.pointer});;

let chop l = 
  match l.pointer with
  | Nil -> raise Empty_xlist
  | List (_, xs) -> l.pointer <- xs.pointer;
;;

let rec filter p l = 
  match l.pointer with 
  | Nil -> ()
  | List (x, xs) -> 
    if p x 
    then filter p xs
    else l.pointer <- xs.pointer; filter p xs;
;;

let isodd x = x mod 2 = 1;;

