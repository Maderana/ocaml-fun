(* defining the types *)
type contact = { name : string; number : int * int * int * int };;

type database = {
  count : int;
  contacts : contact array
};;

type query =
  | Insert of contact
  | Delete of contact
  | Search of string
;;

type query_result = 
  | Error
  | NewDatabase of database
  | FoundContact of contact * int
;;

let nobody = { name = ""; number = (0,0,0,0) };;

let make (size: int) : database = 
  { count = 0; contacts = Array.make size nobody };;

let search db (name:string) : query_result = 
  let rec loop i =
    if i >= db.count
    then Error
    else 
     if db.contacts.(i).name = name
     then FoundContact (db.contacts.(i), i)
     else loop (i + 1)
  in
  loop 0
;;

let delete db contact : query_result = 
  match search db contact.name with 
  | Error                     -> Error
  | NewDatabase db            -> NewDatabase db
  | FoundContact (contact, _) ->
    let updatefn i = 
      if db.contacts.(i).name = contact.name
      then nobody
      else db.contacts.(i) in
    NewDatabase { 
      count = db.count - 1; 
      contacts = Array.init (Array.length db.contacts) updatefn
    }
;;

let insert db contact : query_result = 
  if db.count >= Array.length db.contacts
  then Error
  else 
    match search db contact.name with
    | FoundContact (_, _) -> Error
    | NewDatabase db      -> NewDatabase db
    | Error               -> 
       let updated_count = db.count + 1 in
       let updatefn i = 
         if db.contacts.(i) = nobody && i < updated_count
         then contact
         else db.contacts.(i) in
       NewDatabase {
         count = updated_count;
         contacts = Array.init (Array.length db.contacts) updatefn
       }
;;

let engine db query : query_result = 
  match query with 
  | Insert contact -> insert db contact
  | Delete contact -> delete db contact
  | Search name    -> search db name
;;

let db = make 5;;
let alpha = { name = "alpha"; number = (1,2,3,4) };;

