type int_ff = int -> int;;

let rec compose (fs: int_ff list) : int_ff =
  match fs with 
  | [] -> (fun x -> x)
  | f :: fs -> (fun x -> f ((compose fs) x))
;;

compose [(fun x -> x+1); (fun x -> x*3); (fun x -> x-1)] 2;;

let rec fixedpoint (f: float -> float) (start: float) (delta: float) : float =
  match abs_float(start -. (f start)) <= delta with
  | true -> start
  | false -> fixedpoint f (f start) delta
;;

fixedpoint cos 0. 0.001;;
