type t =
  | Str of string
  | Nl
  | Env of string * t list list * t list list * t list
  | Cmd of string * t list list * t list list
  | Inline of string
  | Display of string

exception Begin_end_error of string * string

