open Ast

module NameMap = Map.Make(String);;

(* symbol table for variables; map from variables names to values *)
(* string -> int *)
type vsymtable = int NameMap.t;;

(* execution environment: local vars * global vars *)
type env = vsymtable * vsymtable;;

(* used to handle the return statement; value * global vars *)
exception ReturnException of int * vsymtable;;

let run ((vars, funcs): program) : unit = 
  (* build up a list of func decls *)
  let func_decls : (func_decl NameMap.t) = 
    List.fold_left (fun funcs fdecl -> NameMap.add fdecl.fname fdecl funcs)
      NameMap.empty funcs
  in

  (* invoke a function and return an updated global symbol table *)
  let rec call (fdecl: func_decl) (actuals: int list) (globals: vsymtable) : vsymtable = 

    (* evaluate expressions *)
    let rec eval (env: env) (exp: expr) : int * env = match exp with
      | Literal(i) -> i, env
      | Noexpr -> 1, env
      | Call("print", [e]) -> 
        let v, env = eval env e in print_endline (string_of_int v); 0, env
      | Id(var) -> 
        let locals, globals = env in
        if NameMap.mem var locals
        then (NameMap.find var locals), env
        else if NameMap.mem var globals, env
        then (NameMap.find var globals), env
        else raise (failwith "Undeclared identifier : " ^ var)
      | Binop(e1, op, e2) ->
        let v1, env = eval env e1 and v2, env = eval env e2 in
        let boolean i = if i then 1 else 0 in
        (match op with
         | Add -> v1 + v2
         | Sub -> v1 - v2
         | Mult -> v1 * v2
         | Div -> v1 / v2
         | Equal -> boolean(v1 = v2)
         | Neq -> boolean(v1 != v2)
         | Gte -> boolean(v1 >= v2)
         | Gt  -> boolean(v1 > v2)
         | Lte -> boolean(v1 <= v2)
         | Lt  -> boolean(v1 < v2)
         | Assign (var , e) ->
           let v, (locals, globals) = eval env e in
           if NameMap.mem var locals 
           then v, (NameMap.add var v locals, globals)
           else if NameMap.mem var globals
           then v, (locals, NameMap.add var v globals)
           else raise (failwith "undeclared identifier: " ^ var))
      | Call(f, actuals) ->
        let fdecl = 
          try NameMap.find f func_decls 
          with Not_found -> raise (failwith "undefined function: " ^ f)
        in
        let ractuals, env = 
          List.fold_left 
            (fun (actuals, env) actual -> let v, env = eval env actual in v :: actuals, env)
            ([], env)
            (List.rev actuals)
        in
        let (locals, globals) = env in 
        try
          let globals = call fdecl actuals globals
          in 0, (locals, globals)
        with
          ReturnException (v, globals) -> v, (locals, globals)
    in

    (* execute a statement and return an updated environment *)
    let rec exec env = function
      | Block(stmts) -> List.fold_left exec env stmts 
      | Expr(e) -> let _, env = eval env e in env 
      | If(e, s1, s2) -> let v, env = eval env e in
        exec env (if v != 0 then s1 else s2)
      | While(e, s) -> 
        let rec loop env = 
          let v, env = eval env e in 
          if v != 0 then loop (exec env v) else env
        in loop env
      | For(e1, e2, e3, s) ->
        let _, env = eval env e1 in
        let rec loop env =
          let v, env = eval env e2 in
          if v != 0  (* true *)
          then let _, env = eval (exec env v) e3 in
            loop env 
          else
            env
        in loop env
      | Return(e) -> let v, (locals, globals) = eval env e in
        raise (ReturnException(e, globals))
    in

