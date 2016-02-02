all:
	corebuild -use-menhir parser.mli
	ocamlbuild -use-menhir -tag thread -use-ocamlfind -quiet -pkg core test.native
