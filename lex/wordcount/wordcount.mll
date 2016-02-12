{ type token = EOF | Word of string }

rule token = parse
 | eof                        { EOF }
 | ['a'-'z' 'A'-'Z']+ as word { Word(word) }
 | _                          { token lexbuf }

{
    module StringMap = Map.Make(String);;
    let lexbuf = Lexing.from_channel stdin in
    let wordlist = 
        let rec next l = 
            match token lexbuf with
            | EOF -> l
            | Word (s) -> next (s :: l)
        in next []
    in
    let rec buildcount m = function
      | [] -> m
      | x :: xs -> try 
          let c = StringMap.find x m in
          buildcount (StringMap.add x (c + 1) m) xs
        with Not_found -> 
          buildcount (StringMap.add x 1 m) xs
    in
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
    in 
    printcount wordlist;;

}
