" HELP: {
"   vim: set foldmarker={,} foldlevel=0:
"       ^ modeline
"
"   :scriptnames " list all plugins, _vimrcs loaded (super)
"   :verbose set history?   : reveals value of history and where set
"
"   :runtime syntax/colortest.vim
"
"   " capturing output of current script in a separate buffer
"   :new | r!perl #                   : opens new buffer,read other buffer
"   :new+read!ls 
"
"   :vertical diffpatch diff
"
"   :NoMatchParen
"
"   2HTML:
"   :call HTML()
"     or:
"   :runtime syntax/2html.vim
"   :let use_xhtml = 1
"   :let html_use_css = 1
"   :let html_ignore_folding = 1
"
"   Added helps:
"   :help local-additions
"   Install vimball to bundle dir:
"   :call mkdir($VIM."\\bundle\\screen")
"   :let &rtp=$VIM."\\bundle\\screen,".&rtp
"   Send commad to screen session {
"   ScreenShell " to start new screen session
"   ScreenShellAttach slime " to attach to existing
"   screen -S slime -p 0 -X eval "msgminwait 0" "msgwait 0" "readbuf C:\ws\.bin\vim\tmp\VIB2FB.tmp" "at 0 paste ." "msgwait 5" "msgminwait 1"
"   screen -S slime -p 0 -X eval "msgminwait 0" "msgwait 0" "stuff 'echo $HOME'\012" "msgwait 5" "msgminwait 1"
"   screen -S slime -p 0 -X eval 'stuff "echo $HOME\012"'
"   }
" }

" Bootstrap {
    " To enable the saving and restoring of screen positions {
    if has("gui_running")
        let g:screen_size_restore_pos = 1
        let g:screen_size_by_vim_instance = 0
        so $VIM/restore_position.vim
    endif " }
    " Append all bundles in the runtimepath to the runtimepath {
    let s:bundles = tr(globpath(&rtp, 'bundle/*/.'), "\n", ',')
    let s:afters = tr(globpath(s:bundles, 'after/'), "\n", ',')
    let &runtimepath = join([&runtimepath, s:bundles, s:afters], ',')
    function! Splitpath(path) abort
        if type(a:path) == type([]) | return a:path | endif
        let split = split(a:path,'\\\@<!\%(\\\\\)*\zs,')
        return map(split,'substitute(v:val,''\\\([\\,]\)'',''\1'',"g")')
    endfunction
    for dir in Splitpath(&runtimepath)
        if dir[0 : strlen($VIM)-1] !=# $VIM && isdirectory(dir.'/doc') && (!filereadable(dir.'/doc/tags') || filewritable(dir.'/doc/tags'))
        helptags `=dir.'/doc'`
        endif
    endfor
    " }
" }

" Basic {
    " This must be first, because it changes other options as side effect
    set nocompatible
    syntax on
    " Title of the window {
    if &term == "win32"
        set title titlestring=%F\ %m
    endif
    " }
" }

" General {
    "set clipboard+=unnamed " share windows clipboard
    set mouse=a
    set hidden " you can change buffers without saving
    set history=1250
    "set undofile
    "set undodir=*/vim/undo
    "set swapfile
    "set directory=*/vim/swp
    " Disable any kind of bell {
    set t_vb=
    set noerrorbells
    set novisualbell 
    " }
    set wildchar=<Tab>
    set wildmenu "Turn on WiLd menu
    set wildmode=list:longest " turn on wild mode huge list
    set wildignore=*.swp,*.pyc,*.class,*.zip,*.tgz,*.tar.gz,*.exe,*.7z,*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
