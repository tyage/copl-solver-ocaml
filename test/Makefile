.PHONY: test clean

test: exercise.o
	./exercise.o

exercise.o: exercise.ml
	ocamlfind ocamlc -package oUnit -linkpkg -I ../exercise -g -o $@ ../exercise/*.ml exercise.ml

clean:
	rm -f *.cm[iox] *.o *.log *.cache
	rm -f ../exercise/*.cm[iox]
