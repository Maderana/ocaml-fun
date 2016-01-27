open Core.Std;;


let header = ["language";"architect";"first release"];;
let rows = [ 
  ["Lisp" ;"John McCarthy" ;"1958"];
  ["C"    ;"Dennis Ritchie";"1969"];
  ["ML"   ;"Robin Milner"  ;"1973"];
  ["OCaml";"Xavier Leroy"  ;"1996"];
];;

let max_widths header rows = 
  let lengths l = List.map ~f:String.length l in
  List.fold rows
    ~init: (lengths header)
    ~f: (fun acc row ->
        List.map2_exn ~f:Int.max acc (lengths row))
;;

let render_separator widths = 
  let pieces = List.map widths ~f: (fun w -> String.make (w + 2) '-') in
  "|" ^ String.concat ~sep:"+" pieces ^ "|"
;;


let pad s length = 
  " " ^ s ^ String.make (length - String.length s + 1) ' '
;;

let render_row row widths = 
  let padded = List.map2_exn ~f:pad row widths in
  "|" ^ (String.concat ~sep:"|" padded) ^ "|"
;;

let render header rows = 
  let widths = max_widths header rows in
  String.concat ~sep:"\n" 
    ( render_separator widths
     :: render_row header widths 
     :: render_separator widths
     :: List.map rows ~f:(fun row -> render_row row widths))
;;

print_string (render header rows);;