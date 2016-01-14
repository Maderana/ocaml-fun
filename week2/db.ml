type phone_number = int * int * int * int;;

type contact = {
  name         : string;
  phone_number : phone_number;
};;

let nobody = { name = ""; phone_number = (0,0,0,0) };;

type database = {
  number_of_contacts : int;
  contacts           : contact array
};;

let make size = 
  { 
    number_of_contacts =  0; 
    contacts = Array.make size nobody 
  }
;;

type query = {
  code    : int;
  contact : contact;
};;

(* db functions *)
let search db contact = 
  let rec loop i = 
    if i >= db.number_of_contacts then
      (false, db, nobody)
    else if db.contacts.(i).name = contact.name then
      (true, db, db.contacts.(i))
    else
      loop (i + 1)
  in
  loop 0
;;
 
let insert db contact = 
  if db.number_of_contacts = Array.length db.contacts - 1
  then (false, db, nobody)
  else
    let (status, db, _) = search db contact in
    if status then (false, db, contact) (* contact already exists *)
    else 
      let updatefn idx = 
        if idx = db.number_of_contacts 
        then contact           (* only the last elem is changed *)
        else db.contacts.(idx) (* rest is not *)
      in
      let db' = {
        number_of_contacts = db.number_of_contacts + 1;
        contacts = Array.init (Array.length db.contacts) updatefn
      }
      in
      (true, db', contact)
;;


let delete db contact = 
  let (status, db, contact) = search db contact in
  if not status
  then (false, db, contact) (* data doesnt exist *)
  else 
    let updatefn i = 
      if db.contacts.(i).name = contact.name
      then nobody
      else db.contacts.(i) in
    let db' = {
      number_of_contacts = db.number_of_contacts - 1;
      contacts = Array.init (Array.length db.contacts) updatefn
    }
    in
    (true, db', contact)
;;


(* testing the database *)
let db = make 10;;
let myself =  { name = "prakhar"; phone_number = (10, 23, 12, 13) };;
let (_, newdb, _) = insert db myself;;
