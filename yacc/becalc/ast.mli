type expr = 
  | And of expr * expr
  | Or of expr * expr
  | Neg of expr
  | Var of string
  | Const of bool
