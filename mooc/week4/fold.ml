let rec fold_right f l b = match l with 
  | [] -> b
  | h :: r -> f h (fold_right f r b)
;;

let rec fold_left f b l  = match l with 
  | [] -> b
  | h :: r -> fold_left f (f h b) r
;;

let same = fold_right (fun x y -> x :: y) [1;2;3;4] [];;
let reverse = fold_left (fun x y -> x :: y) [] [1;2;3;4];;

let rec filter p = function 
  | [] -> []
  | x :: xs when p x -> x :: (filter p xs)
  | _ :: xs -> filter p xs
;;

let iseven x = x mod 2 = 0;;

let range n = 
  let rec aux i l = 
    if i = n then l else i :: (aux (i + 1) l)
  in
  aux 0 []
;;

let first10 = range 10;;

filter iseven first10;;

let partition p l =
  List.fold_right
    (fun x (lpos, lneg) ->
       if p x
       then ((x :: lpos), lneg)
       else (lpos, (x :: lneg)))
    l ([], [])
;;

partition iseven first10;;

let rec quicksort = function
  | [] -> []
  | x :: xs ->
    let l = quicksort (filter (fun y -> y < x) xs) in
    let g = quicksort (filter (fun y -> y > x) xs) in
    l @ (x :: g)
;;

assert (quicksort [5;3;2;10] = [2;3;5;10])
