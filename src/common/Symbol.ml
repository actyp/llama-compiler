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

(** [enter tbl (_, num) bind] adds or overwrites the mapping [num] -> [bind] in Symbol Table [tbl] *)
let enter (tbl: 'a symboltable) ((_, num): symbol) (bind: 'a): 'a symboltable =
  SymbolTable.add num bind tbl

(** [look tbl (_, num)] returns a binding option of [num]'s mapping in Symbol Table [tbl] *)
let look (tbl: 'a symboltable) ((_, num): symbol): 'a option =
  SymbolTable.find_opt num tbl
