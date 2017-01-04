{
  open Tokens
}

rule token = parse
| "\\begin{" { BEGIN }
| "\\end{" { END }
| '\\' (['a'-'z' 'A'-'Z']+ as s) { CMD(s) }
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
