let yen_to_dollar(yen : int) : float =
  let dollar = float_of_int(yen) /. 112.12 *. 100.0 in
  let carry = if ((dollar -. floor(dollar)) > 0.5) then 1 else 0 in
  (floor(dollar) +. float_of_int(carry)) /. 100.0;;
