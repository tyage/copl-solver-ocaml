open OUnit;;

let ex_2_6_1 =
  let test1 () = assert_equal (Ex_2_6_1.dollar_to_yen 100.0) 11212 in
  let test2 () = assert_equal (Ex_2_6_1.dollar_to_yen 49.0) 5494 in
  "ex2_6_1">:::
  ["四捨">:: test1;
  "五入">:: test2]
;;

let ex_2_6_2 =
  let test1 () = assert_equal (Ex_2_6_2.yen_to_dollar 10000) 89.19 in
  let test2 () = assert_equal (Ex_2_6_2.yen_to_dollar 10002) 89.21 in
  "ex2_6_1">:::
  ["四捨">:: test1;
  "五入">:: test2]
;;

let ex_2_6_3 =
  let test1 () = assert_equal (Ex_2_6_3.say_yen 100.0) "100. dollars are 11212 yen." in
  let test2 () = assert_equal (Ex_2_6_3.say_yen 49.0) "49. dollars are 5494 yen." in
  "ex2_6_1">:::
  ["四捨">:: test1;
  "五入">:: test2]
;;

let ex_2_6_4 =
  let cap () = assert_equal (Ex_2_6_4.capitalize 'h') 'H' in
  let not_cap () = assert_equal (Ex_2_6_4.capitalize '1') '1' in
  "ex2_6_1">:::
  ["capitalize">:: cap;
  "not capitalize">:: not_cap]
;;

let ex_3_11 =
  let gcd () = assert_equal (Ex_3_11.gcd 35 14) 7 in
  let comb () = assert_equal (Ex_3_11.comb 5 2) 10 in
  let fib () = assert_equal (Ex_3_11.fib_iter 10) 55 in
  let max_ascii () = assert_equal (Ex_3_11.max_ascii "jvDzZe") 'z' in
  "ex2_6_1">:::
  ["gcd">:: gcd;
  "comb">:: comb;
  "fib">:: fib;
  "max_ascii">:: max_ascii]
;;

let _ =
run_test_tt_main ex_2_6_1;
run_test_tt_main ex_2_6_2;
run_test_tt_main ex_2_6_3;
run_test_tt_main ex_2_6_4;
run_test_tt_main ex_3_11;
;;
