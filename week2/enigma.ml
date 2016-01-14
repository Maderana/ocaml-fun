(* solving enigma *)
let exchange num = (num mod 10) * 10 + (num / 10);;

let is_valid_answer (father, son) = 
  let exp1 = son * 4 = father in
  let exp2 = exchange(son) = 3 * exchange(father) in
  exp1 && exp2;;

let rec find (max_age, min_age) : (int * int) = 
  let rec find_inner (max_age, min_age) : (int * int) =
    if min_age >= max_age then (-1, -1) 
    else if is_valid_answer(max_age, min_age) then (max_age, min_age)
    else find_inner (max_age, min_age + 1) in
  if min_age >= max_age then (-1, -1)
  else 
    let (a, b) = find_inner (max_age, min_age) in
    if (a, b) = (-1, -1) then find (max_age - 1, min_age)
    else (a, b);;

