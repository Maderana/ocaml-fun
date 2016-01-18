type 'a bt = 
  | Empty
  | Node of 'a bt * 'a * 'a bt
;;

exception Unbalanced of int ;;

let rec height = function 
  | Empty -> 0
  | Node (t, _, t') -> 1 + (max (height t) (height t'))
;;

let heightcount tree : (int * int) = 
  let rec aux c = function
    | Empty -> (0, c + 1)
    | Node (t, _, t') ->
      let (h1, c1) = aux c t in
      let (h2, c2) = aux c t' in
      (1 + max h1 h2, c1 + c2)
  in
  aux 0 tree
;;

let rec balanced = function
  | Empty -> true
  | Node (t, _, t') -> 
    (balanced t) && (balanced t') && height t = height t'
;;

let balancedcount : (bool * int) = 
  let rec aux c = function
    | Empty -> (true, c + 1)
    | Node (t, _, t') -> (true, 10)
  in
  (true, 10)
;;


let example = 
  Node (
    (Node (
        (Node (Empty, 4, Empty)), 
        3, 
        (Node (Empty, 21, Empty))
      )), 
    5, 
    (Node (
        (Node (Empty, 14, Empty)), 
        10, 
        (Node (Empty, 9, Empty))
      ))
  )
;;

height example;;
balanced example;;

heightcount example;;
heightcount (Empty);; (* validating for single node *)
