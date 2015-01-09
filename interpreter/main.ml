open Syntax
open Eval
open Typing

let eval_print env tyenv lexer showError =
  (try
    let decl = Parser.toplevel Lexer.main lexer in
    let (s, ty) = ty_decl tyenv decl in
    let (id, newenv, v) = eval_decl env decl in
      Printf.printf "val %s : " id;
      pp_ty ty;
      print_string " = ";
      pp_val v;
      print_newline();
      newenv
    with Failure str -> showError str
    | Eval.Error str -> showError str
    | Typing.Error str -> showError str
    | Parsing.Parse_error -> showError "parse error"
    | _ -> showError "Other Exception")

let rec read_eval_print env tyenv =
  print_string "# ";
  flush stdout;
  let showError str = Printf.printf "%s" str;
    print_newline();
    read_eval_print env tyenv in
  let newenv = eval_print env tyenv (Lexing.from_channel stdin) showError in
    read_eval_print newenv tyenv

let file_eval_print filename env tyenv =
  let showError str = Printf.printf "%s" str;
    print_newline();
    env in
    eval_print env tyenv (Lexing.from_channel (open_in filename)) showError

let initial_env =
  Environment.extend "i" (IntV 1)
    (Environment.extend "ii" (IntV 2)
      (Environment.extend "iii" (IntV 3)
        (Environment.extend "iv" (IntV 4)
          (Environment.extend "v" (IntV 5)
             (Environment.extend "x" (IntV 10) Environment.empty)))))

let initial_tyenv =
  Environment.extend "i" TyInt
    (Environment.extend "ii" TyInt
      (Environment.extend "iii" TyInt
        (Environment.extend "iv" TyInt
          (Environment.extend "v" TyInt
            (Environment.extend "x" TyInt Environment.empty)))))

let _ =
  if (Array.length Sys.argv) > 1 then file_eval_print Sys.argv.(1) initial_env initial_tyenv
  else read_eval_print initial_env initial_tyenv
