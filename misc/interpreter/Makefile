all:
	ocamllex scanner.mll
	ocamlyacc parser.mly
	ocamlc -c ast.mli
	ocamlc -c parser.mli
	ocamlc -c scanner.ml
	ocamlc -c parser.ml
	ocamlc -c calc.ml
	ocamlc -o calc parser.cmo scanner.cmo calc.cmo

clear:
	rm parser.ml ast.cmi scanner.cmi scanner.ml scanner.cmo
	rm calc.cmi calc.cmo parser.cmi parser.cmo parser.mli 
