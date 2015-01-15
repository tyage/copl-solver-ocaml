(* ML interpreter / type reconstruction *)
type id = string

type binOp = Plus | Mult | Lt | And | Or

type exp =
    Var of id
  | ILit of int
  | BLit of bool
  | BinOp of binOp * exp * exp
  | IfExp of exp * exp * exp
  | LetExp of id * exp * exp
  | FunExp of id * exp
  | AppExp of exp * exp
  | LetRecExp of id * id * exp * exp

type program =
    Exp of exp
  | Decl of id * exp
  | RecDecl of id * id * exp

type tyvar = int

type ty =
    TyInt
  | TyBool
  | TyVar of tyvar
  | TyFun of ty * ty

let string_of_ty ty =
  let var_list = ref [] in
  let var_id =
    let body tyvar =
      let rec index_of counter = function
          [] -> var_list := !var_list @ [tyvar]; counter
        | x :: rest -> if x = tyvar then counter else index_of (counter + 1) rest
      in index_of 0 !var_list
    in body in
  let rec to_string = function
      TyInt -> "int"
    | TyBool -> "bool"
    | TyVar tyvar -> Printf.sprintf "'%c" (char_of_int ((int_of_char 'a') + (var_id tyvar)))
    | TyFun (ty1, ty2) ->
      let string_ty1 = (match ty1 with
          TyFun (_, _) -> "(" ^ to_string ty1 ^ ")"
        | _ -> to_string ty1) in
      let string_ty2 = to_string ty2 in
        string_ty1 ^ " -> " ^ string_ty2
  in to_string ty

let pp_ty ty = print_string (string_of_ty ty)

let fresh_tyvar =
  let counter = ref 0 in
  let body () =
    let v = !counter in
      counter := v + 1; v
  in body

let rec freevar_ty ty = (match ty with
    TyVar var -> MySet.singleton var
  | TyFun (ty1, ty2) -> MySet.union (freevar_ty ty1) (freevar_ty ty2)
  | _ -> MySet.empty)
