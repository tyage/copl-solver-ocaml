open OUnit2;;

let check_id_of_program program id =
  let decl = Parser.toplevel Lexer.main (Lexing.from_string program) in
  let (i, _, _) = Eval.eval_decl Environment.empty decl in
    assert_equal i id
;;

let check_value_of_program program value =
  let decl = Parser.toplevel Lexer.main (Lexing.from_string program) in
  let (_, _, v) = Eval.eval_decl Environment.empty decl in
    assert_equal (Eval.string_of_exval v) value
;;

let check_type_of_program program typ =
  (try
    let tyenv = Environment.empty in
    let decl = Parser.toplevel Lexer.main (Lexing.from_string program) in
    let (s, ty) = Typing.ty_decl tyenv decl in
      assert_equal (Syntax.string_of_ty ty) typ
    with Typing.Error str -> assert_equal str typ
    | _ -> failwith "interpreter error")
;;

let test_let =
  let program = "let x = 1;;" in
  let check_id _ = check_id_of_program program "x" in
  let check_val _ = check_value_of_program program "1" in
  "test let">:::
  ["check_id">:: check_id;
  "check_val">:: check_val;]
;;

let test_fun =
  let program = "let x = fun y -> y + 1 in x 4;;" in
  let check_id _ = check_id_of_program program "-" in
  let check_val _ = check_value_of_program program "5" in
  let high_order_function = "let apply_one = fun f -> f 1 in let plus = fun x -> x + 1 in apply_one plus;;" in
  let check_val_for_high_order_function _ = check_value_of_program high_order_function "2" in
  "test fun">:::
  ["check_id">:: check_id;
  "check_val">:: check_val;
  "check_val_for_high_order_function">:: check_val_for_high_order_function;]
;;

let test_rec_fun =
  let let_rec_exp = "let rec x = fun y -> if y < 1 then 1 else (x (y  + (-1))) * y in x 4;;" in
  let check_id_for_let_rec_exp _ = check_id_of_program let_rec_exp "-" in
  let check_val_for_let_rec_exp _ = check_value_of_program let_rec_exp "24" in
  let rec_decl = "let rec x = fun y -> x 1;;" in
  let check_id_for_rec_decl _ = check_id_of_program rec_decl "x" in
  "test rec fun">:::
  ["check_id_for_let_rec_exp">:: check_id_for_let_rec_exp;
  "check_val_for_let_rec_exp">:: check_val_for_let_rec_exp;
  "check_id_for_rec_decl">:: check_id_for_rec_decl;]
;;

