let rec multi = function 
  | [] -> 1
  | x :: xs -> if x = 0 then 0 else x * multi xs
;;

exception Zero;;

(* this is faster since the call stack is thrown 
   away with exceptions *)
let multiexc l = 
  let rec aux = function
    | [] -> 1
    | x :: xs -> if x = 0 then raise Zero else x * (aux xs)
  in 
  try aux l with
  | Zero -> 0
;;

