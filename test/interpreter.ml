open OUnit2;;

let test_let =
  let decl = Parser.toplevel Lexer.main (Lexing.from_string "let x = 1;;") in
  let (id, newenv, v) = Eval.eval_decl Environment.empty decl in
  let check_id _ = assert_equal id "x" in
  let check_val _ = assert_equal (Eval.string_of_exval v) "1" in
  "test let">:::
  ["check id">:: check_id;
  "check val">:: check_val;]
;;

let test_fun =
  let decl = Parser.toplevel Lexer.main (Lexing.from_string "let x = fun y -> y + 1 in x 4;;") in
  let (id, newenv, v) = Eval.eval_decl Environment.empty decl in
  let check_id _ = assert_equal id "-" in
  let check_val _ = assert_equal (Eval.string_of_exval v) "5" in
  "test fun">:::
  ["check id">:: check_id;
  "check val">:: check_val;]
;;

let _ =
  run_test_tt_main test_let;
  run_test_tt_main test_fun;
;;
