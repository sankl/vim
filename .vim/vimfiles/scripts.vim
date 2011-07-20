if getline(1) =~ '^#=\+'
    set filetype=make 
endif
if getline(1) =~ '^#.*\<my_script\>'
    set filetype=bshscr 
endif
if getline(1) =~ '^.*\<my_test\>'
   set filetype=mytest 
endif

