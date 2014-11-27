(*
US ドル (実数) を受け取って円 (整数) に換算する関数 (ただし 1 円以下四捨五入)．
(入力は小数点以下 2 桁で終わるときに働けばよい．)
レートは 1$ = 111.12 円とする．
*)

let dollar_to_yen(dollar : float) : int =
  let yen = dollar *. 112.12 in
  let carry = if ((yen -. floor(yen)) > 0.5) then 1 else 0 in
  int_of_float(yen) + carry;;
