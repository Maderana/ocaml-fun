all:
	ocamlyacc rpcalc.mly
	ocamlc -c rpcalc.mli
	ocamllex lexer.mll
	ocamlc -c lexer.ml
	ocamlc -c rpcalc.ml
	ocamlc -c main.ml
	ocamlc -o rpcacl lexer.cmo rpcalc.cmo main.cmo
	rm rpcalc.mli lexer.ml rpcalc.ml
