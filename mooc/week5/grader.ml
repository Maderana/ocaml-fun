open Printexc;;
open Random;;

type report = message list
and message = string * status
and status = Successful | Failed;;

(* seeding *)
Random.init 123;;

type 'a result = Ok of 'a | Error of exn;;

let exec f x =
  try
    Ok (f x)
  with e ->
    Error e
;;

(* throws exception *)
exec (fun x -> 10 / x) 0;;

(* gives Ok *)
exec (fun x -> 10 / x) 2;;

let exn_to_string (e: exn) = Printexc.to_string e;;

let compare user reference to_string =
  match user, reference with
  | Ok x, Ok y when x = y -> ("got correct value of " ^ to_string x, Successful)
  | Ok x, Ok _ -> ("got unexpected value of " ^ to_string x, Failed)
  | Error e1, Error e2 when e1 = e2 -> ("got correct exception " ^ exn_to_string e1, Successful)
  | Error e1, Error _ -> ("got unexpected exception " ^ exn_to_string e1, Failed)
  | Ok x, Error e -> ("got unexpected exception " ^ exn_to_string e, Failed)
  | Error e, Ok x -> ("got unexpected value of " ^ to_string x, Failed)
;;

let int_sampler () = Random.int 100;;

(* generate c samples *)
let gensamples (sampler: unit -> 'a) (c: int) : 'a list =
  let rec aux count l = 
    let r = sampler () in
    if count = 0 then l else aux (count - 1) (r :: l)
  in
  aux c []
;;

let test (user: 'a -> 'b) (reference: 'a -> 'b) (sampler: unit -> 'a) (to_string: 'b -> string) : report = 
  let samples = gensamples sampler 10 in
  let rec aux l = function 
    | [] -> l
    | x :: xs -> 
      let user_result = exec user x in
      let ref_result = exec reference x in
      let msg = compare user_result ref_result to_string in
      aux (msg :: l) xs
  in 
  aux [] samples
;;

test (fun x -> x mod 2 = 0) (fun y -> y mod 2 = 0) int_sampler string_of_bool;;

