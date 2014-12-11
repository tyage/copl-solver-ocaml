(*
Exercise 5.4 f, g を適当な型の関数とする．
map f (map g l) を map を一度しか使用しない同じ意味の式に書き換えよ．
map (fun x -> ...) l の ... 部分は?
*)

let rec map f = function
  [] -> []
  | x :: rest -> f x :: map f rest;;

let f n = (n, n);;
let g n = n + 1;;

let answer l = map (fun x -> f (g x)) l;;
