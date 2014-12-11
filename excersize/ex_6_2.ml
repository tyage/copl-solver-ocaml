(*
nat 型の値をそれが表現する int に変換する関数 int_of_nat, nat 上の掛け算を行う
関数 mul，nat 上の引き算を行う関数 (ただし 0 − n = 0) monus (モーナス) を定義せよ．
(mul, monus は *, - などの助けを借りず，nat 型の値から「直接」計算するようにせよ．)
*)

type nat = Zero | OneMoreThan of nat;;
let zero = Zero and two = OneMoreThan (OneMoreThan Zero);;

let rec int_of_nat = function
  Zero -> 0
  | OneMoreThan n -> 1 + (int_of_nat n);;

let rec add m n =
  match m with
  Zero -> n
  | OneMoreThan m' -> OneMoreThan (add m' n);;

let rec mul m n =
  match m with
  Zero -> Zero
  | OneMoreThan m' -> add n (mul m' n);;

let monus _ = Zero;;
