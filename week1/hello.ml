let rec suml = 
  function 
    [] -> 0
    a::rest -> a + (suml rest);;

let rec fold op e =
  function
   | [] -> e
   | a :: rest -> op e (fold op e rest);;

let rec destutter =
  function
  | [] ->  []
  | x :: [] -> x :: []
  | x :: y :: [] -> 
    if x = y then destutter (y :: rest)
    else x :: destutter (y :: rest) ;;

