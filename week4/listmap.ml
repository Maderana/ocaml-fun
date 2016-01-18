let rec sublists = function
  | [] -> [[]]
  | h :: r ->
    let rp = sublists r in 
    rp @ (List.map (fun l -> h :: l) rp)
;;

let wrap l = List.map (fun x -> [x]) l;;

type 'a tree = 
  | Node of 'a tree * 'a * 'a tree
  | Leaf of 'a
;;

let rec tree_map f = function 
  | Leaf x -> Leaf (f x)
  | Node (l, x, r) -> Node ((tree_map f l), (f x), (tree_map f r))
;;

let mytree : int tree = Node ((Leaf 10), 20, (Leaf 25));;

let stree = tree_map string_of_int mytree;;

assert (stree = Node ((Leaf "10"), "20", (Leaf "25")));;


