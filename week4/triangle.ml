let ccr a b c s =
  let p = List.map (fun x -> cos (x /. 2.)) [a; b; c] in
  let dr = List.fold_left (fun x y -> x *. y) 8. p in
  s /. dr
;;

let helper x = 2. *. cos (x /. 2.);;

let new_ccr =
  fun a -> let a' = helper a in
  fun b -> let b' = a' *. helper b in
  fun c -> let c' = b' *. helper c in
  fun s -> s /. c'
;;

assert (ccr 1. 2. 3. 4. = new_ccr 1. 2. 3. 4.);;
