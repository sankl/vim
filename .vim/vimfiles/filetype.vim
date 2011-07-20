" secure file
autocmd  BufNewFile  *.san     setfiletype san | X
" remove the full path and line numbers from the error window
au! BufReadPost quickfix  setlocal modifiable
\ | set nonu
\ | silent! exe "%s#".escape(getcwd(),'\')."\\\\##e"
\ | set nowinfixheight
