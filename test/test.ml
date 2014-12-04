open OUnit;;

let ex_2_6_1 =
  let test1 () = assert_equal (Ex_2_6_1.dollar_to_yen 100.0) 11212 in
  let test2 () = assert_equal "x" "x" in
  "ex2_6_1">:::
  ["test1">:: test1;
  "test2">:: test2]
;;

let _ =
run_test_tt_main ex_2_6_1
;;