" }
"
" Filetypes {
    augroup filetype
    au! BufRead,BufNewFile *.slv   set filetype=solver
    au! BufRead,BufNewFile *.cvs   set filetype=cvs
    au! BufRead,BufNewFile *.txt   set filetype=txt
    au! BufRead,BufNewFile *.log   set filetype=log
    au  BufRead,BufNewFile .vim    set filetype=vim
    au! BufRead,BufNewFile Make.def        set filetype=make
    au! BufRead,BufNewFile *.jmpp  set filetype=java
    au! BufRead,BufNewFile *.jcod  set filetype=java
    au! BufRead,BufNewFile *.jad   set filetype=java
    au! BufRead,BufNewFile *.jasm  set filetype=java
    au! BufRead,BufNewFile *.policy set filetype=java
    au! BufRead,BufNewFile *.F90   set filetype=fortran
    au! BufRead,BufNewFile *.ws    set filetype=sh
    au! BufRead,BufNewFile *.gr    set filetype=groovy
    " au! BufRead,BufNewFile *.gr    set filetype=java
    " au! BufRead,BufNewFile *.groovy    set filetype=java
    au! BufRead,BufNewFile patch-*    set filetype=diff
    augroup END
" }

" Vim UI {
    set report=0 " tell us when anything is changed via :...
    set sidescrolloff=10 " Keep 10 lines at the size
    set scrolloff=5 " Set 10 lines to the curors - when moving vertical..
    set linebreak " Don't break words
    set display=lastline " Display as many lines as possible (no @@ on long lines)
    set showbreak="@-->" " string to put at the start of lines that have been wrapped
    set linebreak " while wrapping to get the break at a word boundary
    set statusline=%f\ %y%m%r%=\L%-4l\ \C%-3c\ [%L\ lines]
    "set cursorcolumn " highlight the current column
    "set cursorline " highlight current line
    " Show tabs and trailings {
    set nolist
    if has("gui_running")
        set listchars=tab:>�
        set listchars+=trail:� " �
    endif
    "set lcs+=eol:$
    " }
" }

" Editing {
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set textwidth=0 " Don't cut lines (no auto-new-line for long text)
    set backspace=indent,eol,start " Allow the backspace key to delete anything in insert mode
    set autoindent smartindent
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab 
    set ruler showcmd wmnu
    set laststatus=2
    set ttyfast
    set nowrap
    set hidden
    set nobackup
    set pastetoggle=<F3>
    set backspace=2
    set winheight=100
" }

" OS dependent settings {
    so $VIM/.vim_terms
" }

" GUI settings {
    if has("gui_running") || &t_Co == 88 || &t_Co == 256
        set background=dark
        "colo ansi_blows
        colo wombat256mod
        "colo Tomorrow-Night
        "let g:solarized_termcolors=256
        "colo solarized
        "colorscheme vimsidian
        "colo my
    else
        colo my
    end
    if has("gui_running")
        "GUI font, got by: <C-R>=&gfn
        set gfn=Consolas:h9:cRUSSIAN	
        let g:html_font="Consolas"
        set linespace=0 " don't insert any extra pixel lines
                        " betweens rows
        "inc/dec font size by Alt-, Alt+
        map <M-=> :set gfn=Consolas:h9:cRUSSIAN<CR>
        map <M--> :set gfn=Consolas:h8:cRUSSIAN<CR>
        "set gfn=Consolas:h12:cRUSSIAN
        "set guioptions-=T
        "set guioptions-=m
        set guioptions=ce 
        "set lines=50 columns=100
        " set mousehide " hide the mouse cursor when typing
        " shows/hides menu bar on Ctrl-F1
        nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
        " Console2 support:
        "set shell=-r
        "set shellquote=\\"
        "set shellcmdflag=
        "set shellpipe=>
        "set shellredir=>
        "set shellpipe=2>&1\|tee
        "set shellredir=>%s\ 2>&1
    else
    endif
" }

