%{
  open Printf
%}

%token <string> CMD STR BEGIN END
%token LB RB LS RS LINLINE RINLINE LDISPLAY RDISPLAY NL EOF

%start <Ast.t list> main

%%

main :
  | l=list(content) EOF { l }

content :
  | c=CMD o=list(opt) a=list(arg)
  { Ast.Cmd (c, o, a) }
  | c=BEGIN o=list(opt) a=list(arg) b=list(content) d=END
  {
    if c <> d then raise (Ast.Begin_end_error (c, d))
    else Ast.Env (c, o, a, b)
  }
  | LINLINE b=list(overlooked) RINLINE
  { Ast.Inline (String.concat "" b) }
  | LDISPLAY b=list(overlooked) RDISPLAY
  { Ast.Display (String.concat "" b) }
  | b=STR
  { Ast.Str b }
  | NL
  { Ast.Nl }

opt :
  | LS b=list(content) RS { b }

arg :
  | LB b=list(content) RB { b }

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

