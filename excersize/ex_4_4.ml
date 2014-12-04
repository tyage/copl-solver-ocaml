(*
Exercise 4.4 以下の関数 curry は，与えられた関数をカリー化する関数である．
# let curry f x y = f (x, y);;
val curry : (’a * ’b -> ’c) -> ’a -> ’b -> ’c = <fun>
# let average (x, y) = (x +. y) /. 2.0;;
val average : float * float -> float = <fun>
# let curried_avg = curry average;;
val curried_avg : float -> float -> float = <fun>
# average (4.0, 5.3);;
- : float = 4.65
# curried_avg 4.0 5.3;;
- : float = 4.65
この逆，つまり (2 引数の) カリー化関数を受け取り，二つ組を受け取る関数に変換する uncurry 関
数を定義せよ．
# let avg = uncurry curried_avg in
  avg (4.0, 5.3);;
- : float = 4.65
*)

let curry f x y = f (x, y);;
let average (x, y) = (x +. y) /. 2.0;;
let curried_avg = curry average;;

let uncurry f pair =
  let (x, y) = pair in f x y;;

let avg = uncurry curried_avg in
  avg (4.0, 5.3);;
