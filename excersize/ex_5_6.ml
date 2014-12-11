(*
Exercise 5.6 quick 関数を @ を使わないように書き換える．
quicker は未ソートのリスト l と，sorted というソート済でその要素の最小値が l の要素の最大値より大きいようなリストを受け取る．
定義を完成させよ．
let rec quicker l sorted = ...
*)

let rec append l1 l2 =
  match l1 with
  [] -> l2
  | x :: rest -> x :: (append rest l2);;

let rec quicker l sorted =
  match l with
  [] -> sorted
  | [x] -> x :: sorted
  | x :: xs ->
    let rec partition left right = function
    [] -> (append (quicker left []) (x :: quicker right sorted))
    | y :: ys -> if x < y then partition left (y :: right) ys
      else partition (y :: left) right ys in
    partition [] [] xs;;
