all:
	rm *.cm*
	ocamllex lexer.mll
	ocamlyacc parser.mly
	ocamlc -c ast.mli
	ocamlc -c parser.mli
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlc -c main.ml
	ocamlc -o calc lexer.cmo parser.cmo main.cmo
	rm parser.mli lexer.ml parser.ml
