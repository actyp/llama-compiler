module A = Ast
module S = Symbol
module T = Types

type ty_symboltable = T.ty S.symboltable
let tenv: ty_symboltable = S.empty

type constraint = Con_Equal of T.ty * T.ty

let compare_constraint (Con_Equal (t1, t2)) (Con_Equal (t3, t4)) =
  let eq = (t1 = t3) && (t2 = t4) in
  let eq_rev = (t1 = t4) && (t2 = t3) in
  if eq || eq_rev
  then 0
  else -1

module ConstraintSet = Set.Make(
  struct
    type t = constraint
    let compare = compare_constraint
  end
)
let emptyConSet = ConstraintSet.empty

let infer_program (p: Ast.program) = List.map infer_def p

and infer_def = function
  | A.LetDef { recur_opt; decs; pos } -> A.LetDef { recur_opt = recur_opt; decs = List.map infer_dec d; pos = pos }
  | A.TypeDef { tdecs = tds; pos = pos } -> A.TypeDef { tdecs = tds; pos = pos }

and infer_dec = function
  | A.ConstVarDec { name_sym = ns; ty_opt: topt; value = v; pos = pos } -> A.ConstVarDec { name_sym = ns; ty_opt: topt; value = v; pos = pos }
  | _ -> failwith "TODO"

let lookup_sym (tenv: ty_symboltable) (sym: S.symbol) pos =
  match S.look tenv sym with
    | Some t -> t
    | None -> Error.fatal "Unbound variable" ^ S.name sym

let infer_expr tenv expr = match expr with
  | A.E_ID  { name_sym; pos } -> (Ty (lookup_sym tenv name_sym pos), emptyConSet)
  | A.E_CID { name_sym; pos } -> (Ty (lookup_sym tenv name_sym pos), emptyConSet)
  | A.E_Int _    -> (Ty T.INT, emptyConSet)
  | A.E_Float _  -> (Ty T.FLOAT, emptyConSet)
  | A.E_Char _   -> (Ty T.CHAR, emptyConSet)
  | A.E_String _ -> (Ty (T.ARRAY (T.CHAR, ref ())), emptyConSet)
  | A.E_True _   -> (Ty T.BOOL, emptyConSet)
  | A.E_False _  -> (Ty T.BOOL, emptyConSet)
  | A.E_Unit _   -> (Ty T.UNIT, emptyConSet)
