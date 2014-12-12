(*
以下の関数 change は，お金を「くずす」関数である．
# let rec change = function
  (_, 0) -> []
  | ((c :: rest) as coins, total) ->
    if c > total then change (rest, total)
    else c :: change (coins, total - c);;
Warning P: this pattern-matching is not exhaustive.
Here is an example of a value that is not matched:
([], 1)
.................function
  (_, 0) -> []
  | ((c :: rest) as coins, total) ->
    if c > total then change (rest, total)
    else c :: change (coins, total - c)..
val change : int list * int -> int list = <fun>

与えられた (降順にならんだ) 通貨のリスト coins と合計金額 total からコインのリストを返す．
# let us_coins = [25; 10; 5; 1]
  and gb_coins = [50; 20; 10; 5; 2; 1];;
val us_coins : int list = [25; 10; 5; 1]
val gb_coins : int list = [50; 20; 10; 5; 2; 1]
# change (gb_coins, 43);;
- : int list = [20; 20; 2; 1]
# change (us_coins, 43);;
- : int list = [25; 10; 5; 1; 1; 1]
しかし，この定義は先頭にあるコインをできる限り使おうとするため，可能なコインの組合わせがあ
るときにでも失敗してしまうことがある．
# change ([5; 2], 16);;
Exception: Match_failure ("", 201, 17).
これを，例外処理を用いて解がある場合には出力するようにしたい．以下のプログラムの，2 個所の
... 部分を埋め，プログラムの説明を行え．
let rec change = function
  (_, 0) -> []
  | ((c :: rest) as coins, total) ->
    if c > total then change (rest, total)
    else
      (try
        c :: change (coins, total - c)
        with Failure "change" -> ...)
  | _ -> ...;;
*)

let rec change = function
  (_, 0) -> []
  | ((c :: rest) as coins, total) ->
    if c > total then change (rest, total)
    else
      (try
        c :: change (coins, total - c)
        with Failure "change" -> change(rest, total))
  | _ -> raise (Failure "change");;
