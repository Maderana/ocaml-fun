let read_intlist () =
  let l = ref [] in
  let doread() = 
    try 
      while true do 
        l := (read_int ()) :: !l
      done
    with _ -> ()
  in
  doread();
  List.rev !l
;;

let read_lines () = 
  let sl = ref [] in
  let rec aux () =
    try 
      sl := read_line () :: !sl;
      aux ()
    with
      End_of_file -> List.rev !sl in
  aux ()
;;

