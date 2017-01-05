{
  open Parser
}

let id = ['a'-'z' 'A'-'Z']+

rule token = parse
| "\\begin{" (id as c) "}" { BEGIN(c) }
| "\\end{" (id as c) "}" { END(c) }
| '\\' (id as c) { CMD(c) }
| '{' { LB }
| '}' { RB }
| '[' { LS }
| ']' { RS }
| ("\r\n" | '\r' | '\n') { NL }
| "\\(" { LINLINE }
| "\\)" { RINLINE }
| "\\[" { LDISPLAY }
| "\\]" { RDISPLAY }
| eof { EOF }
| [^ '{' '}' '[' ']' '\n' '\r']+ as s { STR(s) }
