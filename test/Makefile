.PHONY: test clean

test: test.bin
	./test.bin

test.bin: test.ml
	ocamlfind ocamlc -package oUnit -linkpkg -I ../exercise -g -o $@ ../exercise/*.ml test.ml

clean:
	rm -f *.cm[iox] test.bin
	rm -f ../exercise/*.cm[iox]
