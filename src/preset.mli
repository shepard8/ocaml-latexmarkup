type p = Ast.t list

type 'a env = p list -> p list -> p -> 'a
type 'a cmd = p list -> p list -> 'a

type 'a t = {
  envs : (string, 'a env) Hashtbl.t;
  cmds : (string, 'a cmd) Hashtbl.t;
  envfb : string -> 'a env;
  cmdfb : string -> 'a cmd;
}

val create : (string -> 'a env) -> (string -> 'a cmd) -> 'a t

val register_env : 'a t -> string -> 'a env -> unit

val register_cmd : 'a t -> string -> 'a cmd -> unit

val parse : 'a t -> p -> 'a list