" Tabs {
"   " from http://fingelrest.silent-blade.org/uploads/Main/vimrc.html {
    " Return the string used as the tabline {
    fu! TabLine()
        let tabline = ''
        for i in range(tabpagenr('$'))
            let currtabnr  = i + 1
            let currbuflst = tabpagebuflist(currtabnr)
            " Set the correct highlighting for the current tab
            let tabline .= ((currtabnr == tabpagenr()) ? '%#TabLineSel#' : '%#TabLine#')
            " Tab number (for mouse clicks)
            let tabline .= '%' . (currtabnr) . 'T'
            " Filename of the current window (no path)
            let filename = bufname(currbuflst[tabpagewinnr(currtabnr) - 1])
            if filename != ''
                let filename = fnamemodify(filename, ':t')
            else
                let filename = '[No Name]'
            endif
            " Check whether one of the buffers has been modified
            let bufmodified = ''

            for bufnr in range(len(currbuflst))
                if getbufvar(currbuflst[bufnr], "&mod") == 1
                    let bufmodified = ' [+]'
                    break
                endif
            endfor
            " Number of buffers
            let nbbuf = tabpagewinnr(currtabnr, '$')

            if nbbuf == 1
                let nbbuf = ''
            else
                let nbbuf = ':' . nbbuf
            endif
            " Name of the tab
            if currtabnr == tabpagenr()
                let tabline .= filename . nbbuf . bufmodified . '%#TabLine#  '
            else
                let tabline .= filename . nbbuf . bufmodified . '  '
            endif
        endfor
        return tabline . '%#TabLineFill#%T'
    endf " }
    " Shift the current tab to the left (direction == 0) or to the right (direction != 0) {
    fu! ShiftTab(direction)
        let tabpos = tabpagenr()
        if a:direction == 0
            if tabpos == 1
                exe 'tabm' . tabpagenr('$')
            else
                exe 'tabm' . (tabpos - 2)
            endif
        else
            if tabpos == tabpagenr('$')
                exe 'tabm ' . 0
            else
                exe 'tabm ' . tabpos
            endif
        endif
        return ''
    endf " }
    " Use our custom function to draw the tabline
    set tabline=%!TabLine()
    " Shift the current tab to the left/right
    inoremap <silent> <C-S-Left>  <C-r>=ShiftTab(0)<CR>
    inoremap <silent> <C-S-Right> <C-r>=ShiftTab(1)<CR>
    noremap <silent> <C-S-Left>  :call ShiftTab(0)<CR>
    noremap <silent> <C-S-Right> :call ShiftTab(1)<CR>
    " Ctrl-t creates a new tab and opens the file explorer
    map  <silent> <C-t> :tabnew +:NERDTree<CR>
    imap <silent> <C-t> <Esc><C-t>
    " }
" }

" Colors tunings {
    let g:is_bash=1 " for sh scripts syntax
    hi Search term=reverse ctermfg=226 ctermbg=240 guifg=#d787ff guibg=#636066
    hi StatusLine        term=bold,reverse ctermfg=Black ctermbg=LightGrey guifg=Black         guibg=#E0E0E0      gui=bold
    hi StatusLineNC      term=bold,reverse ctermfg=Black ctermbg=LightGrey guifg=Black         guibg=#c0c0c0      gui=italic
    hi SpecialKey term=bold ctermfg=9 guifg=#a0a0ff guibg=#303030 gui=italic
    "hi DiffText term=reverse cterm=bold ctermfg=15 ctermbg=red gui=bold guifg=#ffffff guibg=#ff5050
    hi DiffText ctermfg=15 guifg=#ffffff
    "hi DiffChange term=bold ctermbg=lightmagenta guibg=#880088
    hi Underlined term=underline cterm=underline ctermfg=15
    "hi Folded term=standout ctermfg=cyan ctermbg=black guifg=#888800 guibg=#222222
    hi Folded  term=standout ctermfg=111 ctermbg=235 guifg=#888800 guibg=#222222
    " Popup menu colors {
    hi PMenu ctermbg=grey ctermfg=black guibg=#404040
    hi PmenuSel ctermfg=4 ctermbg=6 guifg=black guibg=#b0b0b0
    hi Pmenuthumb ctermfg=3 ctermbg=7 guifg=#404040
    " }
" }

" Tools tunnings {
    "set errorformat=%f:%l:%m " error format for find -exec grep:
    "set path=,,.
    "set tags=$VIM/tags,./tags,tags,../src/tags,../srcfw/tags
" }

