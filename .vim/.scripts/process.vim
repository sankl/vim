" process notes in defined format and makes HTML report

w! %.html | sp #

" escape XML tags
:1,/^---\?/ s#<\(.\{-}\)>#\&lt;\1\&gt;#g

":1,/^---\?/ s#^\s*\([-*:>o]\)\s\(\_.\{-}\)\(\n\s*[-*:>o]\s\|\n\_.\{-}\%$\)\@=#<font color="\1">\2</font>#
:1,/^---\?/ s#^\(\s*\)\([-*:>o=]\)\s\(\_.\{-}\)\(\n\s*[-*:>o=]\s\)\@=#<font color="\2">\1\#\2\#\3</font>#

:%s#color="\-"#color="DarkRed"#
:%s#color="\*"#color="DarkGreen"#
:%s#color=":"#color="Black"#
:%s#color=">"#color="MediumBlue"#
:%s#color="o"#color="Black"#
:%s#color="="#color="Black"#

" bonding and size increase for headers (= and o quantors)
:1,/^---\?/ s/>#[=]#\(.\{-}\)\(<font\|\n\)/><font size="+2"><b>\1<\/b><\/font>\2/
:1,/^---\?/ s/>#[o]#\(.\{-}\)\(<font\|\n\)/><font size="+1"><b><i>\1<\/b><\/i><\/font>\2/

" for - and * quantor at the beginning of the line set the bullet:
:1,/^---\?/ s/>\(#[-*]#\)/>\&bull; \1/

" for > quantor write Result:
:1,/^---\?/ s/#[>]#/<i>Result: <\/i>/e

" for : quantor just write "- "
:1,/^---\?/ s/#[:]#/- /e

" for * quantor just write Advice:
:1,/^---\?/ s/#[*]#/<i>Advice: <\/i>/e

" for - quantor just write Issue:
:1,/^---\?/ s/#-#/<i>Issue: <\/i>/e

" new lines
:1,/^---\?/ s#\n#<br>#
" indentation
:1,/^---\?/ s#  #\&nbsp;\&nbsp;#g


" HTML HEADER 

":1s#^#<font size="3"><code>#
:1s#^#<font face="courier new" size="2">#

:w
