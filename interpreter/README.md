# ML interpreter

<http://www.fos.kuis.kyoto-u.ac.jp/~nishida/classes/isle4fp2014/text.pdf>

## How to test

```sh
opam install ocamlfind ounit re
make test
```

## Solved exercises

- Ex3.1 [必修]
- Ex3.2 [**]
- Ex3.3 [*]
- Ex3.4 [必修]
- Ex3.6 [**]
- Ex3.8 [必修]
- Ex3.14 [必修]
- Ex4.1 [必修]
- Ex4.2 [必修]
- Ex4.3 [必修]
- Ex4.4 [必修]
- Ex4.5 [必修]
- Ex4.6 [必修]

### Ex3.1

```
ML1 インタプリタのプログラムをコンパイル・実行し，インタプリタの動作を確かめよ．
大域環境として i, v, x の値のみが定義されているが，ii が 2，iii が 3，iv が 4 となるようにプログラムを変更して，動作を確かめよ．例えば，
iv + iii * ii
などを試してみよ．
```

大域変数を以下のように変更する.

```ocaml
let initial_env =
  Environment.extend "i" (IntV 1)
    (Environment.extend "ii" (IntV 2)
      (Environment.extend "iii" (IntV 3)
        (Environment.extend "iv" (IntV 4)
          (Environment.extend "v" (IntV 5)
             (Environment.extend "x" (IntV 10) Environment.empty)))))
```

`iv + iii * ii` を実行した結果、 `10` が返ってきた.

### Ex3.2

```
Exercise 3.2
このインタプリタは文法にあわない入力を与えたり，束縛されていない変数を参照しようとすると，プログラムの実行が終了してしまう．
このような入力を与えた場合，適宜メッセージを出力して，インタプリタプロンプトに戻るように改造せよ．
```

プログラムを実行した際にエラーを受け取ったらメッセージを出力してインタプリタプロンプトに戻るように、
`try with` 構文で例外を受け取った際の処理を加えればよい.

`main.ml` の `read_eval_print` を以下のように変更する.

```ocaml
let rec read_eval_print env =
  print_string "# ";
  flush stdout;
  let showError str = Printf.printf "%s" str;
    print_newline();
    read_eval_print env in
  (try
      let decl = Parser.toplevel Lexer.main (Lexing.from_channel stdin) in
      let (id, newenv, v) = eval_decl env decl in
        Printf.printf "val %s = " id;
        pp_val v;
        print_newline();
        read_eval_print newenv
      with Failure str -> showError str
      | Eval.Error str -> showError str
      | Parsing.Parse_error -> showError "parse error"
      | _ -> showError "Other Exception")
```

### Ex4.5

```
単一化アルゴリズムにおいて，α ̸∈ FTV(τ) という条件はなぜ必要か考察せよ．
```

aとτが異なり、FTV(τ)にαが含まれている場合としては例えば以下のような場合が考えられる

```
(TyVar a, TyFun (TyVar a, TyInt))
```

もし単一化アルゴリズムにおいて上記の条件がない場合、aの型が `TyFun (TyVar a, TyInt)` となるが、aが自身の型を内包するため型が無限に展開される

そのため、上記の条件をつけることにより、自身の型を含み無限展開される再帰的な型を生成しないようにしていると考えられる
