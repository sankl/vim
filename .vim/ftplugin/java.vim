" Vim filetype plugin file
" Language:     Java
" Maintainer:   Dan Sharp <dwsharp at hotmail dot com>
" Last Change:  Sun, 07 Oct 2001 21:41:05 Eastern Daylight Time
" Current version is at http://mywebpage.netscape.com/sharppeople/vim/ftplugin

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Go ahead and set this to get decent indenting even if the indent files
" aren't being used.
setlocal cindent

"---------------------
" From Johannes Zellner <johannes@zellner.org>
setlocal cinoptions+=j1         " Correctly indent anonymous classes
"---------------------

" For filename completion, prefer the .java extension over the .class
" extension.
set suffixes+=.class

" Automatically add the java extension when searching for files, like with gf
" or [i
setlocal suffixesadd=.java

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" Set 'comments' to format dashed lists in comments
setlocal com& com^=sO:*\ -,mO:*\ \ ,exO:*/  " Behaves just like C

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
set cpo-=C

" Change the :browse e filter to primarily show Java-related files.
if has("gui_win32") && !exists("b:browsefilter")
    let  b:browsefilter="Java Files (*.java)\t*.java\n" .
                \       "Properties Files (*.prop*)\t*.prop*\n" .
                \       "Manifest Files (*.mf)\t*.mf\n" .
                \       "All Files (*.*)\t*.*\n"
endif

setlocal includeexpr=substitute(v:fname,'\\.','/','g')
if ! &diff
"    set nu
endif

"set foldmethod=indent

imap <A-`> System.out.println("");hhi

fun! Concantenate(arg)
    let g:str = g:str . a:arg
endfun

fun! MakeJDoc4(entity)
    let g:str = ""
    let beg_line = line(".")
    exe ".+1?(?,.-1/[{;]/call Concantenate(getline('.'))"

    let b:result = 
        \"/**" .
        \"TODO"
"\"@com.intel.drl.spec_ref" .
        
    let params_mx='(\s*\(.*\)\s*)'
    let param_mx = '\s*\(.*\),\s*\(.*\)\s*'
    let param_tn_mx = '\s*\(.*\)\s\+\(\w\+\)\s*$'

    let params = matchstr(g:str, params_mx)
    let params = substitute(params, params_mx, '\1', '')

    "does not hang up if something happend wrong :)
    let a = 18
    let b:params_res = ""

    while a > 0 && strlen(params) > 0
        let param = substitute(params, param_mx, '\2', '')

        let g:param_type = substitute(param, param_tn_mx, '\1', '')
        let g:param_name = substitute(param, param_tn_mx, '\2', '')

        let params = substitute(params, param_mx, '\1', '')

        let b:params_res = "@param  	" . g:param_name . "	:	" . g:param_type . "" . b:params_res

        if param == params
            break
        endif

        let a = a - 1    
    endwhile

    let b:result = b:result . b:params_res
    
    if a:entity == "method"
        let b:result = b:result . 
            \"@return" 
    endif

    let exceptions_mx=')\s*throws\s*\(.*\)\s*[{;]'
    let exception_mx = '\s*\(.*\),\s*\(.*\)\s*'

    let exceptions = matchstr(g:str, exceptions_mx)
    let exceptions = substitute(exceptions, exceptions_mx, '\1', '')

    "does not hang up if something happend wrong :)
    let a = 18
    let b:e = exceptions
    let b:exceptions_res = ""

    while a > 0 && strlen(exceptions) > 0
        let exception = substitute(exceptions, exception_mx, '\2', '')

        let exceptions = substitute(exceptions, exception_mx, '\1', '')

        let b:exceptions_res = "@throws 	" . exception . "" . b:exceptions_res

        if exception == exceptions
            break
        endif

        let a = a - 1    
    endwhile
    let b:result = b:result . b:exceptions_res
    let b:result = b:result . 
        \"/"

    exe beg_line
    exe ".+1?(?"
    exe "normal O" . b:result
endfun

map <A-m> :call MakeJDoc4("method")
imap <A-m> <A-m>i
map <A-c> :call MakeJDoc4("constructor")
imap <A-c> <A-c>i

fun! MakeFieldDoc()
    let line = getline(".")
    let expField = '^.*\s\([^ ]*\)\s\([^ ]*\);.*'
    "let g:field = matchstr(line, expField)
    let type = substitute(line, expField, '\1', '') 
    let field = substitute(line, expField, '\2', '') 
    if field == "encoding"
        exe "normal O// the ASN.1 encoded form of " . expand("%:t:r")
    elseif field == "encoder"
        exe "normal O// the " . expand("%:t:r") . " encoder"
    else
        exe "normal O// the value of " . field . " field of the structure"
    endif
    exe "normal jj"
endfun

map <A-v> :call MakeFieldDoc()
imap <A-v> <A-v>i

fun! MakeGetterDoc()
    let line = getline(".")
    let expField = '^.*public.*get\(.*\)(.*'
    let field = substitute(line, expField, '\l\1', '')
    if field == "encoder"
        exe "normal O/**" .
        \"Constructs the encoder for this X.509 " . expand("%:t:r") ." value." .
        \"@return the encoder." .
        \"/"
    elseif field == "encoded"
        exe "normal O/**" .
        \"Returns ASN.1 encoded form of this X.509 " . expand("%:t:r") ." value." .
        \"@return a byte array containing ASN.1 encode form." .
        \"/"
    else
        exe "normal O/**" .
        \"Returns the value of " . field ." field of the structure." .
        \"@return 	" . field . "" .
        \"/"
    endif
"    exe "normal O// the value of " . field . " field"
"    s#^\([ ]*\)\(public.*get\)\(.*\)(#\1/**\1 * Returns \l\3 value\1 */\1\2\3(#
endfun

map <A-z> :call MakeGetterDoc()
imap <A-z> <A-z>i

fun! MakeClassDoc()
    let line = getline(".")
    if match(line, "class DerEncoder") >= 0
        exe "normal O/**" .
        \"ASN.1 DER X.509 " . expand("%:t:r") ." encoder class." .
        \"/"
    elseif match(line, "class DerDecoder") >=0
        exe "normal O/**" .
        \"ASN.1 DER X.509 " . expand("%:t:r") ." decoder class." .
        \"/"
    endif
endfun

map <A-x> :call MakeClassDoc()
imap <A-x> <A-x>i

fun! MakeGetters()
    let line = getline(".")
    let expField = '^.*\s\([^ ]*\)\s\([^ ]*\);.*'
    "let g:field = matchstr(line, expField)
    let type = substitute(line, expField, '\1', '') 
    let field = substitute(line, expField, '\2', '') 
    let methName = substitute(line, expField, 'get\u\2', '') 
    let getter = "public " . type . " " . methName . "() {" 
                 \ . "return " . field . ";}"
    exe "normal O" . getter . "jdd"
endfun

"map <A-g> :call MakeGetters()
"imap <A-g> <A-g>i

"abb <buffer> if if() {}<Up><Right>
