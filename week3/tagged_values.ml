type color = Black | Gray | White;;

let lighter (c1: color) (c2: color) = 
  match (c1, c2) with
  | (Black, Black) -> false
  | (White, White) -> false
  | (Gray, Gray)   -> false
  | (Black, _) -> true
  | (_, White) -> true
  | (White, Gray) -> false
  | (Gray, Black) -> false
  | (White, Black) -> true
;;
