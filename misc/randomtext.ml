#load "str.cma";;
type ltable = (string * string list) list;;

let words s = Str.split (Str.regexp "[^a-zA-Z0-9]+") s;;

let text = "I am a man and my dog is a good dog and a good dog makes a good man";;

Random.init 123;;

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


let table = build_ltable (words text);;

let next_in_ltable table w =
  let ws = List.assoc w table in
  List.nth ws (Random.int (List.length ws))
;;

let walk_table table = 
  let rec aux w l =
    if w = "STOP" then List.rev (List.tl l)
    else 
      let next = next_in_ltable table w in
      aux next (next :: l)
  in
    aux "START" []
;;

(* generate 10 sentences *)
let generate_text table =
  let rec aux i l = 
    if i = 0 then l
    else 
      aux (i-1) ((String.concat " " (walk_table table)) :: l)
  in
  aux 10 []
;;

generate_text table;;
