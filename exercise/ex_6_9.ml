(*
関数 sift を定義し，< 自分の学籍番号 + 3000 > 番目の素数を求めよ．
*)

type 'a seq = Cons of 'a * (unit -> 'a seq);;
let rec from n = Cons (n, fun () -> from (n + 1));;
let head (Cons (x, _)) = x;;
let tail (Cons (_, f)) = f ();;
let rec take n s =
  if n = 0 then [] else head s :: take (n - 1) (tail s);;

let rec shift n (Cons (x, t)) =
  let tail_seq = t () in
  if (x mod n) = 0 then
    (Cons (head tail_seq, fun() -> shift n (tail tail_seq)))
  else
    (Cons (x, fun() -> shift n tail_seq));;

let prime n =
  let rec prime_seq (Cons (x, f)) = Cons (x, fun() -> prime_seq (shift x (f ()))) in
  let rec take_last n s = if n = 1 then head s else take_last (n - 1) (tail s) in
  take_last n (prime_seq (from 2));;
