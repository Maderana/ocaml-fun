module type ID = sig 
  type t
  val of_string : string -> t
  val to_string : t -> string
end

module String_id = struct
  type t = string
  let of_string x = x
  let to_string x = x
end

module Username : ID = String_id 
module Hostname : ID = String_id 

type session_info = {
  user: Username.t;
  host: Hostname.t;
  when_started: Time.t;
}

(* if we match host by user then it'll give compile errors *)
let sessions_have_same_name s1 s2 = 
  s1.user = s2.user
;;
