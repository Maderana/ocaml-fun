let i = ref 0;;

i := !i + 1;;


let log2int n = 
  let count = ref 0 and v = ref n in
  while !v > 1 do
    count := !count + 1;
    v := !v/2;
  done;
  !count
;;

let swap a b =
  let t = ref !b in
  b := !a;
  a := !t;
;;


let x = ref 10;;
let y = ref 20;;
swap x y;;

let update r f =
  let x = f !r in
  r := x;
;;

let r = ref 6;;
update r (function x -> x + 1);;


exception Empty;;

let move r1 r2 = 
  match !r1 with 
  | [] -> raise Empty
  | x :: xs -> r1 := xs; r2 := x :: !r2
;;

let reverse l1 = 
  let r1 = ref l1 in
  let n = List.length l1 in
  let r2 = ref [] in
  for i = 0 to (n - 1) do
    move r1 r2;
  done;
  !r2
;;

