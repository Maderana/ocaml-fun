let rotate a =
  let n = Array.length a in 
  if n > 0 then 
    begin
      let v = a.(0) in
      for i = 0 to n-2 do
        a.(i) <- a.(i+1)
      done;
      a.(n-1)<-v
    end;;

let x = Array.init 10 (fun i -> i);;


(* reverses an array in place between i to j *)
let reverse arr i j =
  for x = i to (j - i) / 2 do 
    let k = j - (x - i) in
    let t = arr.(x) in
    arr.(x) <- arr.(k);
    arr.(k) <- t;
  done
;;

(* can be made more robust be checking of edge cases *)
let rotate_by arr k = 
  let n = Array.length arr in
  let a = n - k in
  begin
    reverse arr 0 (n - 1);
    reverse arr 0 (a - 1);
    reverse arr a (n - 1);
  end
;;

let arr = [|1; 2; 3; 4|];;
rotate_by arr 3;;
