type number = int * int * int * int;;

type contact = {
  name         : string;
  number : number;
};;

let nobody = { name = ""; number = (0,0,0,0) };;

type database = {
  count : int;
  contacts           : contact array
};;

let make size = 
  { 
    count =  0; 
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
    if i >= db.count 
    then (false, db, nobody)
    else 
     if db.contacts.(i).name = contact.name
     then (true, db, db.contacts.(i))
     else loop (i + 1)
  in
  loop 0
;;
 
let insert db contact = 
  if db.count >= Array.length db.contacts
  then (false, db, nobody)
  else
    let (status, db, _) = search db contact in
    if status 
    then (false, db, contact) (* contact already exists *)
    else 
      let updatefn idx = 
        if idx = db.count 
        then contact           (* only the last elem is changed *)
        else db.contacts.(idx) (* rest is not *)
      in
      let db' = {
        count = db.count + 1;
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
      count = db.count - 1;
      contacts = Array.init (Array.length db.contacts) updatefn
    }
    in
    (true, db', contact)
;;

(* fixes bug by ensuring insertions are done at blank locations *)
let correct_insert db contact = 
  if db.count >= Array.length db.contacts
  then (false, db, nobody)
  else
    let (status, db, _) = search db contact in
    if status
    then (false, db, contact) (* already exists *)
    else
      let updated_count = db.count + 1 in
      let updatefn idx = 
        if db.contacts.(idx) = nobody && idx < updated_count
        then contact
        else db.contacts.(idx)
      in
      let db' = {
        count = updated_count;
        contacts = Array.init (Array.length db.contacts) updatefn
      }
      in
      (true, db', contact)
;;

let update db contact = 
  let (status, _, _) = search db contact in 
  if not status
  then correct_insert db contact (* insert record *)
  else
    let updatefn i = 
      if db.contacts.(i).name = contact.name
      then contact
      else db.contacts.(i) in
    let db' = {
      count = db.count;
      contacts = Array.init (Array.length db.contacts) updatefn
    }
    in
    (true, db', contact)
;;

(* the query engine *)
let engine db (code, contact) = 
  match code with 
    0 -> insert db contact
  | 1 -> delete db contact
  | 2 -> search db contact
  | 3 -> correct_insert db contact
  | 4 -> update db contact
  | _ -> (false, db, nobody)
;;

let dummy_phone : number = (1,2,3,4);;

(* gamma is not deleted but it's not searchable *)
let proof_of_bug = 
  let db = make 5 in
  let (_,db,_) = engine db (0, { name = "alpha"; number = dummy_phone }) in 
  let (_,db,_) = engine db (0, { name = "beta";  number = dummy_phone }) in
  let (_,db,_) = engine db (0, { name = "gamma"; number = dummy_phone }) in
  let (_,db,_) = engine db (1, { name = "alpha"; number = dummy_phone }) in 
  let (_,db,_) = engine db (0, { name = "alpha"; number = dummy_phone }) in
  let (_,_,contact) = engine db (2, { name = "gamma"; number = dummy_phone }) in
  contact
;;

let bug_fix_check = 
  let db = make 5 in
  let (_,db,_) = engine db (3, { name = "alpha"; number = dummy_phone }) in 
  let (_,db,_) = engine db (3, { name = "beta";  number = dummy_phone }) in
  let (_,db,_) = engine db (3, { name = "gamma"; number = dummy_phone }) in
  let (_,db,_) = engine db (1, { name = "alpha"; number = dummy_phone }) in 
  let (_,db,_) = engine db (3, { name = "alpha"; number = dummy_phone }) in
  let (_,_,contact) = engine db (2, { name = "gamma"; number = dummy_phone }) in
  contact
;;

let db = make 5;;
let (status, db, _) = engine db (3, { name = "alpha"; number = dummy_phone });;
let (status, db, contact) = engine db (4, { name = "alpha"; number = (10,10,10,10) });;
