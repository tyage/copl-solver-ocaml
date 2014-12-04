(*
円 (整数) を受け取って，US ドル (セント以下を小数にした実数) に換算する関数 (ただし 1 セント以下四捨五入)．
レートは 1$ = 111.12 円とする．
*)

let yen_to_dollar(yen : int) : float =
  let dollar = float_of_int(yen) /. 112.12 *. 100.0 in
  floor(dollar +. 0.5) /. 100.0;;
