open Ast

module NameMap = Map.Make(String);;

(* symbol table for variables; map from variables names to values *)
(* string -> int *)
type vsymtable = int NameMap.t;;

(* execution environment: local vars * global vars *)
type env = vsymtable * vsymtable;;

(* used to handle the return statement; value * global vars *)
exception ReturnException of int * vsymtable;;

(* the function that starts the execution. takes variables
   and function decls as input*)
let run ((vars, funcs): program) =

  (* Step 1: build up a list of func decls. 
     This gives a map of func name -> func decl record *)
  let func_decls : (func_decl NameMap.t) = 
    List.fold_left (fun funcs fdecl -> NameMap.add fdecl.fname fdecl funcs)
      NameMap.empty funcs
  in

  (* This is how a function defined in the program gets called. It takes three 
     arguments: the function decl record, the list of actuals (all evaluated) and 
     a symbol table representing the global variables. 
     A function call finally returns an updated symbol table that refers to the new 
     global variables *)
  let rec call (fdecl: func_decl) (actuals: int list) (globals: vsymtable) : vsymtable = 

    (* Expressiosn are evaluated in an environment context -i.e. a pair of local and global
       vars. The final output of each expression is an int (the only defined type in our 
       language) and a new environment *)
    let rec eval (env: env) (exp: expr) : int * env = match exp with
      | Literal(i) -> i, env                                                (* return i, no change in env *)
      | Noexpr -> 1, env                                                    (* return 1, no change in env. the 1 means this is true *)
      | Call("print", [e]) ->                                               (* handle the print function differently. just takes one arg e *)
        let v, env = eval env e in print_endline (string_of_int v); 
        0, env
      | Id(var) -> (let locals, globals = env in                            (* look for the var first in locals, then in globals *)
        if NameMap.mem var locals
        then (NameMap.find var locals), env
        else if NameMap.mem var globals
        then (NameMap.find var globals), env
        else raise (Failure ("undeclared identifier " ^ var)))              (* raise exception if not found anywhere *)
      | Binop(e1, op, e2) ->                                                (* eval a binary operation. simple stuff *)
        let v1, env = eval env e1 in
        let v2, env = eval env e2 in
        let boolean i = if i then 1 else 0 in
        let v = (match op with
         | Add     -> v1 + v2
         | Sub     -> v1 - v2
         | Mult    -> v1 * v2
         | Div     -> v1 / v2
         | Equal   -> boolean(v1 = v2)
         | Neq     -> boolean(v1 != v2)
         | Geq     -> boolean(v1 >= v2)
         | Greater -> boolean(v1 > v2)
         | Leq     -> boolean(v1 <= v2)
         | Less    -> boolean(v1 < v2)) in
        v, env
      | Assign (var , e) ->
        let v, (locals, globals) = eval env e in                             (* calculate the value of the expression *)
        if NameMap.mem var locals 
        then v, (NameMap.add var v locals, globals)                          (* if the var already exists in locals, get a new map with new value *)
        else if NameMap.mem var globals
        then v, (locals, NameMap.add var v globals)                          (* else see if it exists in globals, and do the same *)
        else raise (Failure ("undeclared identifier: " ^ var))               (* else raise exception *)
      | Call((f: string), (actuals: Ast.expr list)) ->                       (* handle a function call *)
        (* first off, we go and look for the function declaration
           that has a name f *)
        let fdecl = 
          try NameMap.find f func_decls 
          with Not_found -> raise (Failure ("undefined function: " ^ f))
        in
        (* we then go ahead and evaluate each actual argument one by one *)
        let actuals, env = 
          List.fold_left 
            (fun (actuals, env) actual -> 
               let v, env = eval env actual in v :: actuals, env)
            ([], env)
            (List.rev actuals)
        in
        (* finally we call the function and see if the function returns anything
           If it doesn't (e.g. print) we simply return the updated locals and globals
           *)
        let (locals, globals) = env in 
        try
          let globals = call fdecl actuals globals
          in 0, (locals, globals)
        with
          ReturnException (v, globals) -> v, (locals, globals)
    in

    (* execute a statement and return an updated environment *)
    let rec exec (env: env) (stmt: Ast.stmt) : env =
      match stmt with
      | Block(stmts) -> List.fold_left exec env stmts          (* execute each stmt in block *)
      | Expr(e) -> let _, env = eval env e in env              (* eval an expr. keep only its env *)
      | If(e, s1, s2) -> let v, env = eval env e in
        exec env (if v != 0 then s1 else s2)                   (* execute stmt s1 / s2 depending on true / false *)
      | While(e, stmt) -> 
        let rec loop env = 
          (* eval the e, and exec s while e is true *)
          let v, env = eval env e in 
          if v != 0 then loop (exec env stmt) else env
        in loop env
      | For(e1, e2, e3, stmt) ->
        (* eval first expr, discard value *)
        let _, env = eval env e1 in 
        let rec loop env =
          (* inside the loop, check the predicate - e2 *)
          let v, env = eval env e2 in
          if v != 0  (* true *)
          then (* if true, then first exec the stmt, then run e3 
                  and finally pass on the updated env to the next call *)
            let e = exec env stmt in
            let _, env = eval e e3 in loop env 
          else env
        in loop env
      | Return(e) -> let v, (locals, globals) = eval env e in
        raise (ReturnException(v, globals))
    in

    (* enter the function: bind actual values to formal arguments *)
    let locals =
      try List.fold_left2
        (fun locals formal actual -> NameMap.add formal actual locals)
        NameMap.empty fdecl.formals actuals
      with Invalid_argument(_) -> 
        raise (failwith("wrong number of arguments passed to " ^ fdecl.fname))
    in
    (* initialize local variables to 0 *)
    let locals = List.fold_left
        (fun locals local -> NameMap.add local 0 locals) 
        locals fdecl.locals
    in
    (* execute each statement in sequence, return updated global symbol table *)
    snd (List.fold_left exec (locals, globals) fdecl.body)
  in
  let globals = List.fold_left 
   (fun globals vdecl -> NameMap.add vdecl 0 globals) NameMap.empty vars
  in 
  try 
    call (NameMap.find "main" func_decls) [] globals
  with 
    Not_found -> raise (Failure ("did not find the main() function"))
;;


let _ = 
  let filename = Sys.argv.(1) in
  let lexbuf = Lexing.from_channel (open_in filename) in
  let program = Parser.program Lexer.token lexbuf in
  run program
;;
