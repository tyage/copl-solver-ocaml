let dollar_to_yen(dollar : float) : int =
  let yen = dollar *. 112.12 in
  let carry = if ((yen -. floor(yen)) > 0.5) then 1 else 0 in
  int_of_float(yen) + carry;;
