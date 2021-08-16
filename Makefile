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

llama_lex: sanity
	@echo --------Compiling llama_lex-------
	$(OCB) Main_lex.native
	@mv Main_lex.native llama_lex

llama_parse: sanity
	@echo --------Compiling llama_parse-----
	$(OCB) Main_parse.native
	@mv Main_parse.native llama_parse

sanity:
	@echo --------Sanity Check--------
	@echo Ocamlbuild Path: `which ocamlbuild`
	@echo Menhir Path: `which menhir`
