# Llama Compiler

## Contents

* [Contributors](#Contributors)
* [Llama Language](#Llama-Language)
* [Prerequisites](#Prerequisites)
* [Setup](#Setup)
* [Usage](#Usage)
* [Design & Implementation](#Design--Implementation)
  * [Lexer](#Lexer)
  * [Parser](#Parser)
  * [Semantic Analyzer](#Semantic-Analyzer)
    * [Type Inference](#Type-Inference)
    * [Typed AST Generation](#Typed-AST-Generation)
  * [Llvm IR Generator](#Llvm-IR-Generator)
    * [A-Conversion](#A-Conversion)
    * [Escape Analysis](#Escape-Analysis)
    * [Llvm IR Generation](#Llvm-IR-Generation)
  * [Assembler](#Assembler)
  * [Linker](#Linker)

--------

## Contributors
* [actyp](https:://github.com/actyp)
* [m0x41n](https://github.com/m0x41n)

## Llama Language
`Llama` is a relatively simple programming language, which combines features from functional and imperative programming. It is a subset of `Ocaml` language and it's main characteristics are the following:

1. Strong type system with type inference
2. Basic datatypes for int, char, bool, float
3. Mutable variables (references) and multi-dimensional arrays
4. User-defined datatypes, which can be recursive too
5. Higher-order functions, without partial application. Parameter passing by value
6. Predefined library functions

## Prerequisites
 * [opam](https://opam.ocaml.org/)
 * [llvm](https://llvm.org/)
 * [clang](https://clang.llvm.org/)
 
## Setup
Having installed `opam`, `clang` and `llvm` to your system the next step is to create the development environment using `opam`

1. Initialize opam
```bash
# this can be skipped, if already done
opam init
```

2. Create a new switch (recommended)
```bash
# update, if needed, to obtain the latest compiler
opam update

# create switch named 'llama-compiler' using the latest ocaml compiler
opam switch create llama-compiler ocaml-base-compiler

# if prompted 'enable' switch with this command
eval $(opam env)
```

3. Install opam packages
```bash
# optional packages generally useful for development purposes
opam install utop odoc ounit2 qcheck bisect_ppx ocaml-lsp-server ocamlformat ocamlformat-rpc

# packages needed for compilation of the project
opam install ocamlbuild menhir ppx_deriving llvm 
```

4. Update and upgrade the packages if needed
```bash
# update package repositories
opam update

# perform the upgrade of packages
opam upgrade
```

5. Perform sanity check and compile
```bash
# git clone this repo and cd into it, if not already done so

# perform sanity check to ensure everything is correctly set up
make sanity

# sanity check is made before every compilation
make
```

> On **successful** compilation `./_build/` directory and `./llamac` are produced. `./llamac` is just a softlink to `./_build/src/Main.native` which is the binary file for the compiler. It is typical for the ocamlbuild ecosystem to keep all generated files under `./_build/` directory and have outside links to the binaries included. In order to **remove** `./_build/` directory and `./llamac` run **`make clean`**


## Usage
```
./llamac [-flag] [--option] filename[.ext]

Default behaviour is to produce three files:
  - filename.imm     the generated Llvm IR
  - filename.asm     the generated assembly
  - filename.out     the generated binary
  > '.ext' should not be one of those above
  
Flags & Options:  
  -O                 Llvm IR Optimization flag
  -i                 Output of Llvm IR to std_out
  -f                 Output of assembly to std_out
  --lex              Lexical analysis only
  --parse            Parsing and printing AST only
  --infer            Printing type-inferred AST only
  -help              Display this list of options
  --help             Display this list of options
```

> In case `filename[.ext]` is of the format: `path/to/dir/name.lla` then `filename = path/to/dir/name` and `.ext = .lla`

> These are mutually exclusive (only one is allowed): `-i`, `-f`, `--lex`, `--parse`, `--infer`

## Design & Implementation

### Lexer
---
`Lexer` reads character sequences in the provided file, trying to find input patterns called `lexemes`, that are represented internally by a corresponding `token`. This `token` is later provided to the parser. In case of an invalid token, it is reported and compilation stops. For this project `ocamllex lexer` is used. `Lexer` file can be found at [**`src/parsing/Lexer.mll`**](./src/parsing/Lexer.ml)

### Parser
---
`Parser` takes the sequence of `tokens` provided by the lexer and tries to match a subsequence of `tokens` with it's own recognizable patterns. The correct matching is translated into a node of the `AST` (abstract syntax tree). If a subsequence of tokens cannot be matched (parsed correctly) then `syntax error` occurs and compilation stops.
For this project `menhir parser` is used. `Parser` and `AST` files can be found at [**`src/parsing/Parser`**](./src/parsing/Parser.ml) and [**`src/utils/Ast.ml`**](./src/utils/Ast.ml)

### Semantic Analyzer
---
After the successful creation of the `AST`, is time to check it for semantic errors. Besides other fields, the `AST` nodes carry a type of the represented value. Because type annotation is optional in Llama, some nodes of the AST have empty types. Before the semantic error checking can occur, the types must be correctly filled (inferred). In other words, the `AST` is semi-typed ast, meaning that it's nodes may or may not have type information, but after `type inference` another fully-typed ast is generated and used, which is called `TAST` and holds type information for every node

#### Type Inference
---
Type inference takes as input the `AST`, a starting value environment `venv` of predefined functions and an empty type environment `tenv` and outputs a substitution table `subst_tbl` containing the types corresponding to `AST's` nodes. In the project type inference is implemented in three phases `annotation`, `constraint` and `unify`. These are analyzed below, regarding an example `a = b + 1`:

1. `Annotation` phase traverses the `AST` assigning to each node with no type a temporal type. These types are of the format ``` `t<num>```, like ``` `t42``` and act as a type placeholder for the actual types to be found. This way the `AST` becomes 'annotated ast'. In the above example `1` is not annotated, because it has type `int`, `b` is annotated with type ``` `t1``` and `a` is annotated with type ``` `t2```. Some semantic errors are caught in this phase. The `annotation` file can be found at [**`src/semant/Annotate.ml`**](./src/semant/Annotate.ml)

2. `Constraint` phase traverses the `annotated ast` and creates type constraints that occur out of the relation of each node with it's children nodes. In the above example knowing that `+` operator has type `int -> int -> int` the generated constraints are that `b` has type `int` and `1` has type `int` and `a` has type `int`, being the result of the operation. Actually in order to represent these constraints a temporal ast is generated, called `ConstraintTree`. No error is caught in this phase. The `constraint` and `constraint tree` files can be found at [**`src/semant/Constraint.ml`**](./src/semant/Constraint.ml) and [**`src/semant/ConstraintTree.ml`**](./src/semant/ConstraintTree.ml)

3. `Unify` phase traverses the newly generated `ConstraintTree`, tries to unify the types that each node carries as a constraint and outputs the generated substitution table `subst_tbl`. The `subst_tbl` contains the inferred types of almost-all temporal types. In the above example first type `int` of `1` is trivially unified with type `int`, type ``` `t1``` of `b` is unified with type `int` and an association ``` `t1 -> int``` is created in `subst_tbl` and type ``` `t2``` of `a` is unified with type `int` and an association ``` `t2 -> int``` is created in `subst_tbl`. Many errors are caught in this phase that are practically type checking errors. The `unify` file can be found at [**`src/semant/Unify.ml`**](./src/semant/Unify.ml)

#### Typed AST Generation
---
This phase can also be called `substitute` phase. Having the original `AST` and `subst_tbl` the next step is to traverse the `AST` and whenever a node with a temporal type is encountered, this type is substituted with it's binding in `subst_tbl` and a new node of `TAST` is generated. In case a temporal type has no binding in `subst_tbl` that means the value is not used in the program in a way a type can be inferred, so it remains the same in `TAST` and a warning is produced. While traversing the `AST`and substituting types, some semantic errors can be caught. The result of this phase is the `TAST` containing all the possible type information that could be inferred. The `substitute` file can be found at [**`src/semant/Substitute.ml`**](./src/semant/Substitute.ml)

> Examples of errors caught in each phase can be found at the [**`examples/errors`**](./examples/errors) directory

### Llvm IR Generator
---
After the successful semantic analysis there is a fully typed `TAST` to be traversed and Llvm IR to be generated. This is also implemented in three phases `A-Conversion`, `Escape Analysis` and `Llvm IR Generation`

#### A-Conversion
---
In the program may be many occurences of variables that have the same name, but differ with each other. This `A-Conversion` phase traverses the `TAST` and produces a new `TAST`, but each symbol has a unique name, in order to simplify processing in later phases. This way there is no longer need for symbol table and different scopes, because there is no name conflicts. The `A-Conversion` file can be found at [**`src/intermediate/AConversion.ml`**](./src/intermediate/AConversion.ml)

#### Escape Analysis
---
The `escape analysis` phase traverses the a-converted `TAST` in order to produce an `info_tbl`. This `info_tbl` contains information about every `function`, it's `local` and `escape` variables. Those variables are contained also in the `info_tbl`. `Escape` variables are also called `free` variables and are these variables, which escape their definition level and are used in nested levels. An example is when a nested function uses a variable defined in their parent function, then this variable is an escaping variable. The `Escape Analysis` file can be found at [**`src/intermediate/Escape.ml`**](./src/intermediate/Escape.ml)


> **Important** is to mention that for homogeniety reasons there is an implicit outer function `main` which wraps the definition level 0. This way all 'global' variables are either `local` or `escape` variables of this function `main`. This function is the entry point of the program and is already introduced in `escape analysis` and provided information for it in the `info_tbl`


#### Llvm IR Generation
---
The `Llvm IR Generation` phase traverses the a-converted `TAST` and having information about the functions and their variables it produces the Llvm IR. Some important points will be mentioned. The notion of nested functions, which access the `escape` variables of their parent function is implemented with **`function frames`** and **`display array`**. A `function frame` is a stack-allocated struct containing all the `escape` variables of a function. A `display array` is an array of `function frames` with size **max_function_nesting_depth**, in which when a function that is defined at nesting depth `nd` is called, this called function stores a pointer to it's `function frame` in `display array` at index `nd`, saving the old pointer in the array in it's stack and restoring it back before exiting. Another point worth mentioning is the **garbage collection** in the runtime. This provides a `garbage-collected` heap, in which to allocate memory using function `GC_malloc`. This memory will be deallocated when not needed anymore. Only arrays are allocated in `non-garbage-collected` heap using `malloc`, because of a found misbehaviour that is resolved this way. Actually, array pointers are stored in structs, which are allocated in `garbage-collected` heap and before deallocation of these structs function `free` is called in order to deallocate manually the previously allocated array in `non-garbage-collected` heap. Finally there are the external function to be declared, in order to be used in runtime. There are also caught some runtime errors. The output of this phase will be either to `std_out` or to the `filename.imm`. The `Llvm IR Generation` file can be found at [**`src/intermediate/IRCodegen.ml`**](./src/intermediate/IRCodegen.ml)


### Assembler
---
The assembling phase reads Llvm IR code from `filename.imm` and compiles it into assembly language generating the `filename.asm` without linking yet. This way assembly is still readable. In case assembly requested to `std_out` with the command-line flag `-f`, then files `filename.imm` and `filenam.asm` are generated, but removed after printing the assembly to `std_out`. The default behaviour of `llamac` is to keep those two generated files. For the assembling `llc` already installed in the system is used. The command call can be found at [**`src/Main.ml`**](./src/Main.ml)

### Linker
---
Final stage is link the `filename.asm` file with the static runtime libraries used. The first library is `libgc.a`, which contains the functions used for garbage collection. The second library is `liblla.a`, which contains the library functions tha llama provides. Specifically these are implemented in C and compiled into the static library `liblla.a`. Note that in linking phase `liblla.a` library needs also `libm` (math library), because `math.h` is used in `external_functions.c`. The final output is `filename.out`, which is a binary file. Libraries can be found at [**`src/runtime`**](./src/runtime) directory. The command call can be found at [**`src/Main.ml`**](./src/Main.ml)

> The process to create the `liblla.a` static library follows
```bash
# cd into runtime dir
cd src/runtime

# compile .c file
clang -c external_functions.c

# bundle .o file with name liblla.a
ar -cvq liblla.a external_functions.o
```

> Examples of programs and generated files can be found at [**`examples/programs`**](./examples/programs) directory
