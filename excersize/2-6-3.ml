(*
US ドル (実数) を受け取って，文字列 "< ドル > dollars are < 円 > yen." を返す関数．
*)

let dollar_to_yen(dollar : float) : int =
  let yen = dollar *. 112.12 in
  let carry = if ((yen -. floor(yen)) > 0.5) then 1 else 0 in
  int_of_float(yen) + carry;;

let say_yen(dollar : float) : string =
  let yen = dollar_to_yen(dollar) in
  string_of_float(dollar) ^ " dollars are " ^ string_of_int(yen)  ^ " yen."
