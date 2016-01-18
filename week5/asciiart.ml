(* if true then black else white *)
type image = int -> int -> bool ;;

(* coloring functions *)
let all_white = fun x y -> false ;;
let all_black = fun x y -> true ;;

let checkers = fun x y -> y/2 mod 2 = x/2 mod 2;;

(* paints a square with center at cx,cy and side s *)
let square cx cy s = fun x y ->
  let minx = cx - s / 2 in
  let maxx = cx + s / 2 in 
  let miny = cy - s / 2 in
  let maxy = cy + s / 2 in
  x >= minx && x <= maxx && y >= miny && y <= maxy
;;

(* paints a circle with center at cx,cy and radius r *)
let disk cx cy r = fun x y ->
  let x' = x - cx in
  let y' = y - cy in
  (x' * x' + y' * y') <= r * r
;;

type blend = 
  | Image of image
  | And of blend * blend
  | Or of blend * blend
  | Rem of blend * blend
;;

let display_image width height f_image =
  for y = 0 to height do
    for x = 0 to width do 
      if f_image x y
      then print_string "#"
      else print_string " "
    done;
    print_newline ()
  done
;;

display_image 10 10 (disk 5 5 5);;

let rec render blend x y : bool = 
  match blend with 
  | Image f -> f x y
  | And (Image f, Image g) -> (f x y) && (g x y)
  | Or (Image f, Image g) -> (f x y) || (g x y)
  | Rem (Image f, Image g) -> (f x y) && (not (g x y))
  | And (a, b) -> (render a x y) && (render b x y)
  | Or (a, b) -> (render a x y) || (render b x y)
  | Rem (a, b) -> (render a x y) && (not (render b x y))
;;

let display_blend x y blend = 
  display_image x y (fun x y -> render blend x y)
;;

display_blend 10 10 (Rem (Image all_black, Image (disk 5 5 5)));;
