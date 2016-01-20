let print_hash (h: Digest.t) : unit =
  h
  |> Digest.to_hex 
  |> String.uppercase 
  |> print_endline
;;

let print_hashes (hashes: Digest.t list) : unit = 
  List.iter print_hash hashes
;;


