type alphabet = string * float;;

let dna = [("A", 0.55); ("C", 0.025); ("G", 0.125); ("T", 0.3)];;

let lowest_two xs = 
  List.fold_left 
    (fun ((a1, c1), (a2, c2)) (a, c) -> 
       if (c > c1) && (c > c2)
       then ((a1, c1), (a2, c2))
       else if c < c1 then ((a, c), (a2, c2)) 
       else ((a1, c1), (a, c))) 
    ((" ", max_float), (" ", max_float))
    xs
;;

let getcodes (input: alphabet list): (string, string) Hashtbl.t = 
  let rec aux codes = function
    | [x] -> codes
    | _ as xs -> 
      let ((a1, c1), (a2, c2)) = lowest_two xs in
      let rest = List.filter (fun (a, c) -> (a != a1) && (a != a2)) xs in
      aux ((a1, "1") :: (a2, "0") :: codes) ((a1 ^ a2, c1 +. c2) :: rest)
  in
  let codes = aux [] input in
  let table = Hashtbl.create (List.length input) in
  List.iter 
    (fun (xs, b) -> 
       let updatecode c v = 
         try
           let i = Hashtbl.find table c in
           Hashtbl.replace table c (i ^ v)
         with Not_found ->
           Hashtbl.add table xs v
       in
       if String.length xs = 1
       then updatecode xs b
       else String.iter (fun i -> updatecode (String.make 1 i) b) xs
    )
    codes;
  table
;;

let t = getcodes dna;;
Hashtbl.iter (fun k v -> print_endline (k ^ " - " ^ v)) t;;
