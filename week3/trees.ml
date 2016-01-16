(* expressions *)
type exp =
  | EInt of int
  | EAdd of exp * exp
  | EMul of exp * exp
;;

let rec eval (e : exp) : int = 
  match e with
  | EInt i -> i
  | EAdd (e1, e2) -> eval e1 + eval e2
  | EMul (e1, e2) -> eval e1 * eval e2
;;

let example = EAdd (EMul (EInt 2, EInt 2), EMul (EInt 3, EInt 3));;
eval example;;

let factorize (e : exp) : exp = 
  match e with
  | EAdd (EMul (EInt a, EInt b), EMul (EInt x, EInt y)) -> 
    if x = a then EMul (EInt a, EAdd (EInt b, EInt y)) else e
  | _ -> e
;;

let example = EAdd (EMul (EInt 2, EInt 4), EMul (EInt 2, EInt 3));;
factorize example;;

let expand (e: exp) : exp =
  match e with
  | EMul (EInt a, EAdd (EInt b, EInt c)) -> 
    EAdd (EMul (EInt a, EInt b), EMul (EInt a, EInt c))
  | _ -> e
;;

expand (factorize example);;

let simplify (e : exp) : exp =
  match e with
  | EMul (EInt 0, e1) | EMul (e1, EInt 0) -> EInt 0
  | EMul (EInt 1, e1) | EMul (e1, EInt 1) | EAdd (e1, EInt 0) | EAdd (EInt 0, e1) -> e1
  | _ -> e
;;

simplify (EMul (EInt 1, EInt 10));;

(* Tries *)

(* mutually recursive types *)
type trie = Trie of int option * char_to_children
and char_to_children = (char * trie) list ;;

let empty = Trie (None, []);;

let example = 
  Trie (None,
          [('i', Trie (Some 11,
                       [('n', Trie (Some 5, [('n', Trie (Some 9, []))]))]));
           ('t',
            Trie (None,
                  [('e',
                    Trie (None,
                          [('n', Trie (Some 12, [])); 
                           ('d', Trie (Some 4, []));
                           ('a', Trie (Some 3, []))]));
                   ('o', Trie (Some 7, []))]));
           ('A', Trie (Some 15, []))])
;;

let rec children_from_char (m: char_to_children) (c: char) : trie option =
  match m with 
  | [] -> None
  | (ch, tr) :: tl -> 
    if ch = c then Some tr else children_from_char tl c
;;

let test_children_from_char = 
  let Trie (_, cs) = example in
  children_from_char cs 'i'
;;

let rec update_children (m: char_to_children) (c: char) (t: trie) : char_to_children = 
  match m with 
  | [] -> []
  | (ch, tr) :: tl -> 
    if ch = c 
    then (ch, t) :: tl 
    else (ch, tr) :: update_children tl c t
;;

let lookup (t: trie) (key: string) : int option =
  let rec loop (tr: trie) (i: int) (found: int option) : int option = 
    if i = String.length key (* string exhausted *)
    then found
    else
      let Trie (_, cs) = tr in
      match children_from_char cs (String.get key i) with
      | None -> None
      | Some Trie(v, xs) -> loop (Trie (v, xs)) (i + 1) v
  in
  loop t 0 None
;;



