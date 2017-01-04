%{
  open Tokens
  open Printf

  exception Begin_end_error of string * string

  type t =
    | Str of string
    | Nl
    | Env of string * t list * t list * t list
    | Cmd of string * t list * t list
    | Inline of string
    | Display of string
%}

%token <string> CMD STR
%token BEGIN END LB RB LS RS LINLINE RINLINE LDISPLAY RDISPLAY NL EOF

%start <t> main

%%

main :
  | l=list(content) EOF { l }

content :
  | c=CMD o=list(opt) a=list(arg)
  { Cmd (c, o, a) }
  | BEGIN c=arg o=list(opt) a=list(arg) b=list(content) END c'=arg
  {
    if c <> c' then raise (BeginEndError (c, c'))
    else Env (c, o, a, b)
  }
  | LINLINE b=list(overlooked) RINLINE
  { Inline (String.concat "" b) }
  | LDISPLAY b=list(overlooked) RDISPLAY
  { Display (String.concat "" b) }
  | b=list(str)
  { Str (String.concat "" b) }
  | NL { Nl }

opt :
  | LS content RS

arg :
  | LB content RB

overlooked :
  | c=CMD { "\\" ^ c }
  | b=STR { b }
  | BEGIN { "\\begin" }
  | END { "\\end" }
  | LB { "{" }
  | RB { "}" }
  | LS { "[" }
  | RS { "]" }
  | NL { "\n" }

str :
  | b=STR { b }
  | LS { "[" }
  | RS { "]" }
  | LB { "{" }
  | RB { "}" }

