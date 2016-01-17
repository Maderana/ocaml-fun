let rec last_element = function
  | [] -> (invalid_arg "last_element")
  | [x] -> x
  | x :: xs when xs = [] -> x
  | _ :: xs -> last_element xs
;;

let rec is_sorted = function
  | ([] | [_]) -> true
  | x :: y :: xs when x > y -> false
  | _ :: xs -> is_sorted xs
;;

is_sorted [1; 2; 3];;

is_sorted [1; 3; 2];;

is_sorted [1; 2];;

is_sorted [1];;
