type filesystem = 
  (string * node) list
and node = 
  | File
  | Dir of filesystem
  | Symlink of string list
;;

let example_fs : filesystem = 
  [ "photos", Dir
      [ "march", Dir
          [ "photo_1.bmp", File ;
            "photo_2.bmp", File ;
            "photo_3.bmp", File ;
            "index.html", File ] ;
        "april", Dir
          [ "photo_1.bmp", File ;
            "photo_2.bmp", File ;
            "index.html", File ] ] ;
    "videos", Dir
      [ "video1.avi", File ;
        "video2.avi", File ;
        "video3.avi", File ;
        "video4.avi", File ;
        "best.avi", Symlink [ "video4.avi" ] ;
        "index.html", File ] ;
    "indexes", Dir
      [ "videos.html",
        Symlink [ ".." ; "videos" ; "index.html" ] ;
        "photos_march.html",
        Symlink [ ".." ; "photos" ; "march" ; "index.html" ] ;
        "photos_april.html",
        Symlink [ ".." ; "photos" ; "april" ; "index.html" ] ;
        "photos_may.html",
        Symlink [ ".." ; "photos" ; "may" ; "index.html" ] ] ]
;;

let rec join (sep: string) = function
  | [] -> ""
  | x :: xs when xs = [] -> x 
  | x :: xs -> x ^ sep ^ (join sep xs)
;;

let print_path (path: string list) = 
  print_string (join "/" path)
;;

let rec indent i s =
  match i with 
  | 0 -> s
  | x -> "| " ^ (indent (x - 1) s)
;;

let rec print_file i name = 
  let _ = print_string (indent i name) in
  print_newline () 
;;

let print_symlink i s path =
  let _ = print_string ((indent i s) ^ " -> " ^ (join "/" path)) in
  print_newline ()
;;

let print_dir i dir = 
  let _ = print_string (indent i ("/" ^ dir)) in
  print_newline ()
;;

let print_filesystem fs = 
  let rec aux i fs = 
    match fs with 
    | [] -> print_string ""
    | x :: xs -> let _ = print_node i x in aux i xs
  and print_node i (name, n) =
    match n with 
    | File -> print_file i name
    | Symlink path -> print_symlink i name path
    | Dir fs -> let _ = print_dir i name in aux (i + 1) fs
  in
  aux 0 fs
;;

