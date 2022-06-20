.PHONY: clean sanity

default: llama

OCB_FLAGS = -use-ocamlfind -Is src,src/parsing,src/semant,src/intermediate,src/utils
OCB = ocamlbuild $(OCB_FLAGS)

define check_installed_opam
	@echo Checking $(1) using opam: `opam list -i --short --columns=name,version $(1)`
	@echo ""
endef

define check_installed_which
	@echo Checking $(1) using which: `which $(1) 2> /dev/null`
	@echo ""
endef

clean:
	$(OCB) -clean

llama: sanity
	@echo --------Compiling llama--------
	$(OCB) Main.native
	@mv Main.native llamac

sanity:
	@echo ""
	@echo --------Sanity Check--------
	@echo \(empty result == unavailable\)
	@echo ""
	@echo Opam path: `which opam`
	@echo Opam version: `opam --version`
	@echo Current opam switch: `opam switch show`
	@echo ""
	$(call check_installed_opam, ocamlbuild)
	$(call check_installed_opam, menhir)
	$(call check_installed_opam, ppx_deriving)
	$(call check_installed_opam, llvm)
	$(call check_installed_which, llc)
	$(call check_installed_which, clang)