let rec equal_on_common l1 l2 = match l1, l2 with
  | ([], _) | (_, []) -> true
  | h1 :: r1, h2 :: r2 -> h1 = h2 && equal_on_common r1 r2
;;

equal_on_common [1;2;3] [1;4;5];;
equal_on_common [1;2;3] [1;2;3];;

let rec new_equal_on_common = function 
   | [] -> (function _ -> true)
   | h1 :: r1 -> 
     function 
     | [] -> true
     | h2 :: r2 -> h1 = h2 && new_equal_on_common r1 r2
;;


new_equal_on_common [1;2;3] [1;4;5];;
new_equal_on_common [1;2;3] [1;2;3];;