" Folding {
    set foldenable " Turn on folding
    set foldmarker={,} " Fold C style code (only use this as default
                        " if you use a high foldlevel)
    set foldmethod=marker " Fold on the marker
    set foldlevel=100 " Don't autofold anything (but I can still
                      " fold manually)
    set foldopen=block,hor,search,mark,percent,quickfix,tag " what movements
                                                      " open folds
    " \z to fold text not containing search string
    map <silent><leader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>
    function! FoldText() " {
        let line = getline(v:foldstart)
        let sub = substitute(line, '\t', '    ', 'g')
        "let sub = substitute(sub, '^.', '+', 'g')
        return sub . ' '
    endfunction " }
    set foldtext=FoldText() " Custom fold text function (cleaner than default)
    " Folding search (use zr / zm to increase/decrease search context): {
    " ( from http://vim.wikia.com/wiki/VimTip282 )
    command! -nargs=+ Foldsearch exe "normal /".<q-args>."^M" | setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:(getline(v:lnum-2)=~@/)\|\|(getline(v:lnum+2)=~@/)?2:3 foldmethod=expr foldlevel=0 foldcolumn=2
    " view the methods and variables in a java source file."
    command! Japi Foldsearch public\s\|protected\s\|private\s
    " }
    " Fold search misses {
    " After executing the following, you can search for a pattern then press F8 to fold misses. 
    ":set foldexpr=getline(v:lnum)!~@/
    ":nnoremap <F8> :set foldmethod=expr<CR><Bar>zM
    " }
" }

" Search/Replace {
    set ignorecase smartcase incsearch hlsearch
    set wrapscan " Wrap search when EOF is reached
    set gdefault " Always replace all occurrences on a line, not just the first one
    " double escape to clear search highlights
    nnoremap <C-L> :nohlsearch<cr><C-L>
    " redraw window so search terms are centered
    nnoremap n nzz
    nnoremap N Nzz
" }

