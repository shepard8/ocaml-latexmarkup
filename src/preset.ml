(*
 * Conventions for variable names:
 * - ps stands for preset
 * - env stands for environment
 * - cmd stands for command
 * - fb stands for fallback
 *)

type p = Ast.t list

type 'a env = p list -> p list -> p -> 'a
type 'a cmd = p list -> p list -> 'a

type 'a t = {
  envs : (string, 'a env) Hashtbl.t;
  cmds : (string, 'a cmd) Hashtbl.t;
  envfb : string -> 'a env;
  cmdfb : string -> 'a cmd;
}

let create envfb cmdfb = {
  envs = Hashtbl.create 20;
  cmds = Hashtbl.create 20;
  envfb;
  cmdfb;
}

let register_env ps name f = Hashtbl.add ps.envs name f

let register_cmd ps name f = Hashtbl.add ps.cmds name f

let cmd ps c o a =
  try Hashtbl.find ps.cmds c o a
  with Not_found -> ps.cmdfb c o a

let env ps c o a b =
  try Hashtbl.find ps.envs c o a b
  with Not_found -> ps.envfb c o a b

let parse ps l =
  List.map (function
    | Ast.Str s -> cmd ps "text" [] [[Ast.Str s]]
    | Ast.Nl -> cmd ps "newline" [] []
    | Ast.Env (c, o, a, b) -> env ps c o a b
    | Ast.Cmd (c, o, a) -> cmd ps c o a
    | Ast.Inline s -> cmd ps "inline" [] [[Ast.Str s]]
    | Ast.Display s -> cmd ps "display" [] [[Ast.Str s]]
  ) l

