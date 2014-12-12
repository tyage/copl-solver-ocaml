(*
文字を受け取って，アルファベットの小文字なら大文字に，その他の文字はそのまま返す関数capitalize．
(例: capitalize ’h’ ⇒ ’H’, capitalize ’1’ ⇒ ’1’)
*)

let capitalize(c : char) : char =
  if ('a' <= c && c <= 'z') then char_of_int(int_of_char(c) - 32) else c;;
