let rec push_max_at_the_end = function
  | ([] | [_]) as l -> l
  | x :: ((y :: _) as l) when x <= y -> x :: push_max_at_the_end l
  | x :: y :: ys -> y :: push_max_at_the_end (x :: ys)
;;

type e = EInt of int | EMul of e * e | EAdd of e * e;;

let simplify = function
  | EMul (EInt 1, e) | EMul (e, EInt 1) | EAdd (e, EInt 0) | EAdd (EInt 0, e) -> e
  | EMul (EInt 0, e) | EMul (e, EInt 0) -> EInt 0
  | e -> e
;;

let only_small_lists = function 
  | ([] | [_] | [_;_]) as l -> l
  | _ -> []
;;

let rec no_consecutive_repetition = function
  | ([] | [_]) as l -> l
  | x :: y :: ys when x = y -> no_consecutive_repetition (y :: ys)
  | x :: y :: ys -> x :: (no_consecutive_repetition (y :: ys))
;;

assert (no_consecutive_repetition [3;4;4;5;5;6;1] = [3;4;5;6;1]);;
