type operation = 
  | Op of string * operation * operation
  | Value of int
;;

(* (name, fn x y -> z) list) *)
type env = (string * (int -> int -> int)) list;;

let initial_env : env = [("mul", (fun x y -> x * y));
                         ("add", (fun x y -> x + y))];;

let example = Op ("mul", 
                  Op ("add", Value 0, Value 1), 
                  Op ("mul", Value 3, Value 4));;

(* could've used List.assoc had there 
   not been a requirement of custom exception *)
let rec lookup_function name = function
  | [] -> invalid_arg "lookup_function"
  | (n, f) :: xs -> 
    if n = name then f else lookup_function name xs
;;

assert ((lookup_function "mul" initial_env) 3 4 = 12);;
assert ((lookup_function "add" initial_env) 3 4 = 7);;

let rec add_function name f (envv : env) : env =
  (name, f) :: envv
;;

let myenv : env = [("min", (fun x y -> if x < y then x else y))];;
let maxenv = add_function "max" (fun x y -> if x > y then x else y) myenv;;

let rec compute (envv : env) (op : operation) : int = 
  match op with
  | Value x -> x
  | Op (n, op1, op2) ->
    let f = lookup_function n envv in
    f (compute envv op1) (compute envv op2)
;;

assert (compute initial_env example = 12);;
assert (compute myenv (Op ("min", Value 4, Value 2)) = 2);;
assert (compute maxenv (Op ("max", Value 4, Value 2)) = 4);;

(* took help from the forums - very confusing wording on problem 5*)
let rec compute_eff (envv : env) (op : operation) : int = 
  match op with
  | Value x -> x
  | Op (n, op1, op2) -> 
    lookup_function n envv (compute envv op1) (compute envv op2)
;;

assert (compute_eff initial_env example = 12);;
assert (compute_eff myenv (Op ("min", Value 4, Value 2)) = 2);;
assert (compute_eff maxenv (Op ("max", Value 4, Value 2)) = 4);;
