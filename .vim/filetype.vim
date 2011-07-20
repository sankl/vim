" secure file
autocmd  BufNewFile  *.san     X
" remove the full path and line numbers from the error window
au! BufReadPost quickfix  setlocal modifiable
\ | set nonu
\ | silent! exe "%s#".escape(getcwd(),'\')."\\\\##e"
\ | set nowinfixheight
