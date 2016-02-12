type 'a bt =
  | Empty
  | Node of 'a bt * 'a * 'a bt
;;

let rec height = function
  | Empty -> 0
  | Node (l, _, r) -> 1 + max (height l) (height r)
;;

let rec balanced = function 
  | Empty -> true
  | Node (l, _, r) -> 
    if height l != height r
    then false
    else balanced l && balanced r
;;

let example1 = Node (
    Node (Empty, 2, Empty),
    4,
    Node (Empty,
          5, 
          Node (Empty, 10, Empty))
  )
;;

let example2 = Node (
    Node (Empty, 2, Empty),
    4,
    Node (Empty, 10, Empty)
  )
;;

assert (height example1 = 3);;
assert (balanced example2);;

