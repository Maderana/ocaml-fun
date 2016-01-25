type operator = Add | Sub | Mul | Div;;

type expr = 
  | Binop of expr * operator * expr
  | Lit of int
  | Seq of expr * expr
  | Asn of int * expr
  | Var of int
;;

(* 4 * 10 + 100 *)
let example = Binop(Binop (Lit 4, Mul, Lit 10), Add, Lit 100);;

(* b = 4; b + 10 *)
let example2 = Seq(Asn(1, Lit 4), Binop (Var 1, Add, Lit 10));;

(* a = 10, b = 14, a + b * 10 *)
let example3 = Seq(Asn(0, Lit 10), 
                   Seq(
                     Asn(1, Lit 14),
                     Binop (Var 0, Add, 
                            Binop (Lit 10, Mul, Var 1))));;

(* a = b = 3, b = b + 3, a * b + 2 *)
let example4 = Seq(
    Asn (0, Asn(1, Lit 3)), 
    Seq(
      Asn(1, Binop(Var 1, Add, Lit 3)),
      Binop(Binop (Var 0, Mul, Var 1), Add, Lit 2)
    )
  )
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
    | Div -> l / r)
  | Var v -> table.(v)
  | Asn (i, e) -> 
    let res = eval table e in
    Array.set table i res;
    res
  | Seq (e1, e2) -> 
    let _ = eval table e1 in
    eval table e2
;;

(* initialize the table *)
eval (Array.make 26 0) example;;  (* // 140 *)
eval (Array.make 26 0) example2;; (* // 14 *)
eval (Array.make 26 0) example3;; (* // 150 *)
eval (Array.make 26 0) example4;; (* // 20 *)
