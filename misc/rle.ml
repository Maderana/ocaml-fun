type 'a rle = 
  | One of 'a
  | Many of 'a * int
;;

(* computes the run-length encoding of a list *)
let rle l = 
  let rec aux rlelist curr = function
    | [] -> curr :: rlelist 
    | x :: [] ->
      (match curr with 
      | One v -> 
        if x = v then (Many (x, 2)) :: rlelist 
        else (One x) :: curr :: rlelist
      | Many (v, c) -> 
        if x = v then (Many (v, c+1)) :: rlelist 
        else (One x) :: curr :: rlelist)
    | x :: y :: xs -> 
      match curr with
      | One v ->
        if x = v then aux rlelist (Many (x, 2)) (y :: xs) 
        else aux (One x :: curr :: rlelist) (One y) xs
      | Many (v, c) ->
        if x = v then aux rlelist (Many (v, c+1)) (y :: xs) 
        else aux (curr :: rlelist) (One x) (y :: xs)
  in 
  if l = [] then []
  else List.rev (aux [] (One (List.hd l)) (List.tl l))
;;

let compute_rle l = 
  let results = List.fold_left 
    (fun acc x -> 
       if acc = [] then [One x]
       else 
         match List.hd acc with
         | One v -> 
           if v = x 
           then (Many (x, 2)) :: List.tl acc
           else (One x) :: List.hd acc :: List.tl acc
         | Many (v, c) ->
           if v = x
           then (Many (x, c+1)) :: List.tl acc
           else (One x) :: List.hd acc :: List.tl acc) 
    [] 
    l
  in 
  List.rev results
;;

let example = [1; 1; 1; 3; 4; 1; 1];;
assert ([Many (1, 3); One 3; One 4; Many (1, 2)] = (rle example));;
assert ([Many (1, 3); One 3; One 4; Many (1, 2)] = (compute_rle example));;
