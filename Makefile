.PHONY: clean sanity

default: llama

OCB_FLAGS = -use-ocamlfind -use-menhir -Is src,src/parsing,src/semant,src/common
OCB = ocamlbuild $(OCB_FLAGS)

clean:
	$(OCB) -clean

llama: sanity
	@echo --------Compiling llama-----------
	$(OCB) Main.native
	@mv Main.native llama

sanity:
	@echo --------Sanity Check--------
	@echo Ocamlbuild Path: `which ocamlbuild`
	@echo Menhir Path: `which menhir`
	@echo ppx_deriving package: `opam show ppx_deriving | grep 'version '`
