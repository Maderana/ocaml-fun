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

type index = Index of int;;

let read (arr : int array) (i: index) : int =
  match i with
    Index x -> arr.(x)
;;

let inside (arr: int array) (i: index) : bool =
  match i with 
    Index x -> x < (Array.length arr) && x >= 0
;;

let next i =
  match i with
    Index x -> Index (x + 1)
;;

let get_minindex (arr : int array) : int = 
  let (i, _) = 
    Array.fold_left 
    (fun (i1,x1) (i2,x2) -> if x1 < x2 then (i1,x1) else (i2, x2)) 
    (-1, max_int)
    (Array.mapi (fun i x -> (i, x)) arr) in
  i
;;

let min_index (arr: int array) : index =
  Index (get_minindex arr)
;;

