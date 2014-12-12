type token =
  | LPAREN
  | RPAREN
  | SEMISEMI
  | PLUS
  | MULT
  | LT
  | IF
  | THEN
  | ELSE
  | TRUE
  | FALSE
  | INTV of (int)
  | ID of (Syntax.id)

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
open Syntax
# 21 "parser.ml"
let yytransl_const = [|
  257 (* LPAREN *);
  258 (* RPAREN *);
  259 (* SEMISEMI *);
  260 (* PLUS *);
  261 (* MULT *);
  262 (* LT *);
  263 (* IF *);
  264 (* THEN *);
  265 (* ELSE *);
  266 (* TRUE *);
  267 (* FALSE *);
    0|]

let yytransl_block = [|
  268 (* INTV *);
  269 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\004\000\004\000\005\000\005\000\006\000\
\006\000\007\000\007\000\007\000\007\000\007\000\003\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\003\000\001\000\003\000\001\000\003\000\
\001\000\001\000\001\000\001\000\001\000\003\000\006\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\011\000\012\000\010\000\013\000\
\016\000\000\000\002\000\003\000\000\000\000\000\009\000\000\000\
\000\000\001\000\000\000\000\000\000\000\014\000\000\000\000\000\
\000\000\008\000\000\000\000\000\015\000"

let yydgoto = "\002\000\
\009\000\010\000\011\000\012\000\013\000\014\000\015\000"

let yysindex = "\003\000\
\001\255\000\000\001\255\001\255\000\000\000\000\000\000\000\000\
\000\000\004\255\000\000\000\000\255\254\014\255\000\000\007\255\
\002\255\000\000\005\255\005\255\005\255\000\000\001\255\014\255\
\017\255\000\000\018\255\001\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\036\255\020\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\028\255\
\038\255\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\253\255\000\000\000\000\013\000\016\000\021\000"

let yytablesize = 47
let yytable = "\016\000\
\017\000\003\000\019\000\001\000\020\000\003\000\018\000\004\000\
\022\000\023\000\005\000\006\000\007\000\008\000\005\000\006\000\
\007\000\008\000\021\000\027\000\019\000\007\000\007\000\007\000\
\029\000\007\000\028\000\007\000\007\000\006\000\006\000\006\000\
\025\000\006\000\024\000\006\000\006\000\005\000\005\000\004\000\
\004\000\026\000\000\000\005\000\005\000\004\000\004\000"

let yycheck = "\003\000\
\004\000\001\001\004\001\001\000\006\001\001\001\003\001\007\001\
\002\001\008\001\010\001\011\001\012\001\013\001\010\001\011\001\
\012\001\013\001\005\001\023\000\004\001\002\001\003\001\004\001\
\028\000\006\001\009\001\008\001\009\001\002\001\003\001\004\001\
\020\000\006\001\019\000\008\001\009\001\002\001\003\001\002\001\
\003\001\021\000\255\255\008\001\009\001\008\001\009\001"

let yynames_const = "\
  LPAREN\000\
  RPAREN\000\
  SEMISEMI\000\
  PLUS\000\
  MULT\000\
  LT\000\
  IF\000\
  THEN\000\
  ELSE\000\
  TRUE\000\
  FALSE\000\
  "

let yynames_block = "\
  INTV\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'Expr) in
    Obj.repr(
# 17 "parser.mly"
                  ( Exp _1 )
# 116 "parser.ml"
               : Syntax.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'IfExpr) in
    Obj.repr(
# 20 "parser.mly"
           ( _1 )
# 123 "parser.ml"
               : 'Expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'LTExpr) in
    Obj.repr(
# 21 "parser.mly"
           ( _1 )
# 130 "parser.ml"
               : 'Expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'PExpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'PExpr) in
    Obj.repr(
# 24 "parser.mly"
                   ( BinOp (Lt, _1, _3) )
# 138 "parser.ml"
               : 'LTExpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'PExpr) in
    Obj.repr(
# 25 "parser.mly"
          ( _1 )
# 145 "parser.ml"
               : 'LTExpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'PExpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'MExpr) in
    Obj.repr(
# 28 "parser.mly"
                     ( BinOp (Plus, _1, _3) )
# 153 "parser.ml"
               : 'PExpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'MExpr) in
    Obj.repr(
# 29 "parser.mly"
          ( _1 )
# 160 "parser.ml"
               : 'PExpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'MExpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'AExpr) in
    Obj.repr(
# 32 "parser.mly"
                     ( BinOp (Mult, _1, _3) )
# 168 "parser.ml"
               : 'MExpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'AExpr) in
    Obj.repr(
# 33 "parser.mly"
          ( _1 )
# 175 "parser.ml"
               : 'MExpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 36 "parser.mly"
         ( ILit _1 )
# 182 "parser.ml"
               : 'AExpr))
; (fun __caml_parser_env ->
    Obj.repr(
# 37 "parser.mly"
         ( BLit true )
# 188 "parser.ml"
               : 'AExpr))
; (fun __caml_parser_env ->
    Obj.repr(
# 38 "parser.mly"
          ( BLit false )
# 194 "parser.ml"
               : 'AExpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Syntax.id) in
    Obj.repr(
# 39 "parser.mly"
       ( Var _1 )
# 201 "parser.ml"
               : 'AExpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'Expr) in
    Obj.repr(
# 40 "parser.mly"
                       ( _2 )
# 208 "parser.ml"
               : 'AExpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'Expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Expr) in
    Obj.repr(
# 43 "parser.mly"
                                ( IfExp (_2, _4, _6) )
# 217 "parser.ml"
               : 'IfExpr))
(* Entry toplevel *)
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
let toplevel (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Syntax.program)
