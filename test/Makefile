.PHONY: test clean

test: test.bin
	./test.bin

test.bin: test.ml
	ocamlfind ocamlc -package oUnit -linkpkg -I ../excersize -g -o $@ ../excersize/*.ml test.ml

clean:
	rm *.cmo *.cmi *.cmx test.bin
