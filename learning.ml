let rec map f = function
    [] -> []
    | head :: tail -> 
            let r = f head in 
            r :: map f tail
;;

let rec fact n = if n < 2 then 1 else n * fact(n - 1)

let rec gcd a b = 
    if a = b then a
    else if a > b then gcd (a - b) b
    else gcd a (b - a)
;;

let x = gcd 10 45;;
print_endline x;;
