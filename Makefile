.PHONY: clean sanity

default: llama

OCB_FLAGS = -use-ocamlfind -use-menhir -I src
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
