(** symbol type: name string and int mapping *)
type symbol = string * int

(** [symbol name] takes a string [name] and returns the used or newly added symbol *)
val symbol : string -> symbol

(** [pp_symbol fmt sym] pretty prints symbol [sym] with formatter [fmt] *)
val pp_symbol : Format.formatter -> symbol -> unit

(** [name (s,n)] returns the name string [s] of the symbol *)
val name : symbol -> string

(** Polymorphic Symbol Table type *)
type 'a symboltable

(** Empty Symbol Table *)
val empty : 'a symboltable

(** [enter tbl (_, num) bind] returns a new Symbol Table from [tbl] after
    adding or overwriting the mapping [num] -> [bind] *)
val enter : 'a symboltable -> symbol -> 'a -> 'a symboltable

(** [look tbl (_, num)] returns a binding option of [num]'s mapping in Symbol Table [tbl] *)
val look : 'a symboltable -> symbol -> 'a option

(** [mem tbl (_, num)] returns true if [num] has a binding in Symbol Table [tbl] else false *)
val mem : 'a symboltable -> symbol -> bool

(** [remove tbl (_, num)] returns a new Symbol Table from [tbl] after
    removing the mapping [num] -> [bind] *)
val remove : 'a symboltable -> symbol -> 'a symboltable
