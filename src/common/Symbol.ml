module H = Hashtbl

(** symbol type: name string and hashed name to int *)
type symbol = string * int
[@@deriving show]

(** current unused symbol number *)
let currsymnum = ref 1

(** initial hash size for hash table *)
let init_hash_size = 512

(** hashtable with initial size [init_hash_size] *)
let hashtable: (string, int) H.t = H.create init_hash_size

(** [symbol name] takes a string [name] and returns the used or newly added symbol *)
let symbol name =
  match H.find_opt hashtable name with
    Some num -> (name, num)
  | None -> let num = !currsymnum in
            H.add hashtable name num;
            currsymnum := num + 1;
            (name, num)

(** [name (s,n)] returns the name string [s] of the symbol *)
let name ((s, _): symbol) = s

(** Symbol Table mapping int (obtained from hashed symbol) to value or type binding *)
module SymbolTable = Map.Make(
  struct
    type t = int
    let compare = compare
  end
)

(** Polymorphic Symbol Table type *)
type 'a symboltable = 'a SymbolTable.t

(** Empty Symbol Table *)
let empty = SymbolTable.empty

(** [enter tbl (_, num) bind] returns a new Symbol Table from [tbl] after
    adding or overwriting the mapping [num] -> [bind] *)
let enter (tbl: 'a symboltable) ((_, num): symbol) (bind: 'a): 'a symboltable =
  SymbolTable.add num bind tbl

(** [look tbl (_, num)] returns a binding option of [num]'s mapping in Symbol Table [tbl] *)
let look (tbl: 'a symboltable) ((_, num): symbol): 'a option =
  SymbolTable.find_opt num tbl

(** [mem tbl (_, num)] returns true if [num] has a binding in Symbol Table [tbl] else false *)
let mem (tbl: 'a symboltable) ((_, num): symbol): bool =
  SymbolTable.mem num tbl

(** [remove tbl (_, num)] returns a new Symbol Table from [tbl] after
    removing the mapping [num] -> [bind] *)
let remove (tbl: 'a symboltable) ((_, num): symbol): 'a symboltable  =
  SymbolTable.remove num tbl

(** [map f tbl] returns a new Symbol Table from [tbl] after applying
    [f] to all bindings *)
let map (f: 'a -> 'b) (tbl: 'a symboltable) =
  SymbolTable.map f tbl
