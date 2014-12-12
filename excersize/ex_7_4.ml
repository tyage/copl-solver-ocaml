(*
参照を使って階乗関数を定義してみよう．... 部分を埋めよ．
let fact_imp n =
let i = ref n and res = ref 1 in
while (...) do
...;
i := !i - 1
done;
...;;
*)

let fact_imp n =
  let i = ref n and res = ref 1 in
    while (!i > 0) do
    res := !res * !i;
    i := !i - 1
    done;
    !res;;
