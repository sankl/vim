" Vim filetype plugin file
"
" Language:			Groovy
"
" Features:			Runs or compiles Groovy scripts.  Indents code blocks.
" 						Continues comments on adjacent lines.  Provides 
" 						insert-mode abbreviations.  F2 for plugin help.
"
" Installation:	Suggested installation at ~/.vim/ftplugin, or on Windows at 
" 						<Vim install directory>\vimfiles\ftplugin. 
" 						'filetype plugin on' must be specified in .vimrc or _vimrc.
"
" Author:			Jim Ruley <jimruley+vim@gmail.com> 
"
" Date Created:	April 20, 2008
"
" Version:			0.1.2
"
" Modification History:
" 
" 						April 24, 2008: Properly reset modified indent when leaving 
" 						buffer.
"
" 						April 23, 2008: Fixed mappings for F4 and F6, and replaced too 
" 						restrictive cindent.

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

" For filename completion, prefer .groovy extension over .class extension.
set suffixes+=.class

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal formatoptions-=t formatoptions+=croql

" Set 'comments' to format dashed lists in comments. Behaves just like C.
setlocal comments& comments^=sO:*\ -,mO:*\ \ ,exO:*/
setlocal commentstring=//%s
 
" Indent 
setlocal smartindent 
setlocal autoindent 

" Restore the saved compatibility options.
let &cpo = s:save_cpo
