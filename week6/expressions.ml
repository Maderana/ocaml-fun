module Exp = struct
  type e = 
    | EInt of int
    | EMul of e * e
    | EAdd of e * e
  ;;

  let int x = EInt x;;

  let mul a b =
    match a, b with 
    | (EInt 0, _) | (_, EInt 0) -> EInt 0
    | (EInt 1, e) | (e, EInt 1) -> e
    | (a, b) -> EMul (a, b)
  ;;

  let add a b = 
    match a, b with 
    | (EInt 0, e) | (e, EInt 0) -> e
    | (a, b) -> EAdd (a, b)
  ;;

  let rec eval = function 
    | EInt x -> x
    | EMul (e1, e2) -> eval e1 * eval e2
    | EAdd (e1, e2) -> eval e1 + eval e2
  ;;

end

let example x y z = 
  Exp.int (Exp.eval 
              (Exp.mul (Exp.int x) 
                 (Exp.add (Exp.int y) (Exp.int z))))
