open Ast

let rec pow x = function
  | 0 -> 1
  | 1 -> x
  | _ as e -> x * pow x (e - 1)
;;

let rec eval table = function
  | Lit x -> x
  | Binop (e1, op, e2) ->
    let l = eval table e1 in
    let r = eval table e2 in
    (match op with
    | Add -> l + r
    | Sub -> l - r
    | Mul -> l * r
    | Div -> l / r
    | Pow -> pow l r)
  | Var v -> table.(v)
  | Asn (i, e) -> 
    let v = eval table e in
    Array.set table i v; v
  | Seq (e1, e2) -> 
    let _ = eval table e1 in
    eval table e2
;;

let _ = 
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expr Scanner.token lexbuf in
  let result = eval (Array.make 26 0) expr in
  print_endline (string_of_int result)
;;

