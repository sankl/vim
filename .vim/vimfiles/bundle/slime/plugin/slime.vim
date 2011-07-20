""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! Send_to_Screen(text)
  if !exists("g:screen_sessionname") || !exists("g:screen_windowname")
    call Screen_Vars()
  end

    let mode = visualmode(1)
    if mode != '' && line("'<") == a:1
      if mode == "v"
        let start = col("'<") - 1
        let end = col("'>") - 1
        " slice in end before start in case the selection is only one line
        let lines[-1] = lines[-1][: end]
        let lines[0] = lines[0][start :]
      elseif mode == "\<c-v>"
        let start = col("'<")
        if col("'>") < start
          let start = col("'>")
        endif
        let start = start - 1
        call map(lines, 'v:val[start :]')
      endif
    endif

  let tmp = tempname()
  call writefile(lines, tmp)

  echo "screen -S " . g:screen_sessionname . " -p " . g:screen_windowname . " -X eval \"stuff '" . substitute(substitute(a:text, "['\"]", "'\\\\&'", 'g'), "\\n", "\\\\012", 'g') . "'\\012\""
  echo system("screen -S " . g:screen_sessionname . " -p " . g:screen_windowname . " -X eval \"stuff '" . substitute(substitute(a:text, "['\"]", "'\\\\&'", 'g'), "\\n", "\\\\012", 'g') . "'\\012\"")
"  call system("screen -S " . g:screen_sessionname . " -p " . g:screen_windowname . " -X eval \"stuff '" . substitute(a:text, "['\"]", "'\\\\&'", 'g') . "'\\012\"")
  "return "screen -S " . g:screen_sessionname . " -p " . g:screen_windowname . " -X eval \"stuff '" . substitute(a:text, "['\"]", "'\\\\&'", 'g') . "'\\012\""
  "echo system("screen -S " . g:screen_sessionname . " -p " . g:screen_windowname . " -X eval \"stuff '" . substitute(a:text, "'", "'\\\\''", 'g') . "'\"")
  "echo "screen -S " . g:screen_sessionname . " -p " . g:screen_windowname . " -X stuff '" . substitute(a:text, "'", "'\\\\''", 'g') . "'"
endfunction

function! Screen_Session_Names(A,L,P)
  return system("screen -ls | awk '/Attached/ {print $1}'")
endfunction

function! Screen_Vars()
  if !exists("g:screen_sessionname") || !exists("g:screen_windowname")
    let g:screen_sessionname = "slime"
    let g:screen_windowname = "0"
  end

  "let g:screen_sessionname = input("session name: ", "", "custom,Screen_Session_Names")
  "let g:screen_windowname = input("window name: ", g:screen_windowname)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <C-c><C-c> "ry:call Send_to_Screen(@r."\n")<CR>
nmap <C-c><C-c> vip<C-c><C-c>

nmap <C-c>v :call Screen_Vars()<CR>
