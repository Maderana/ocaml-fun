(* The Abstract Syntax Tree for the MicroC language *)

type op = PLUS | MINUS | MULTIPLY | DIVIDE | GT | LT | GTE | LTE | NOTEQUALS | EQUALS

type expr =
  | Literal of int                   (* 10                           *)
  | Binop of expr * op * expr        (* 45 + 214                     *)
  | Call of string * expr list       (* func (exprs ... )            *)
  | Assign of string * expr          (* x = 10 + y                   *)
  | Noexpr                           (* for (;;)                     *)
  | Id of string                     (* foo                          *)
;;

type stmt =
  | Block of stmt list               (* { ... stmts ... }            *)
  | Expr of expr                     (* 45 + 34                      *)
  | Return of expr                   (* return 10;                   *)
  | If of expr * stmt * stmt         (* if (x == 4) {...} else {...} *)
  | For of expr * expr * expr * stmt (* for(i=0;i<10;i=i+1) { ... }  *)
  | While of expr * stmt             (* while (i > 10) { ... }       *)
;;

(* gcd (a, b) { ... }                                                *)
type func_decl = {                   (* func defined as a record     *)
  fname: string;                     (* name of the function         *)
  formals: string list;              (* list of formal params        *)
  locals: string list;               (* local variables              *)
  body: stmt list;                   (* the body of the function     *)
};;


(* a program is comprised of list of strings i.e. 
   global declarations and a list of function declarations *)
type program = string list * func_decl list;;
