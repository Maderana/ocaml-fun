type point2d = int * int
type tetragon = point2d * point2d * point2d * point2d

let t1: tetragon = ((4, 5), (12, 3), (6, 3), (10, 33));;
let t2: tetragon = ((4, 8), (10, 10), (4, 4), (10, 13));;

let is_same ((x1, y1): point2d) ((x2, y2): point2d) : bool = 
  (x1 = x2) && (y1 = y2);;

let is_distinct (p1: point2d) (p2: point2d): bool = 
  not (is_same p1 p2);;

let pairwise_distinct ((lup, rup, llp, rlp) : tetragon): bool =
  is_distinct lup rup && is_distinct lup llp  && 
  is_distinct lup rlp && is_distinct rup llp  && 
  is_distinct rup rlp && is_distinct llp rlp ;;

let well_formed ((lup, rup, llp, rlp): tetragon) : bool =
  let (x1, y1) = lup in
  let (x2, y2) = rup in
  let (x3, y3) = llp in
  let (x4, y4) = rlp in 
  (y2 > y1) && (y4 > y3) && (x1 < x2) && (x3 < x4);;

(* other functions are pending *)
