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

val toplevel :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Syntax.program
