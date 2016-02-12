module MyStack = struct 
  type 'a stack = 
    | Empty
    | Entry of 'a * 'a stack
  ;;

  let empty = Empty;;
  let is_empty s = s = Empty;;
