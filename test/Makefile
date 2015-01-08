.PHONY: test clean

test-exercise: exercise.o
	./exercise.o

test-interpreter: interpreter.o
	./interpreter.o

interpreter.o: interpreter.ml
	cd ../interpreter && make depend && make
	ocamlfind ocamlc -package oUnit -linkpkg -I ../interpreter -g -o $@ syntax.cmo parser.cmo lexer.cmo environment.cmo eval.cmo interpreter.ml

exercise.o: exercise.ml
	ocamlfind ocamlc -package oUnit -linkpkg -I ../exercise -g -o $@ ../exercise/*.ml exercise.ml

clean:
	rm -f *.cm[iox] *.o *.log *.cache
	rm -f ../exercise/*.cm[iox]
