all:
	ocamlyacc parser.mly
	ocamlc -c ast.mli
	ocamlc -c parser.mli
	ocamllex lexer.mll
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlc -c interpret.ml
	ocamlc -o microc.out lexer.cmo parser.cmo interpret.cmo

clean:
	rm *.cmo *.cmi
	rm parser.mli lexer.ml parser.ml
