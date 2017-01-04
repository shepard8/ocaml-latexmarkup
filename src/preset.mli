type p = Parser.t list

type 'a env = p -> p -> p -> 'a
type 'a cmd = p -> p -> 'a

type 'a t = private {
  envlist : (string * 'a env) Hashtbl.t;
  cmdlist : (string * 'a cmd) Hashtbl.t;
  envfallback : string -> 'a env;
  cmdfallback : string -> 'a cmd;
}

val create : (string -> 'a env) -> (string -> 'a cmd) -> 'a t

val register_environment : 'a t -> string -> 'a env -> unit

val register_command : 'a t -> string -> 'a cmd -> unit

val parse : 'a t -> p -> 'a list

