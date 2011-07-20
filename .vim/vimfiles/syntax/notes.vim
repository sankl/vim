" Quantors

syn match Subject /^=\s.*$/
hi Subject ctermfg=cyan

syn match Reference /\[>.*]/
hi Reference ctermfg=cyan

syn match Item /^\s*\*\s/
hi Item ctermfg=white

syn match Topic /^\s*o\s\w.*$/
hi Topic ctermfg=magenta

syn match Bad /^\s*-\s/
hi Bad ctermfg=red

syn match Good /^\s*+\s/
hi Good ctermfg=green

syn match Gain /^\s*\$\s/
hi Gain ctermfg=yellow

syn match Action /^\s*&\s/
hi Action ctermfg=white

syn match Result /^\s*>\s/
hi Result ctermfg=white

syn match Explanation /^\s*:\s/
hi Explanation ctermfg=yellow

syn match Addition /^\s*,\s/
hi Addition ctermfg=yellow

syn match End /^---.*$/
hi End ctermfg=darkgrey

syn match Config /^\s\+vim:.*$/
hi Config ctermfg=darkgrey

syn match ListItem /^\s*\d\d*\./
hi ListItem ctermfg=cyan

syn match CommandLine /\s\#>\s.*$/
hi CommandLine ctermfg=yellow

syn match CrossReference /\[>idx\.\d\d*]/
hi CrossReference ctermfg=darkgray

" Regions

syn region Underline start=+\<_+hs=s+1 end=+_\>+he=e-1 
hi Underline ctermfg=2

