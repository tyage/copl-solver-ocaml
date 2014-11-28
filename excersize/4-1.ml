(*
実数上の関数 f に対して ∫ b, a f(x)dx を計算する関数 integral f a b を定義せよ．
またこれを使って，∫ π, 0 sin x dx を計算せよ．
近似的な計算方法として，ここでは台形近似を説明するが他の方法でも良い．
台形公式では b − a を n 分割した区間の長さを δ として，台形の集まりとして 計算する．
i 番目の区間の台形の面積は(f (a + (i − 1) δ) + f (a + iδ)) · δ / 2 として求められる．
*)

let integral f a b =
  let n = 1000 in
  let s = (b -. a) /. float_of_int(n) in
  let rec iter i sum =
    if i = n then
      sum
    else
      iter (i + 1) (sum +. ((f (a +. float_of_int(i - 1) *. s)) +. (f (a +. float_of_int(i) *. s))) *. s /. 2.0)
  in iter 0 0.0;;

let pi = 4.0 *. atan 1.0 in
integral sin 0.0 pi;;