let test_type =
  let test_0 _ = check_type_of_program "1 + 2;;" "int" in
  let test_1 _ = check_type_of_program "-2 * 2;;" "int" in
  let test_2 _ = check_type_of_program "1 < 2;;" "bool" in
  let test_3 _ = check_type_of_program "fun x -> x;;" "'a -> 'a" in
  let test_4 _ = check_type_of_program "fun x -> fun y -> x;;" "'a -> 'b -> 'a" in
  let test_5 _ = check_type_of_program "fun x -> fun y -> y;;" "'a -> 'b -> 'b" in
  let test_6 _ = check_type_of_program "(fun x -> x + 1) 2 + (fun x -> x + -1) 3;;" "int" in
  let test_7 _ = check_type_of_program "fun f -> fun g -> fun x -> g (f x);;" "('a -> 'b) -> ('b -> 'c) -> 'a -> 'c" in
  let test_8 _ = check_type_of_program "fun x -> fun y -> fun z -> x z (y z);;" "('a -> 'b -> 'c) -> ('a -> 'b) -> 'a -> 'c" in
  let test_9 _ = check_type_of_program "fun x -> let y = x + 1 in x;;" "int -> int" in
  let test_10 _ = check_type_of_program "fun x -> let y = x + 1 in y;;" "int -> int" in
  let test_11 _ = check_type_of_program "fun b -> fun x -> if x b then x else (fun x -> b);;" "bool -> (bool -> bool) -> bool -> bool" in
  let test_12 _ = check_type_of_program "fun x -> if true then x else (if x then true else false);;" "bool -> bool" in
  let test_13 _ = check_type_of_program "fun x -> fun y -> if x then x else y;;" "bool -> bool -> bool" in
  let test_14 _ = check_type_of_program "fun n -> (fun x -> x (fun y -> y)) (fun f -> f n);;" "'a -> 'a" in
  let test_15 _ = check_type_of_program "fun x -> fun y -> x y;;" "('a -> 'b) -> 'a -> 'b" in
  let test_16 _ = check_type_of_program "fun x -> fun y -> x (y x);;" "('a -> 'b) -> (('a -> 'b) -> 'a) -> 'b" in
  let test_17 _ = check_type_of_program "fun x -> fun y -> x (y x) (y x);;" "('a -> 'a -> 'b) -> (('a -> 'a -> 'b) -> 'a) -> 'b" in
  let test_18 _ = check_type_of_program "fun x -> fun y -> fun z -> x (z x) (y (z x y));;" "((('a -> 'b) -> 'a) -> 'b -> 'c) -> ('a -> 'b) -> (((('a -> 'b) -> 'a) -> 'b -> 'c) -> ('a -> 'b) -> 'a) -> 'c" in
  let test_19 _ = check_type_of_program "let id = fun x -> x in let f = fun y -> id (y id) in f;;" "(('a -> 'a) -> 'a) -> 'a" in
  let test_20 _ = check_type_of_program "let k = fun x -> fun y -> x in let k1 = fun x -> fun y -> k (x k) in k1;;" "(('a -> 'b -> 'a) -> 'a) -> 'c -> 'b -> 'a" in
  let test_21 _ = check_type_of_program "let s = fun x -> fun y -> fun z -> x z (y z) in let s1 = fun x -> fun y -> fun z -> x s (z s) (y s (z s)) in s1;;" "((('a -> 'b -> 'c) -> ('a -> 'b) -> 'a -> 'c) -> 'd -> 'e -> 'f) -> ((('a -> 'b -> 'c) -> ('a -> 'b) -> 'a -> 'c) -> 'd -> 'e) -> ((('a -> 'b -> 'c) -> ('a -> 'b) -> 'a -> 'c) -> 'd) -> 'f" in
  let test_22 _ = check_type_of_program "let g = fun h -> fun t -> fun f -> fun x -> f h (t f x) in g;;" "'a -> (('a -> 'b -> 'c) -> 'd -> 'b) -> ('a -> 'b -> 'c) -> 'd -> 'c" in
  let test_23 _ = check_type_of_program "let s = fun x -> fun y -> fun z -> x z (y z) in let k = fun x -> fun y -> x in let k' = fun x -> fun y -> x in s k k';;;;" "'a -> 'a" in
  let test_24 _ = check_type_of_program "let s = fun x -> fun y -> fun z -> x z (y z) in let k = fun x -> fun y -> x in s k k;;" "type err" in
  let test_25 _ = check_type_of_program "let s = fun x -> fun y -> fun z -> x z (y z) in let k' = fun x -> fun y -> y in s k' k';;" "type err" in
  let test_26 _ = check_type_of_program "fun x -> fun y -> fun z -> let b = x y z in if b then z y else y;;" "('a -> ('a -> 'a) -> bool) -> 'a -> ('a -> 'a) -> 'a" in
  let test_27 _ = check_type_of_program "let pair = fun x1 -> fun x2 -> fun y -> y x1 x2 in let proj1 = fun p -> p (fun x1 -> fun x2 -> x1) in let proj2 = fun p -> p (fun x1 -> fun x2 -> x2) in proj1 (pair 1 100);;" "int" in
  let test_28 _ = check_type_of_program "let pair = fun x1 -> fun x2 -> fun y -> y x1 x2 in let proj1 = fun p -> p (fun x1 -> fun x2 -> x1) in let proj2 = fun p -> p (fun x1 -> fun x2 -> x2) in proj1 (proj2 (pair 10 (pair 20 30)));;" "type err" in
  let test_29 _ = check_type_of_program "let f = fun x -> x in if f true then f 1 else f 2;;" "type err" in
  let test_30 _ = check_type_of_program "let f = fun x -> 3 in f true + f 4;;;;" "type err" in
  let test_31 _ = check_type_of_program "fun b -> let f = fun x -> x in let g = fun y -> y in if b then f g else g f;;" "type err" in
  let test_32 _ = check_type_of_program "fun b -> fun f -> let g1 = fun x -> x f in let g2 = fun x -> x f in fun z -> if b then g1 z g2 else g2 z g1;;;;" "type err" in
  let test_33 _ = check_type_of_program "1 + true;;" "type err" in
  let test_34 _ = check_type_of_program "2 + (fun x -> x);;" "type err" in
  let test_35 _ = check_type_of_program "-2 * false;;" "type err" in
  let test_36 _ = check_type_of_program "fun x -> x x;;;;" "type err" in
  let test_37 _ = check_type_of_program "let f = fun x -> fun g -> g (x x g) in f f;;" "type err" in
  let test_38 _ = check_type_of_program "let g = fun f -> fun x -> f x (f x) in g;;" "type err" in
  let test_39 _ = check_type_of_program "let g = fun f -> fun x -> f x (x f) in g;;" "type err" in
  let test_40 _ = check_type_of_program "fun x -> fun y -> x y + y x;;" "type err" in
  let test_41 _ = check_type_of_program "fun x -> fun y -> x y + x;;" "type err" in
  let test_42 _ = check_type_of_program "fun x -> fun y -> if x y then x else y;;" "type err" in
  let test_43 _ = check_type_of_program "fun x -> fun y -> if x y then (fun z -> if y z then z else x) else (fun x -> x);;" "type err" in
  let test_44 _ = check_type_of_program "fun x -> fun y -> fun z -> let b = x y z in if b then z y else z x;;" "type err" in
  let test_45 _ = check_type_of_program "fun x -> fun y -> fun z -> if x y then z x else y z;;" "type err" in
  let test_46 _ = check_type_of_program "fun x -> if x then 1 else x;;" "type err" in
  let test_47 _ = check_type_of_program "(fun x -> x + 1) true;;" "type err" in
  let test_48 _ = check_type_of_program "fun x -> fun y -> y (x (y x));;" "type err" in
  let test_49 _ = check_type_of_program "(fun f -> fun x -> f (f x)) (fun x -> fun y -> x);;" "type err" in
  let test_50 _ = check_type_of_program "fun x -> fun y -> y (x (fun z1 -> fun z2 -> z1)) (x (fun z -> z));;" "type err" in
  let test_51 _ = check_type_of_program "fun b -> fun f -> let g1 = fun x -> f x in let g2 = fun x -> f x in if b then g1 g2 else g2 g1;;" "type err" in
  "test type">:::
  ["test_0">:: test_0;
  "test_1">:: test_1;
  "test_2">:: test_2;
  "test_3">:: test_3;
  "test_4">:: test_4;
  "test_5">:: test_5;
  "test_6">:: test_6;
  "test_7">:: test_7;
  "test_8">:: test_8;
  "test_9">:: test_9;
  "test_10">:: test_10;
  "test_11">:: test_11;
  "test_12">:: test_12;
  "test_13">:: test_13;
  "test_14">:: test_14;
  "test_15">:: test_15;
  "test_16">:: test_16;
  "test_17">:: test_17;
  "test_18">:: test_18;
  "test_19">:: test_19;
  "test_20">:: test_20;
  "test_21">:: test_21;
  "test_22">:: test_22;
  "test_23">:: test_23;
  "test_24">:: test_24;
  "test_25">:: test_25;
  "test_26">:: test_26;
  "test_27">:: test_27;
  "test_28">:: test_28;
  "test_29">:: test_29;
  "test_30">:: test_30;
  "test_31">:: test_31;
  "test_32">:: test_32;
  "test_33">:: test_33;
  "test_34">:: test_34;
  "test_35">:: test_35;
  "test_36">:: test_36;
  "test_37">:: test_37;
  "test_38">:: test_38;
  "test_39">:: test_39;
  "test_40">:: test_40;
  "test_41">:: test_41;
  "test_42">:: test_42;
  "test_43">:: test_43;
  "test_44">:: test_44;
  "test_45">:: test_45;
  "test_46">:: test_46;
  "test_47">:: test_47;
  "test_48">:: test_48;
  "test_49">:: test_49;
  "test_50">:: test_50;
  "test_51">:: test_51;]
;;

let _ =
  run_test_tt_main test_let;
  run_test_tt_main test_fun;
  run_test_tt_main test_rec_fun;
  run_test_tt_main test_type;
;;
