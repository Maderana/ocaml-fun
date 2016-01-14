let integer_square_root n = int_of_float(sqrt(float_of_int n));;

let multiple_of n d = n mod d = 0;;

let last_character str =
  let n = String.length str in
  String.get str (n-1);;

let string_to_bool truth =
  if truth then "true" else "false";;

(* mutually recursive *)
let rec even x = if x = 0 then true else odd (x - 1)
and odd x = if x = 0 then false else even (x - 1);;

(* primes *)
let rec gcd n m = if m = 0 then n else gcd m (n mod m);;

let rec multiple_upto n r =
  if r = 1 then false
  else if n mod r = 0 then true
  else multiple_upto n (r-1);;

let is_prime n = 
  let limit = int_of_float (sqrt (float_of_int n)) in
  not (multiple_upto n limit);;

let rec range a b =
  if a >= b then []
  else a :: range (a + 1) b;;

let primes_below_n n = List.filter is_prime (range 2 (n + 1));

(* tuples *)
type point = (int * int);;
let (origin : point) = (0, 0);;
let x_positive_limit = (max_int, 0);;
let x_negative_limit = (min_int, 0);;

let distance ((x1, y1) : point) ((x2, y2) : point) : float = 
  let sq (x : int) : float =  float_of_int (x * x) in
  sqrt (sq (x1 - x2) +. sq (y1 - y2));;

(* records *)
type point2D = { x: int; y: int };;
let origin = {x = 0; y = 0};;
let from_tuple (x, y) = { x; y };;
let sum_of_coords (p : point2D) = p.x + p.y;;
type box = {
  left_upper_corner: point2D;
  right_upper_corner: point2D;
};;

let the_box = {
  left_upper_corner = from_tuple (4, 5);
  right_upper_corner = from_tuple (10, 24)
};;

(* patt matching in records *)
let get_min_x { left_upper_corner = { x } } = x;;

(* arrays *)
let p = [|1; 2; 3|];;
let square x = x * x;;
(* array.init takes a fn that takes index as argument *)
let squares n = Array.init n square;;
let s1 = squares 5;;
let blank_array size = Array.make size 0;;
