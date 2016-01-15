let myarra = [|4; 8; -43; 6; 10; 0; -4|];;
let string_array = [|"alpha"; "beta"; "delta"; "gamma"; "zeta"|];;

let lesser x y = if x < y then x else y;;

let min arr = Array.fold_left lesser max_int arr;;

let min_index arr : int = 
  let m = min arr in 
  let a = Array.mapi (fun i x -> (i, x)) arr in
  match List.filter (fun (i, v) -> v = m) (Array.to_list a) with
    [] -> -1
  | (i, _) :: _ -> i
;;

let it_scales = "yes";;

let is_sorted (arr : string array) : bool =
  let arrcpy = Array.copy arr in
  let _ = Array.sort String.compare arr in
  let _ = Array.sort String.compare arrcpy in
  arrcpy = arr
;;

(* binary search *)
let find (haystack : string array) (needle: string) : int =
  let rec bin_search (s: int) (e: int) : int = 
    if s > e then -1
    else 
      let mid = s + (e - s) / 2 in
      if haystack.(mid) = needle then mid
      else if haystack.(mid) > needle then bin_search s (mid - 1)
      else bin_search (mid + 1) e in
  bin_search 0 ((Array.length haystack) - 1)
;;

let another_minindex arr = 
  let (i, _) = 
    Array.fold_left 
    (fun (i1,x1) (i2,x2) -> if x1 < x2 then (i1,x1) else (i2, x2)) 
    (-1, max_int)
    (Array.mapi (fun i x -> (i, x)) arr) in
  i
;;
