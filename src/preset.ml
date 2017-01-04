(*
 * Conventions for variable names:
 * - ps stands for preset
 * - env stands for environment
 * - cmd stands for command
 * - fb stands for fallback
 *)

type p = Parser.t list

type 'a env = p -> p -> p -> 'a
type 'a cmd = p -> p -> 'a

type 'a t = private {
  envs : (string * 'a env) Hashtbl.t;
  cmds : (string * 'a cmd) Hashtbl.t;
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
  try Hashtbl.get ps.cmds c o a
  with Not_found -> ps.cmdfb c o a

let env ps c o a b =
  try Hashtbl.get ps.envs c o a b
  with Not_found -> ps.envfb c o a b

let parse ps l =
  List.map (function
    | Str s -> cmd ps "text" [] [s]
    | Nl -> cmd ps "newline" [] []
    | Env (c, o, a, b) -> env ps c o a b
    | Cmd (c, o, a) -> cmd ps c o a
    | Inline s -> cmd ps "inline" [] [s]
    | Display s -> cmd ps "display" [] [s]
  ) l

