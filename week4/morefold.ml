let iseven x = x mod 2 = 0;;
let isodd x = not (iseven x);;

let for_all p l =
  List.fold_left (fun state x -> (p x) && state) true l
;;

let exists p l = 
  List.fold_left (fun state x -> (p x) || state) false l
;;

assert (for_all iseven [2;4;6;8;10]);;
assert (not (for_all iseven [2;5;6;8;10]));;
assert (for_all isodd [1;5;3;9;11]);;

assert (exists iseven [1;3;5;7;10]);;
assert (exists isodd [2;5;6;8;10]);;
assert (not (exists iseven [1;5;3;9;11]));;

let sorted (cmp: 'a -> 'a -> int) (l: 'a list) : bool =
  let res = List.fold_left 
    (fun acc x ->
       match acc with
       | None -> None
       | Some t -> if ((cmp t x) < 1) then (Some x) else None) 
    (Some (List.hd l)) l
  in
  match res with 
  | None -> false
  | Some _ -> true
;;

assert (not (sorted compare [1;2;1;4;5]));;
assert (sorted compare [1;2;3;4;5]);;
assert (sorted compare [1;1;1;1;1]);;
