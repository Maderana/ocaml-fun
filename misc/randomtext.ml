#load "str.cma";;
open Hashtbl;;

type ltable = (string * string list) list;;

type distribution =
  { total : int;
    amounts : (string * int) list }
;;

type htable = (string, distribution) Hashtbl.t;;

let words s = Str.split (Str.regexp "[^a-zA-Z0-9]+") s;;

let text = "I am a man and my dog is a good dog and a good dog makes a good man";;

Random.init 123;;

(* using association lists *)
let build_ltable ws = 
  let rec aux t = function
    | [] -> t
    | x :: [] -> 
      (try
         let s = List.assoc x t in
         let (_, l) = List.partition (fun (k, v) -> k = x) t in
         (x, ("STOP" :: s)) :: l
       with 
       | Not_found -> (x, ["STOP"]) :: t)
    | x :: y :: xs ->
      try 
        let s = List.assoc x t in
        let (_, l) = List.partition (fun (k, v) -> k = x) t in
        aux ((x, y :: s) :: l) (y :: xs)
      with
      | Not_found -> aux ((x, [y]) :: t) (y :: xs)
  in
  aux [("START", [List.hd ws])] ws
;;

let next_in_ltable table w =
  let ws = List.assoc w table in 
  List.nth ws (Random.int (List.length ws))
;;

let walk_ltable table = 
  let rec aux w l =
    if w = "STOP" then List.rev (List.tl l)
    else 
      let next = next_in_ltable table w in
      aux next (next :: l)
  in
    aux "START" []
;;


(* using hash table *)

let compute_distribution xs =
  let counts = List.fold_left
    (fun acc x ->
       let (k, c) = List.hd acc in
       if k = x 
       then (k, c+1) :: List.tl acc 
       else (x, 1) :: acc)
    [(List.hd xs, 1)]
    (List.sort Pervasives.compare (List.tl xs))
  in
  let total = counts
              |> List.map (fun (k, v) -> v)
              |> List.fold_left ( + ) 0 in
  {total = total; amounts = counts }
;;

(* returns the hashtable *)
let build_hashtable ws = 
  let rec aux ht = function
    | [] -> ()
    | x :: [] -> 
      (try 
        let s = Hashtbl.find ht x in
        Hashtbl.replace ht x ("STOP" :: s)
       with 
       | Not_found -> Hashtbl.add ht x ["STOP"])
    | x :: y :: xs ->
      try 
        let s = Hashtbl.find ht x in
        Hashtbl.replace ht x (y :: s); 
        aux ht (y :: xs);
      with
      | Not_found -> Hashtbl.add ht x [y]; aux ht (y :: xs);
  in
  let ht = Hashtbl.create (List.length ws) in
  Hashtbl.add ht "START" [List.hd ws];
  aux ht ws;

  let table : htable = Hashtbl.create (List.length ws) in
  Hashtbl.iter 
    (fun k v -> Hashtbl.add table k (compute_distribution v))
    ht;
  table
;;

let table = build_hashtable (words text);;

let next_in_htable table w =
  let dist = Hashtbl.find table w in
  let index = 1 + Random.int dist.total in
  let rec aux total words =
    let (w, c) = List.hd words in
    if total + c >= index then w
    else aux (total + c) (List.tl words)
  in
  aux 0 dist.amounts
;;

let walk_htable table = 
  let rec aux w l =
    if w = "STOP" then List.rev (List.tl l)
    else 
      let next = next_in_htable table w in
      aux next (next :: l)
  in
    aux "START" []
;;

let generate_text table =
  let rec aux i l = 
    if i = 0 then l
    else 
      aux (i-1) ((String.concat " " (walk_htable table)) :: l)
  in
  aux 10 []
;;

generate_text table;;
