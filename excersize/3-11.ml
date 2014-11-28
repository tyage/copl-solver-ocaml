(*
1. Euclid の互除法で二整数の最大公約数を求める関数 gcd.
*)

let rec gcd m n =
  if n = 0 then
    m
  else
    gcd n (m mod n);;

(*
2. テキストの再帰的な定義で (n m)を求める関数 comb．
*)

let rec comb n m =
  if m = 0 || m = n then
    1
  else
    (comb (n - 1) m) + (comb (n - 1) (m - 1));;

(*
3. 末尾再帰的関数を使ってフィボナッチ数を計算する fib_iter．(fib_pair を元にするとよい．)
*)

let rec fib_pair n =
  if n = 1 then (0, 1)
  else
    let (prev, curr) = fib_pair (n - 1) in (curr, curr + prev);;

let fib_iter n =
  let rec iter n (prev, curr) =
    if n = 1 then curr
    else iter (n - 1) (curr, prev + curr)
  in iter n (0, 1);;

(*
4. 与えられた文字列のなかで ASCII コードが最も大きい文字を返す max_ascii 関数
文字列から文字を取出す方法は 2.2.5 節を参照のこと．
(この問題は意図的に「なにかが足りない」ように設定してあります．
欲しい機能・関数があればマニュアルを調べたり，プログラム上で工夫してください．)
*)

let max_ascii str =
  let rec iter max i =
    if String.length str == i then
      max
    else if max < str.[i] then
      iter str.[i] (i + 1)
    else
      iter max (i + 1)
  in iter str.[0] 0
