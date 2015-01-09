open Syntax

exception Error of string

let err s = raise (Error s)

(* Type Environment *)
type tyenv = ty Environment.t

type subst = (tyvar * ty) list

let rec subst_type s typ =
  let rec resolve_type s = function
      TyVar v -> (try List.assoc v s with Not_found -> TyVar v)
    | TyFun (ty1, ty2) -> TyFun (subst_type s ty1, subst_type s ty2)
    | a -> a in
  let rec resolve_subst = function
      [] -> []
    | (id, typ) :: rest -> let new_subst = resolve_subst rest in
        ((id, resolve_type new_subst typ) :: new_subst) in
  resolve_type (resolve_subst s) typ

(* eqs_of_subst : subst -> (ty * ty) list
型代入を型の等式集合に変換 *)
let eqs_of_subst s = (* XXX *)[]

let rec unify = function
    [] -> []
  | (ty1, ty2) :: rest -> (match ty1, ty2 with
      TyInt, TyInt -> unify rest
    | TyBool, TyBool -> unify rest
    | TyFun (ty11, ty12), TyFun (ty21, ty22) -> unify ((ty11, ty12) :: (ty21, ty22) :: rest)
    | TyVar var1, TyVar var2 -> if var1 = var2 then unify rest else (unify rest) @ [(var1, ty2)]
    | TyVar var, _ -> if MySet.member var (Syntax.freevar_ty ty2) then err ("type err")
        else (unify rest) @ [(var, ty2)]
    | _, TyVar var -> if MySet.member var (Syntax.freevar_ty ty1) then err ("type err")
        else (unify rest) @ [(var, ty1)]
    | _, _ -> unify rest)

let ty_prim op ty1 ty2 = match op with
    Plus -> ([(ty1, TyInt); (ty2, TyInt)], TyInt)
  | Mult -> (match ty1, ty2 with
        TyInt, TyInt -> TyInt
      | _ -> err ("Argument must be of integer: *"))
  | Lt -> (match ty1, ty2 with
        TyInt, TyInt -> TyBool
      | _ -> err ("Argument must be of integer: <"))
  | And -> (match ty1, ty2 with
        TyBool, TyBool -> TyBool
      | _ -> err ("Argument must be of bool: &&"))
  | Or -> (match ty1, ty2 with
        TyBool, TyBool -> TyBool
      | _ -> err ("Argument must be of bool: ||"))


let rec ty_exp tyenv = function
    Var x ->
      (try ([], Environment.lookup x tyenv) with
          Environment.Not_bound -> err ("variable not bound: " ^ x))
  | ILit _ -> ([], TyInt)
  | BLit _ -> ([], TyBool)
  | BinOp (op, exp1, exp2) ->
    let (s1, ty1) = ty_exp tyenv exp1 in
    let (s2, ty2) = ty_exp tyenv exp2 in
    let (eqs3, ty) = ty_prim op ty1 ty2 in
    let eqs = (eqs_of_subst s1) @ (eqs_of_subst s2) @ eqs3 in
    let s3 = unify eqs in (s3, subst_type s3 ty)
  | IfExp (exp1, exp2, exp3) ->
    let tycond = ty_exp tyenv exp1 in
    let tythen = ty_exp tyenv exp2 in
    let tyelse = ty_exp tyenv exp3 in
      (match tycond with
          TyBool -> if tythen = tyelse then tythen else err ("Type of then expression and that of else expression must be same")
        | _ -> err ("Condition must be of bool"))
  | LetExp (id, exp1, exp2) ->
    let tyvalue = ty_exp tyenv exp1 in
      ty_exp (Environment.extend id tyvalue tyenv) exp2
  | FunExp (id, exp) ->
    let domty = TryVar (fresh_tyvar ()) in
    let s, ranty =
      ty_exp (Environment.extend id domty tyenv) exp in
      (s, TyFun (subst_type s domty, ranty))
  | AppExp (exp1, exp2) -> (* XXX *) ([], TyInt)
  | _ -> err ("Not Implemented!")

let ty_decl tyenv = function
    Exp e -> ty_exp tyenv e
  | Decl (_, e) -> ty_exp tyenv e
  | _ -> err ("Not Implemented!")
