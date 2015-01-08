open Syntax
open Eval

let eval_print env lexer showError =
  (try
    let decl = Parser.toplevel Lexer.main lexer in
    let (id, newenv, v) = eval_decl env decl in
      Printf.printf "val %s = " id;
      pp_val v;
      print_newline();
      newenv
    with Failure str -> showError str
    | Eval.Error str -> showError str
    | Parsing.Parse_error -> showError "parse error"
    | _ -> showError "Other Exception")

let rec read_eval_print env =
  print_string "# ";
  flush stdout;
  let showError str = Printf.printf "%s" str;
    print_newline();
    read_eval_print env in
  let newenv = eval_print env (Lexing.from_channel stdin) showError in
  read_eval_print newenv

let file_eval_print filename env =
  let showError str = Printf.printf "%s" str;
    print_newline();
    env in
  eval_print env (Lexing.from_channel (open_in filename)) showError

let initial_env =
  Environment.extend "i" (IntV 1)
    (Environment.extend "ii" (IntV 2)
      (Environment.extend "iii" (IntV 3)
        (Environment.extend "iv" (IntV 4)
          (Environment.extend "v" (IntV 5)
             (Environment.extend "x" (IntV 10) Environment.empty)))))

let _ =
  if (Array.length Sys.argv) > 1 then file_eval_print Sys.argv.(1) initial_env
  else read_eval_print initial_env
