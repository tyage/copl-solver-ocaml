(*
1. 正の整数 n から 0 までの整数の降順リストを生成する関数 downto0．
*)
let rec downto0 n =
  if n = -1 then [] else n :: downto0 (n - 1);;

(*
2. 与えられた正の整数のローマ数字表現 (文字列) を求める関数 roman．
(I = 1, V = 5, X = 10, L = 50, C = 100, D = 500, M = 1000 である．)
ただし，roman はローマ数字の定義も引数として受け取ることにする．
ローマ数字定義は，単位となる数とローマ数字表現の組を大きいものから並べたリストで表現する．
例えばroman [(1000, "M"); (500, "D"); (100, "C"); (50, "L"); (10, "X"); (5, "V"); (1, "I")] 1984
=⇒ "MDCCCCLXXXIIII"
4, 9, 40, 90, 400, 900 などの表現にも注意して，
roman [(1000, "M"); (900, "CM"); (500, "D"); (400, "CD"); (100, "C"); (90, "XC");
(50, "L"); (40, "XL"); (10, "X"); (9, "IX"); (5, "V"); (4, "IV"); (1, "I")] 1984
=⇒ "MCMLXXXIV"
となるようにせよ．
*)


(*
3. 与えられたリストのリストに対し，内側のリストの要素を並べたリストを返す関数 concat．
concat [[0; 3; 4]; [2]; [5; 0]; []] = [0; 3; 4; 2; 5; 0]
*)
let rec concat = function
  [] -> []
  | head :: rest_list -> match head with
    [] -> (concat rest_list)
    | x :: rest_elem -> x :: (concat (rest_elem :: rest_list));;

(*
4. 二つのリスト [a1; ...; an] と [b1; ...; bn] を引数として，[(a1, b1); ...; (an, bn)]
を返す関数 zip．(与えられたリストの長さが異なる場合は長いリストの余った部分を捨ててよい．)
*)
let rec zip a b =
  match a, b with
  _, [] -> []
  | [], _ -> []
  | head_a :: rest_a, head_b :: rest_b -> (head_a, head_b) :: (zip rest_a rest_b);;

(*
5. リストと，リストの要素上の述語 ( bool 型を返す関数) p をとって，p を満たす全ての要素のリストを返す関数 filter．
# let positive x = (x > 0);;
val positive : int -> bool = <fun>
# filter positive [-9; 0; 2; 5; -3];;
- : int list = [2; 5]
# filter (fun l -> length l = 3) [[1; 2; 3]; [4; 5]; [6; 7; 8]; [9]];;
- : int list list = [[1; 2; 3]; [6; 7; 8]]
*)
let rec filter f l =
  match l with
  [] -> []
  | head :: rest -> if f head then head :: (filter f rest) else (filter f rest);;

(*
6. リストを集合とみなして，以下の集合演算をする関数を定義せよ．
(a) belong a s で a が s の要素かどうかを判定する関数 belong．
(b) intersect s1 s2 で s1 と s2 の共通部分を返す関数 intersect．
(c) union s1 s2 で s1 と s2 の和を返す関数 union．
(d) diff s1 s2 で s1 と s2 の差を返す関数 diff．
但し，集合なので，要素は重複して現れてはならないことに気をつけよ．(関数の引数には重複
してないものが与えられるという仮定を置いてもよい．)
*)
