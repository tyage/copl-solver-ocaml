open OUnit;;

let ex_2_6_1 =
  let test1 () = assert_equal (Ex_2_6_1.dollar_to_yen 100.0) 11212 in
  let test2 () = assert_equal (Ex_2_6_1.dollar_to_yen 49.0) 5494  in
  "ex2_6_1">:::
  ["四捨">:: test1;
  "五入">:: test2]
;;

let _ =
run_test_tt_main ex_2_6_1
;;