" Programming {
    " fold diff (from http://www.vim.org/scripts/script.php?script_id=2090):
    function! s:FoldDiffFile(line_num)
        return getline(a:line_num) =~ '^\(Index.*$\)\@!'
        "return getline(a:line_num) =~ '^\(+\([^+]\|$\)\|-\([^-]\|$\)\|@\|\s\|+++\|---\|===\)'
    endfunction
    map <leader>dz :if &ft=='diff' \| :set foldmethod=expr \| :set foldexpr=<SID>FoldDiffFile(v:lnum) \| :endif<CR>
    " Diff {
        " complex diff parts of same file *N*
        ":1,2yank a | 7,8yank b
        nmap \d exe :tabedit \| put a \| vnew \| put b \| windo diffthis
    " }

    " au BufEnter *.c,*.cc,*.C,*.cpp,*.CPP,*.h,*.hpp,*.java,*.gr,*.groovy,*.m set cin noic
    " Tune make {
    " set makeprg=make
    " set efm=%f:%l:\ %m
    " }
    " Go to java file from package name
    " map gf :sf <cfile>:s?\.?\\?.java<CR>
    " Execute command under cursor in a shell
    " map tr yaw:!t " 
    " new HTML files get automatic boilerplate
    " au BufNewFile *.html 0r $VIM/templates/template.html
    " refresh Firefox on Vim save (requires MozRepl installed/running)
    " au BufWriteCmd *.html,*.css :call Refresh_firefox() " http://github.com/samdk/vimconf/blob/master/dotvimrc
    " Spec markup key bindings {
    " map + :let @a=line(".")*col(".")`>a</b>("apa)`<i<b>
    " map + :let @a=line(".")*10`>a</b>("apa)`<i<b>
    " map + :let @a=line(".")*10`>a</b>("apa)`<i<b>
    " map + `>a</b> `<i<b>
    " map - ?<b>3dl/</b>4dl:.s/(.*)//
    " map - ?<b>3dl/</b>:s/<\/b>[ ]*(.*)//
    " hi htmlBold cterm=bold ctermfg=4
    " }
" }

" Mappings {
    " Substitution {
        " Pull word under cursor into LHS of a substitute
        nmap <leader>z :%s#\<<c-r>=expand("<cword>")<cr>\>#
        " Pull Visually Highlighted text into LHS of a substitute
        vmap <leader>z :<C-U>%s/\<<c-r>*\>/
    " }
    " release 2 keystrokes (no pushing SHIFT anymore to get commang mode!)
    nnoremap ; :
    nnoremap ! :!
    "map <End> $
    "map <Home> 0
    " Movement {
    " Smart way to move btw. windows
    "map <C-j> <C-W>j
    "map <C-k> <C-W>k
    "map <C-h> <C-W>h
    "map <C-l> <C-W>l
    imap <S-UP>     <C-W><Up>i
    imap <S-DOWN>   <C-W><Down>i
    imap <S-RIGHT>  <C-W><Right>i
    imap <S-LEFT>   <C-W><Left>i
    map <S-UP>     <C-W><Up>
    map <S-DOWN>   <C-W><Down>
    map <S-RIGHT>  <C-W><Right>
    map <S-LEFT>   <C-W><Left>
    "map <C-RIGHT>  <ESC>:tabnext<CR>
    "map <C-LEFT>   <ESC>:tabprevious<CR>
    " up/down move between visual lines instead of actual lines when wrapped
    noremap <Up>   gk
    noremap <Down> gj
    "noremap <Home> g<Home>
    "noremap <End>  g<End>
    "breaks tab compleation popup menu movements:
    "inoremap <Up>   <C-o>gk
    "inoremap <Down> <C-o>gj
    "inoremap <Home> <C-o>g<Home>
    "inoremap <End>  <C-o>g<End>
    " }
    " autocompletes parens/brackets
    "inoremap ( ()<Left>
    "inoremap [ []<Left>
    " In visual mode, enclose the selection with the given character
    "vnoremap <silent> ' s''<Esc>P
    "vnoremap <silent> " s""<Esc>P
    "vnoremap <silent> ( s()<Esc>P
    "vnoremap <silent> { s{}<Esc>P
    "vnoremap <silent> [ s[]<Esc>P

    " autocomplete quotes intelligently (from http://github.com/samdk/vimconf/blob/master/dotvimrc) {
    "inoremap ' '<Esc>:call QuoteInsertionWrapper("'")<CR>a
    "inoremap " "<Esc>:call QuoteInsertionWrapper('"')<CR>a
    "inoremap ` `<Esc>:call QuoteInsertionWrapper('`')<CR>a
    "function! QuoteInsertionWrapper (quote)
    "    let col = col('.')
    "    if &ft != "vim" && getline('.')[col-2] !~ '\k' && getline('.')[col] !~ '\k'
    "        normal ax
    "        exe "normal r".a:quote."h"
    "    end
    "endfunction
    " }
    " Functional keys {
    noremap         <F2>    :w<CR>
    inoremap        <F2>    :w<CR>
    noremap         <F4>    :bdelete<CR>
    inoremap        <F4>    :bdelete<CR>

    "noremap         <F6>    :bprevious<CR>
    "inoremap        <F6>    :bprevious<CR>
    "noremap         <F7>    :bnext<CR>
    "inoremap        <F7>    :bnext<CR>

    " Open FufFile
    noremap         <F6>    <Esc>:FufFile<CR>
    inoremap        <F6>    <Esc>:FufFile<CR>
    " Open MRU list
    noremap         <F7>    <Esc>:MRU<CR>
    inoremap        <F7>    <Esc>:MRU<CR>
    " Toggle NERDTree
    noremap         <F8>    <Esc>:NERDTreeToggle<CR>
    inoremap        <F8>    <Esc>:NERDTreeToggle<CR>
    " Open FAR
    " noremap         <F8>    :silent exe '!cmd /C start "FAR" ConEmu.exe "%:p:h"'<CR>
    " inoremap        <F8>    :silent exe '!cmd /C start "FAR" ConEmu.exe "%:p:h"'<CR>
    " List open buffers
    noremap         <F10>   :buffers<CR>
    inoremap        <F10>   :buffers<CR>
    " Copy filename to buffer
    noremap         <F11>   :silent let @*=@%<CR>
    inoremap        <F11>   :silent let @*=@%<CR>
    " Open filename from buffer
    inoremap        <F12>   <Esc>:silent exe "sp ".@*<CR><CR>
    inoremap        <F12>   <Esc>:silent exe "sp ".@*<CR><CR>
    "noremap         <F12>   <Esc>:silent exe "sp ".substitute('<C-R>+', '\"\s*', "", "")<CR><CR>
    "noremap         <F12>   <Esc>:silent exe "sp ".substitute('<C-R>+', '\"\s*', "", "")<CR><CR>
    " }
    " Toggle window width {
    noremap <C-SPACE> :call ExpandWindow()
    function! ExpandWindow()
        if ! exists("g:expanded")
            let g:expanded = 0
        endif
        if g:expanded == 0
            let &columns = &columns + 35
            let g:expanded = 1
        else
            let &columns = &columns - 35
            let g:expanded = 0
        endif
    endfunction 
    " }
