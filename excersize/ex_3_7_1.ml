let rec pow x n : float =
  if n == 0 then
    1.0
  else
    (pow x n - 1) *. x;;
