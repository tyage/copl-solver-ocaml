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
Exercise 3.1 [必修課題]
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
Exercise 3.2 [**]
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

### Ex3.3

```
Exercise 3.3 [*]
論理値演算のための二項演算子 &&, || を追加せよ．
```

`&&` と `||` が AND と OR としてparseされるよう、 `parser.mly` と `lexer.mll` を変更する.

```diff
--- a/interpreter/lexer.mll
+++ b/interpreter/lexer.mll
@@ -24,6 +22,8 @@ rule main = parse
 | "+" { Parser.PLUS }
 | "*" { Parser.MULT }
 | "<" { Parser.LT }
+| "&&" { Parser.AND }
+| "||" { Parser.OR }
```

```diff
--- a/interpreter/parser.mly
+++ b/interpreter/parser.mly
@@ -4,7 +4,7 @@ open Syntax

 %token LPAREN RPAREN SEMISEMI
 %token PLUS MULT LT
-%token IF THEN ELSE TRUE FALSE
+%token IF THEN ELSE TRUE FALSE AND OR
```

その後、And, Orをparseした場合に `eval.ml` のBinOpに渡され、BinOp内で正しく動作するようにする.

この際、式中の演算での優先順位は、ORが一番低く次にANDが来るようになるように注意する.

```diff
--- a/interpreter/parser.mly
+++ b/interpreter/parser.mly
@@ -18,6 +18,14 @@ toplevel :

 Expr :
     IfExpr { $1 }
+  | OrExpr { $1 }
+
+OrExpr :
+    AndExpr OR AndExpr { BinOp(Or, $1, $3) }
+  | AndExpr { $1 }
+
+AndExpr :
+    LTExpr AND LTExpr { BinOp(And, $1, $3) }
```

```diff
--- a/interpreter/eval.ml
+++ b/interpreter/eval.ml
@@ -23,21 +23,25 @@ let rec apply_prim op arg1 arg2 = match op, arg1, arg2 with
   | Mult, _, _ -> err ("Both arguments must be integer: *")
   | Lt, IntV i1, IntV i2 -> BoolV (i1 < i2)
   | Lt, _, _ -> err ("Both arguments must be integer: <")
+  | And, BoolV b1, BoolV b2 -> BoolV (b1 && b2)
+  | And, _, _ -> err ("Both arguments must be bool: &&")
+  | Or, BoolV b1, BoolV b2 -> BoolV (b1 || b2)
+  | Or, _, _ -> err ("Both arguments must be bool: ||")
```

```diff
--- a/interpreter/syntax.ml
+++ b/interpreter/syntax.ml
@@ -1,7 +1,7 @@
 (* ML interpreter / type reconstruction *)
 type id = string

-type binOp = Plus | Mult | Lt
+type binOp = Plus | Mult | Lt | And | Or
```

### Ex3.4

```
Exercise 3.4 [必修課題]
ML2 インタプリタを作成し，テストせよ．
```

テキストの資料図7に従ってML2インタプリタを作成した.

テストに関しては `test/interpreter.ml` に `let x = 1;;` をテストするコードを作成した.

```ocaml
let test_let =
  let decl = Parser.toplevel Lexer.main (Lexing.from_string "let x = 1;;") in
  let (id, _, v) = Eval.eval_decl Environment.empty decl in
  let check_id _ = assert_equal id "x" in
  let check_val _ = assert_equal (Eval.string_of_exval v) "1" in
  "test let">:::
  ["check id">:: check_id;
  "check val">:: check_val;]
;;
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
