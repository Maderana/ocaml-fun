let is_multiple i x = i mod x = 0;;

let output_multiples x n m = 
  for i = n to m do 
    if is_multiple i x 
    then begin print_int i; print_string ", " end
  done
;;

output_multiples 4 0 45;;

exception Zero;;

let display_signs_until_zero f m = 
  for i = 0 to m do 
    match f i with
    | x when x > 0 -> begin print_endline "positive" end
    | x when x < 0 -> begin print_endline "negative" end
    | _ -> begin print_endline "zero"; raise Zero end
  done
;;
