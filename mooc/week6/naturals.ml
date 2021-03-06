module Naturals : sig
  (* Invariant: A value of type t is a positive integer *)
  type t 
  val zero : t 
  val succ : t -> t
  val pred : t -> t
end = struct
  type t = int
  let zero = 0
  let succ n = if n = max_int then 0 else n + 1;;
  let pred = function 0 -> 0 | n -> n - 1;;
end;;

open Naturals

let rec add (x: t) (y: t) : t =
  if x = zero then y else succ (add (pred x) y);;

(* now this wont compile
let break_abstraction = pred (-1);;  *)
