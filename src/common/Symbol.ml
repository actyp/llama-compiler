module H = Hashtbl

type symbol = string * int
[@@deriving show]

(** current unused symbol number *)
let currsymnum = ref 1

(** initial hash size for hash table *)
let init_hash_size = 512

(** hashtable with initial size [init_hash_size] *)
let hashtable: (string, int) H.t = H.create init_hash_size

let symbol name: symbol =
  match H.find_opt hashtable name with
    Some num -> (name, num)
  | None -> let num = !currsymnum in
            H.add hashtable name num;
            currsymnum := num + 1;
            (name, num)

let name ((s, _): symbol) = s

(** Symbol Table mapping int (obtained from hashed symbol) to value or type binding *)
module SymbolTable = Map.Make(
  struct
    type t = int
    let compare = compare
  end
)

type 'a symboltable = 'a SymbolTable.t

let empty = SymbolTable.empty

let enter (tbl: 'a symboltable) ((_, num): symbol) (bind: 'a): 'a symboltable =
  SymbolTable.add num bind tbl

let look (tbl: 'a symboltable) ((_, num): symbol): 'a option =
  SymbolTable.find_opt num tbl

let mem (tbl: 'a symboltable) ((_, num): symbol): bool =
  SymbolTable.mem num tbl

let remove (tbl: 'a symboltable) ((_, num): symbol): 'a symboltable  =
  SymbolTable.remove num tbl
