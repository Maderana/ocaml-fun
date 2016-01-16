let rec length = function
  | [] -> 0
  | x :: xs -> 1 + length xs
;;

let rec rev = function
  | [] -> []
  | x :: xs -> rev xs @ [ x ] (* list concat *)
;;

let rec rev_aux accum = function 
  | [] -> accum
  | x :: xs -> rev_aux (x :: accum) xs
;;

let faster_rev l = rev_aux [] l;;

type queue = int list * int list;;
let q : queue = ([1; 2; 3], [4; 5; 6]);;

let is_empty ((a, b): queue) = 
  match (List.length a, List.length b) with
  | (0, 0) -> true
  | _ -> false
;;
    
let elements ((a, b): queue) : int list = 
  a @ List.rev b
;;

let enqueue (x: int) ((front, back): queue) : queue = 
  (front, x :: back)
;;

(* return first n items of l *)
let rec first_n l n accum = 
  if n = 0 then List.rev accum
  else first_n (List.tl l) (n - 1) (List.hd l :: accum)
;;

let split (xs: int list) : queue =
  let is_even = List.length xs mod 2 = 0 in
  let mid = List.length xs / 2 in
  let front = first_n xs (if is_even then mid else mid + 1) [] in
  let back = first_n (List.rev xs) mid [] in
  (front, back)
;;

let dequeue ((front, back): queue) : (int * queue) =
  match (front,back) with
  | ([], back) -> 
    let r = List.rev back in (List.hd r, ([], List.rev (List.tl r)))
  | (front, back) -> (List.hd front, (List.tl front, back))
;;

assert (dequeue ([], [4;3;2;1]) = (1, ([], [4;3;2])));;
assert (dequeue ([5;6;7;8], [4;3;2;1]) = (5, ([6;7;8], [4;3;2;1])));;

let rec mem x l =
 match l with 
   | [] -> false
   | y :: ys -> if x = y then true else mem x ys
;;

let rec append l1 l2 = 
  match l1 with 
  | [] -> l2
  | x :: xs -> x :: append xs l2
;;

let rec combine l1 l2 = 
  match (l1, l2) with
  | ([], []) -> []
  | (xs, []) -> [] (* these two patterns don't matter ... *)
  | ([], ys) -> [] (* ... since the lists are equal *)
  | (x :: xs, y :: ys) -> (x, y) :: combine xs ys
;;

let rec assoc (l : (string * int) list) (k: string) : int option = 
  match l with 
  | [] -> None
  | (a, b) :: xs -> if k = a then Some b else assoc xs k
;;

let result = assoc [("beta", 24); ("alpha", 43); ("gamma", 13)] "alpha";;
