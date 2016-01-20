type 'a rle = 
  | One of 'a
  | Many of int * 'a
;;

let example = [1; 1; 1; 3; 4; 1; 1];;

let computerle (l: int list) : int rle list =
  List.fold_left 
    (fun acc x -> 
       match List.hd acc with
       | One v ->  
    
    )
    [One (List.hd l)]
    l
;;

computerle example;;
