command -nargs=+ HiLink hi link <args>
  syn match   Identifier  contained "<[a-zA-Z_][a-zA-Z0-9_]*/\=>"
  syn region  pythonString  matchgroup=Normal start=+[uU]\="""+ end=+"""+ contains=Identifier
  HiLink pythonString	String
delcommand HiLink

