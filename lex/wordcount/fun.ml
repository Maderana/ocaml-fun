
let wordlist = ["hello"; "world"; "world"; "hello"; "world"; "canary"];;

module StringMap = Map.Make(String);;

let rec buildcount m = function
  | [] -> m
  | x :: xs -> try 
      let c = StringMap.find x m in
      buildcount (StringMap.add x (c + 1) m) xs
    with Not_found -> 
      buildcount (StringMap.add x 1 m) xs
;;

let printcount words = 
  let ws = buildcount (StringMap.empty) words in
  let wordlist = StringMap.fold 
      (fun k v acc -> (v, k) :: acc) 
      ws [] 
  in
  let wordcounts = List.sort 
      (fun (c1, _) (c2, _) -> Pervasives.compare c2 c1) 
      wordlist 
  in
  List.iter (fun (c, w) -> 
      print_endline ((string_of_int c) ^ " " ^ w))
    wordcounts
;;

printcount wordlist;;
