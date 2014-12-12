(*
以下で定義される (’a, ’b) sum 型は，「α 型の値もしくは β 型の値」という和集合的なデータの構成を示す型である．
# type (’a, ’b) sum = Left of ’a | Right of ’b;;
type (’a, ’b) sum = Left of ’a | Right of ’b
# let float_of_int_or_float = function
Left i -> float_of_int i
| Right f -> f;;
val float_of_int_or_float : (int, float) sum -> float = <fun>
# float_of_int_or_float (Right 3.14);;
- : float = 3.14
# float_of_int_or_float (Left 2);;
- : float = 2.
これを踏まえて，次の型をもつ関数を定義せよ．
1. ’a * (’b, ’c) sum -> (’a * ’b, ’a * ’c) sum
2. (’a, ’b) sum * (’c, ’d) sum -> ((’a * ’c, ’b * ’d) sum, (’a * ’d, ’b * ’c) sum) sum
3. (’a -> ’b) * (’c -> ’b) -> (’a, ’c) sum -> ’b
4. ((’a, ’b) sum -> ’c) -> (’a -> ’c) * (’b -> ’c)
5. (’a -> ’b, ’a -> ’c) sum -> (’a -> (’b,’c) sum)
*)

type ('a, 'b) sum = Left of 'a | Right of 'b;;
let float_of_int_or_float = function
  Left i -> float_of_int i
  | Right f -> f;;

(*
1. ’a * (’b, ’c) sum -> (’a * ’b, ’a * ’c) sum
*)
let first (a, bc) =
  match bc with
  Left b -> Left (a, b)
  | Right c -> Right (a, c);;

(*
2. (’a, ’b) sum * (’c, ’d) sum -> ((’a * ’c, ’b * ’d) sum, (’a * ’d, ’b * ’c) sum) sum
*)
let second (ab, cd) =
  match ab, cd with
  Left a, Left c -> Left (Left (a, c))
  | Left a, Right d -> Right (Left (a, d))
  | Right b, Left c -> Right (Right (b, c))
  | Right b, Right d -> Left (Right (b, d));;
