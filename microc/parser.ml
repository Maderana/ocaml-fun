type token =
  | LBRACE
  | RBRACE
  | COMMA
  | SEMICOLON
  | LPAREN
  | RPAREN
  | PLUS
  | MINUS
  | MULTIPLY
  | DIVIDE
  | NEQ
  | EQ
  | GT
  | LT
  | GTE
  | LTE
  | ASSIGN
  | IF
  | ELSE
  | WHILE
  | FOR
  | RETURN
  | INT
  | EOF
  | LITERAL of (int)
  | ID of (string)

open Parsing;;
let _ = parse_error;;
# 1 "parser.mly"
 open Ast 
# 34 "parser.ml"
let yytransl_const = [|
  257 (* LBRACE *);
  258 (* RBRACE *);
  259 (* COMMA *);
  260 (* SEMICOLON *);
  261 (* LPAREN *);
  262 (* RPAREN *);
  263 (* PLUS *);
  264 (* MINUS *);
  265 (* MULTIPLY *);
  266 (* DIVIDE *);
  267 (* NEQ *);
  268 (* EQ *);
  269 (* GT *);
  270 (* LT *);
  271 (* GTE *);
  272 (* LTE *);
  273 (* ASSIGN *);
  274 (* IF *);
  275 (* ELSE *);
  276 (* WHILE *);
  277 (* FOR *);
  278 (* RETURN *);
  279 (* INT *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  280 (* LITERAL *);
  281 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\004\000\005\000\005\000\008\000\
\008\000\006\000\006\000\003\000\007\000\007\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\011\000\011\000\010\000\
\010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
\010\000\010\000\010\000\010\000\010\000\010\000\012\000\012\000\
\013\000\013\000\000\000"

let yylen = "\002\000\
\002\000\000\000\002\000\002\000\008\000\000\000\001\000\001\000\
\003\000\000\000\002\000\003\000\000\000\002\000\002\000\003\000\
\003\000\005\000\007\000\009\000\005\000\000\000\001\000\001\000\
\001\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\004\000\003\000\000\000\001\000\
\001\000\003\000\002\000"

let yydefred = "\000\000\
\002\000\000\000\043\000\000\000\000\000\001\000\000\000\003\000\
\004\000\000\000\000\000\012\000\008\000\000\000\000\000\000\000\
\000\000\010\000\009\000\000\000\011\000\000\000\013\000\005\000\
\000\000\000\000\000\000\000\000\000\000\024\000\000\000\014\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\015\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\017\000\038\000\000\000\000\000\
\000\000\000\000\016\000\000\000\000\000\000\000\000\000\000\000\
\000\000\028\000\029\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\037\000\000\000\000\000\021\000\
\000\000\000\000\000\000\000\000\019\000\000\000\000\000\020\000"

let yydgoto = "\002\000\
\003\000\004\000\008\000\009\000\014\000\020\000\022\000\015\000\
\032\000\033\000\058\000\061\000\062\000"

let yysindex = "\002\000\
\000\000\000\000\000\000\001\000\241\254\000\000\012\255\000\000\
\000\000\032\255\015\255\000\000\000\000\042\255\047\255\062\255\
\051\255\000\000\000\000\057\255\000\000\036\255\000\000\000\000\
\004\255\076\255\078\255\079\255\004\255\000\000\253\254\000\000\
\207\255\044\255\232\255\004\255\004\255\004\255\220\255\004\255\
\004\255\000\000\004\255\004\255\004\255\004\255\004\255\004\255\
\004\255\004\255\004\255\004\255\000\000\000\000\243\255\254\255\
\020\000\081\255\000\000\020\000\061\255\083\255\020\000\063\255\
\063\255\000\000\000\000\030\000\030\000\254\254\254\254\254\254\
\254\254\087\255\087\255\004\255\000\000\004\255\084\255\000\000\
\092\255\020\000\087\255\004\255\000\000\094\255\087\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\098\255\000\000\000\000\000\000\100\255\000\000\
\000\000\000\000\000\000\069\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\110\255\000\000\
\000\000\000\000\000\000\000\000\000\000\106\255\000\000\109\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\071\255\000\000\000\000\041\255\000\000\123\255\029\255\124\255\
\138\255\000\000\000\000\044\000\048\000\152\255\166\255\180\255\
\194\255\000\000\000\000\106\255\000\000\000\000\077\255\000\000\
\000\000\049\255\000\000\127\255\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\114\000\000\000\000\000\000\000\120\000\000\000\
\212\255\231\255\214\255\000\000\000\000"

let yytablesize = 316
let yytable = "\035\000\
\006\000\040\000\001\000\039\000\043\000\044\000\045\000\046\000\
\025\000\010\000\055\000\056\000\057\000\041\000\060\000\063\000\
\011\000\064\000\065\000\066\000\067\000\068\000\069\000\070\000\
\071\000\072\000\073\000\030\000\031\000\079\000\080\000\036\000\
\036\000\081\000\036\000\012\000\023\000\024\000\085\000\013\000\
\025\000\086\000\088\000\041\000\023\000\053\000\041\000\016\000\
\025\000\017\000\057\000\042\000\082\000\026\000\042\000\027\000\
\028\000\029\000\057\000\030\000\031\000\026\000\018\000\027\000\
\028\000\029\000\077\000\030\000\031\000\013\000\013\000\045\000\
\046\000\013\000\023\000\019\000\023\000\018\000\018\000\005\000\
\036\000\018\000\037\000\038\000\076\000\078\000\013\000\023\000\
\013\000\013\000\013\000\025\000\013\000\013\000\018\000\084\000\
\018\000\018\000\018\000\087\000\018\000\018\000\083\000\006\000\
\026\000\007\000\027\000\028\000\029\000\022\000\030\000\031\000\
\025\000\025\000\039\000\025\000\025\000\025\000\025\000\025\000\
\025\000\025\000\025\000\025\000\025\000\025\000\026\000\026\000\
\040\000\026\000\026\000\026\000\022\000\021\000\026\000\026\000\
\026\000\026\000\026\000\026\000\027\000\027\000\034\000\027\000\
\027\000\027\000\000\000\000\000\027\000\027\000\027\000\027\000\
\027\000\027\000\034\000\034\000\000\000\034\000\000\000\000\000\
\000\000\000\000\034\000\034\000\034\000\034\000\034\000\034\000\
\032\000\032\000\000\000\032\000\000\000\000\000\000\000\000\000\
\032\000\032\000\032\000\032\000\032\000\032\000\035\000\035\000\
\000\000\035\000\000\000\000\000\000\000\000\000\035\000\035\000\
\035\000\035\000\035\000\035\000\033\000\033\000\000\000\033\000\
\000\000\000\000\000\000\000\000\033\000\033\000\033\000\033\000\
\033\000\033\000\042\000\000\000\000\000\043\000\044\000\045\000\
\046\000\047\000\048\000\049\000\050\000\051\000\052\000\059\000\
\000\000\000\000\043\000\044\000\045\000\046\000\047\000\048\000\
\049\000\050\000\051\000\052\000\000\000\054\000\043\000\044\000\
\045\000\046\000\047\000\048\000\049\000\050\000\051\000\052\000\
\074\000\043\000\044\000\045\000\046\000\047\000\048\000\049\000\
\050\000\051\000\052\000\075\000\043\000\044\000\045\000\046\000\
\047\000\048\000\049\000\050\000\051\000\052\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\005\000\
\000\000\007\000\043\000\044\000\045\000\046\000\047\000\048\000\
\049\000\050\000\051\000\052\000\043\000\044\000\045\000\046\000\
\000\000\000\000\049\000\050\000\051\000\052\000\031\000\031\000\
\000\000\031\000\030\000\030\000\000\000\030\000\031\000\031\000\
\000\000\000\000\030\000\030\000"

let yycheck = "\025\000\
\000\000\005\001\001\000\029\000\007\001\008\001\009\001\010\001\
\005\001\025\001\036\000\037\000\038\000\017\001\040\000\041\000\
\005\001\043\000\044\000\045\000\046\000\047\000\048\000\049\000\
\050\000\051\000\052\000\024\001\025\001\074\000\075\000\003\001\
\004\001\076\000\006\001\004\001\001\001\002\001\083\000\025\001\
\005\001\084\000\087\000\003\001\001\001\002\001\006\001\006\001\
\005\001\003\001\076\000\003\001\078\000\018\001\006\001\020\001\
\021\001\022\001\084\000\024\001\025\001\018\001\001\001\020\001\
\021\001\022\001\006\001\024\001\025\001\001\001\002\001\009\001\
\010\001\005\001\004\001\025\001\006\001\001\001\002\001\023\001\
\005\001\005\001\005\001\005\001\004\001\003\001\018\001\001\001\
\020\001\021\001\022\001\005\001\024\001\025\001\018\001\004\001\
\020\001\021\001\022\001\006\001\024\001\025\001\019\001\006\001\
\018\001\006\001\020\001\021\001\022\001\004\001\024\001\025\001\
\003\001\004\001\006\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\003\001\004\001\
\006\001\006\001\007\001\008\001\006\001\020\000\011\001\012\001\
\013\001\014\001\015\001\016\001\003\001\004\001\023\000\006\001\
\007\001\008\001\255\255\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\003\001\004\001\255\255\006\001\255\255\255\255\
\255\255\255\255\011\001\012\001\013\001\014\001\015\001\016\001\
\003\001\004\001\255\255\006\001\255\255\255\255\255\255\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\003\001\004\001\
\255\255\006\001\255\255\255\255\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\003\001\004\001\255\255\006\001\
\255\255\255\255\255\255\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\004\001\255\255\255\255\007\001\008\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\004\001\
\255\255\255\255\007\001\008\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\255\255\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\013\001\014\001\015\001\016\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\023\001\
\255\255\025\001\007\001\008\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\007\001\008\001\009\001\010\001\
\255\255\255\255\013\001\014\001\015\001\016\001\003\001\004\001\
\255\255\006\001\003\001\004\001\255\255\006\001\011\001\012\001\
\255\255\255\255\011\001\012\001"

let yynames_const = "\
  LBRACE\000\
  RBRACE\000\
  COMMA\000\
  SEMICOLON\000\
  LPAREN\000\
  RPAREN\000\
  PLUS\000\
  MINUS\000\
  MULTIPLY\000\
  DIVIDE\000\
  NEQ\000\
  EQ\000\
  GT\000\
  LT\000\
  GTE\000\
  LTE\000\
  ASSIGN\000\
  IF\000\
  ELSE\000\
  WHILE\000\
  FOR\000\
  RETURN\000\
  INT\000\
  EOF\000\
  "

let yynames_block = "\
  LITERAL\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'decls) in
    Obj.repr(
# 30 "parser.mly"
              ( _1 )
# 254 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 36 "parser.mly"
                    ( [], [] )
# 260 "parser.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'decls) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl) in
    Obj.repr(
# 37 "parser.mly"
                  ( (_2 :: fst _1), snd _1 )
# 268 "parser.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'decls) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'fdecl) in
    Obj.repr(
# 38 "parser.mly"
                  ( fst _1, (_2 :: snd _1) )
# 276 "parser.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'formal_opt) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl_list) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 42 "parser.mly"
                                                                   (
        { fname = _1;
          formals = _3;
          locals = _6;
          body = List.rev _7; }
    )
# 291 "parser.ml"
               : 'fdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 52 "parser.mly"
                    ( [] )
# 297 "parser.ml"
               : 'formal_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formal_list) in
    Obj.repr(
# 53 "parser.mly"
                  ( List.rev _1 )
# 304 "parser.ml"
               : 'formal_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 57 "parser.mly"
         ( [_1] )
# 311 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'formal_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 58 "parser.mly"
                           ( _3 :: _1 )
# 319 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 62 "parser.mly"
                    ( [] )
# 325 "parser.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'vdecl_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl) in
    Obj.repr(
# 63 "parser.mly"
                       ( _2 :: _1 )
# 333 "parser.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 67 "parser.mly"
                     ( _2 )
# 340 "parser.ml"
               : 'vdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 74 "parser.mly"
                    ( [] )
# 346 "parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 75 "parser.mly"
                     ( _2 :: _1 )
# 354 "parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 78 "parser.mly"
                     ( Expr(_1) )
# 361 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 79 "parser.mly"
                            ( Return(_2) )
# 368 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 80 "parser.mly"
                              ( Block(List.rev _2) )
# 375 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 81 "parser.mly"
                                              ( If(_3, _5, Block([])) )
# 383 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 82 "parser.mly"
                                           ( If(_3, _5, _7) )
# 392 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 6 : 'expr_opt) in
    let _5 = (Parsing.peek_val __caml_parser_env 4 : 'expr_opt) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'expr_opt) in
    let _9 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 84 "parser.mly"
        ( For(_3, _5, _7, _9) )
# 402 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 85 "parser.mly"
                                    ( While(_3, _5) )
# 410 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 88 "parser.mly"
                    ( Noexpr )
# 416 "parser.ml"
               : 'expr_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 89 "parser.mly"
           ( _1 )
# 423 "parser.ml"
               : 'expr_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 96 "parser.mly"
                       ( Literal(_1) )
# 430 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 97 "parser.mly"
                       ( Id(_1) )
# 437 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 98 "parser.mly"
                       ( Binop(_1, Add,   _3) )
# 445 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 99 "parser.mly"
                       ( Binop(_1, Sub,   _3) )
# 453 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 100 "parser.mly"
                          ( Binop(_1, Mult,  _3) )
# 461 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 101 "parser.mly"
                       ( Binop(_1, Div,   _3) )
# 469 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 102 "parser.mly"
                       ( Binop(_1, Equal, _3) )
# 477 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 103 "parser.mly"
                       ( Binop(_1, Neq,   _3) )
# 485 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 104 "parser.mly"
                       ( Binop(_1, Less,  _3) )
# 493 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 105 "parser.mly"
                       ( Binop(_1, Leq,   _3) )
# 501 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 106 "parser.mly"
                       ( Binop(_1, Greater,  _3) )
# 509 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 107 "parser.mly"
                       ( Binop(_1, Geq,   _3) )
# 517 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 108 "parser.mly"
                       ( Assign(_1, _3) )
# 525 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'actuals_opt) in
    Obj.repr(
# 109 "parser.mly"
                                   ( Call(_1, _3) )
# 533 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 110 "parser.mly"
                         ( _2 )
# 540 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 113 "parser.mly"
                    ( [] )
# 546 "parser.ml"
               : 'actuals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'actuals_list) in
    Obj.repr(
# 114 "parser.mly"
                    ( List.rev _1 )
# 553 "parser.ml"
               : 'actuals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 117 "parser.mly"
            ( [_1] )
# 560 "parser.ml"
               : 'actuals_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'actuals_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 118 "parser.mly"
                               ( _3 :: _1 )
# 568 "parser.ml"
               : 'actuals_list))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.program)
