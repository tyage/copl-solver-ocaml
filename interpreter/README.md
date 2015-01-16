# ML interpreter

<http://www.fos.kuis.kyoto-u.ac.jp/~nishida/classes/isle4fp2014/text.pdf>

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

## How to test

```sh
opam install ocamlfind ounit re
make test
```
