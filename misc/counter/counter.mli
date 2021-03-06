open Core.Std


(** A collection of string frequence counts *)
type t

type median = 
  | Median of string
  | Before_and_after of string * string
;;

(** the empty set of frequency counts *)
val empty : t

(** computed median *)
val median : t -> median

(** bump the frequency count for the given string *)
val touch : t -> string -> t

(** Converts the set of frequency counts to an association list.  
    A string shows up at most once, and the counts are >= 1. *)
val to_list : t -> (string * int) list
