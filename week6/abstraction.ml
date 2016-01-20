module Exp : sig
  type e
  val int : int -> e
  val mul : e -> e -> e
  val add : e -> e -> e
end = struct
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

  let rec to_string = function 
    | EInt i -> string_of_int i
    | EMul (e1, e2) -> "(" ^ (to_string e1) ^ " * " ^ (to_string e2) ^ ")"
    | EAdd (e1, e2) -> "(" ^ (to_string e1) ^ " + " ^ (to_string e2) ^ ")"
  ;;
end

let e1 = Exp.mul (Exp.int 0) (Exp.add (Exp.int 1) (Exp.int 2));;

(* the following function doesn't compile *)
let e2 = Exp.EMul (Exp.EInt 0) (Exp.EAdd (Exp.EInt 1) (Exp.EInt 2));;



