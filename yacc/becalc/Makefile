all:
	ocamllex lexer.mll
	ocamlyacc parser.mly
	ocamlc -c ast.mli
	ocamlc -c parser.mli
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlfind ocamlc -c tests.ml -package oUnit -linkpkg -g
	ocamlfind ocamlc -o tests -package oUnit -linkpkg -g lexer.cmo parser.cmo tests.cmo