" }

" Insert mode completion {
    set infercase " Don't show possible completions that don't match the case of existing text
    set pumheight=15 " Don't show more than 10 items in the popup menu
    "set complete=.,w,u,b,kspell " Where to look for possible completions
    set completeopt=menu,longest " How to show and insert possible completions
" }

" Plugins settings {
    filetype plugin on
    " FuzzyFinder plugin tuning {
    let g:fuf_previewHeight = 0
    let g:fuf_enumeratingLimit = 150
    " }
    " MRU plugin config (http://www.vim.org/scripts/script.php?script_id=521) {
    let MRU_File = $VIM."/.vim_mru_files" 
    let MRU_Auto_Close = 1
    let MRU_Add_Menu = 0 
    " }
    " Not in use plugins {
        " Checkstyle plugin tuning {
        " let Checkstyle_Classpath="C:/ws/bin/checkstyle/checkstyle-all-4.1.jar"
        " let Checkstyle_XML="C:/ws/bin/checkstyle/sun_checks.xml"
        " }
        " Project plugin {
        "let g:proj_flags="mstgb"
        "nmap <silent> <Leader>P <Plug>ToggleProject
        "nmap <silent> <C-P> <Plug>ToggleProject
        " }
    " }
" }

" Language support {
    language C " language of vim status messages
    " rus/lat key mapping {
    " TODO Use keymap !!!
    " so $VIM/.vim_keys
    " }
    " i_CTRL-^ - to change the input language
    " set keymap=russian-jcukenwin iminsert=0 imsearch=0
    "set encoding=UTF-8
    "set encoding=cp1251
    map ё `
    map й q
    map ц w
    map у e
    map к r
    map е t
    map н y
    map г u
    map ш i
    map щ o
    map з p
    map х [
    map ъ ]
    map ф a
    map ы s
    map в d
    map а f
    map п g
    map р h
    map о j
    map л k
    map д l
    map ж ;
    map э '
    map я z
    map ч x
    map с c
    map м v
    map и b
    map т n
    map ь m
    map б ,
    map ю .
    map Ё ~
    map Й Q
    map Ц W
    map У E
    map К R
    map Е T
    map Н Y
    map Г U
    map Ш I
    map Щ O
    map З P
    map Х {
    map Ъ }
    map Ф A
    map Ы S
    map В D
    map А F
    map П G
    map Р H
    map О J
    map Л K
    map Д L
    map Ж :
    map Э "
    map Я Z
    map Ч X
    map С C
    map М V
    map И B
    map Т N
    map Ь M
    map Б <
    map Ю >
" }

" Export HTML {
    func! HTML()

        colo PapayaWhip
        set bg=light
        %TOhtml
        w! $TEMP/_vim.html
        silent exec "! ".$TEMP."/_vim.html"
        q
        set bg=dark
        colo ansi_blows
    endfunc
    command! -nargs=0 HTML <line1>,<line2>call HTML()
" }

" Proceed with directory-wise vim configurations (.lvimrc)
"so $VIM/localrc.vim

" remove side effect of some configurations (search highlits)
nohlsearch


