(*
7.1.4 節で述べた [] への参照の例を実際にインタラクティブ・コンパイラで試し，
テキストに書いた挙動との違い，特に，参照の型を説明し，どのようにして
true を [1] に cons してしまうような事態の発生が防がれているか説明せよ．
*)

(*
ref []を右辺に代入すると、
「右辺が，参照を生成しないどころか，そもそも計算自体発生するこ
とのない，値であること」
という条件を満たさないため、多相性が許されない。
そのため7.1.4節で説明されるxは以下の様に型が'_aとなる

# let x = ref [];;
val x : '_a list ref = {contents = []}

また、どんなリストでも代入できるわけではなく、はじめに 2 :: !x とするとxはint list refとなる。

# (2:: !x, true :: !x);;
Error: This expression has type int list
but an expression was expected of type bool list
Type int is not compatible with type bool

# 2:: !x;;
- : int list = [2]

# x;;
- : int list ref = {contents = []}

このようにしてtrueを[1]にconsするような事態の発生を防いでいる
*)
