module H = Hashtbl

type symbol = string * int
[@@deriving show]

exception Symbol
let currsymnum = ref 0
let init_hash_size = 128

let hashtable: (string, int) H.t = H.create init_hash_size

let symbol name =
  match H.find_opt hashtable name with
    Some num -> (name, num)
  | None -> let num = !currsymnum in
            H.add hashtable name num;
            currsymnum := num+1;
            (name, num)

let name ((s, n): symbol) = s

module SymbolTable = Map.Make(
  struct
    type t = int
    let compare = compare
  end
)

type 'a symboltable = 'a SymbolTable.t
let empty = SymbolTable.empty

let enter ((tbl, (s, num), bind): ('a symboltable * symbol * 'a)): 'a symboltable =
  SymbolTable.add num bind tbl

let look ((tbl, (s, num)): ('a symboltable * symbol)): 'a option =
  SymbolTable.find_opt num tbl
