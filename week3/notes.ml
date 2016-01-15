type color = Black | Gray | White;;

let lighter (c1: color) (c2: color) = 
  match (c1, c2) with
  | (Black, Black) -> false
  | (White, White) -> false
  | (Gray, Gray)   -> false
  | (Black, _) -> true
  | (_, White) -> true
  | (White, Gray) -> false
  | (Gray, Black) -> false
  | (White, Black) -> true
;;

let find (arr: string array) (s: string) : int option =
  let rec loop i = 
    if i >= Array.length arr
    then None
    else if arr.(i) = s
    then Some i
    else loop (i + 1) in
  loop 0
;;

let default_int (o : int option) : int = 
  match o with 
  | None -> 0
  | Some x -> x
;;

let merge (op1: int option) (op2: int option) : int option = 
  match (op1, op2) with
  | (None, None) -> None
  | (Some x, None) -> Some x
  | (None, Some y) -> Some y
  | (Some x, Some y) -> Some (x + y)
;;
