let zip xs ys = 
  let l1 = List.length xs and l2 = List.length ys in
  let diff = l1 - l2 and tup = (fun x y -> (x, y)) in
  let arr = Array.to_list(Array.make (abs diff) 0) in
  match diff with
  | 0 -> List.map2 tup xs ys
  | x when x > 0 -> List.map2 tup xs (arr @ ys)
  | x -> List.map2 tup (arr @ xs) ys
;;

let subl xs ys = 
  let res, _ = ListLabels.fold_right 
    ~init: ([], 0)
    ~f: (fun (x, y) (ts, carry) ->
        let x = x - carry and carry = 0 in
        if x >= y then ((x - y) :: ts, carry)
        else ((10 + x - y) :: ts, 1))
    (zip xs ys) 
  in
  match res with
  | x :: xs when x = 0 -> xs
  | _ -> res
;;

assert(subl [2;5;3] [5;7] = [1; 9; 6]) ;;
assert(subl [1;0;0] [4;8] = [5; 2]) ;;
assert(subl [1;0;0;0;0;0;0;0;0;0;0;0] 
         [4;2;0;0;0;0;0;0;0;0;0] = [5; 8; 0; 0; 0; 0; 0; 0; 0; 0; 0]) ;;
