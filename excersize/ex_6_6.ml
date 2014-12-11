(*
二分木の左右を反転させた木を返す関数 reflect を定義せよ．
# reflect comptree;;
- : int tree =
Br (1, Br (3, Br (7, Lf, Lf), Br (6, Lf, Lf)),
Br (2, Br (5, Lf, Lf), Br (4, Lf, Lf)))
また，任意の二分木 t に対して成立する，以下の方程式を完成させよ．
preorder(reflect(t)) = ?
inorder(reflect(t)) = ?
postorder(reflect(t)) = ?
*)

type 'a tree = Lf | Br of 'a * 'a tree * 'a tree;;

let comptree = Br(1, Br(2, Br(4, Lf, Lf),
                           Br(5, Lf, Lf)),
                     Br(3, Br(6, Lf, Lf),
                           Br(7, Lf, Lf)));;

let rec reflect = function
  Lf -> Lf
  | Br (value, left, right) -> Br (value, reflect right, reflect left);;
