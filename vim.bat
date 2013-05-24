@echo off

set VER=vim73
set VIM=%~dp0.vim
set HOME=%~dp0.tmp\vimhome
if not exist %HOME% mkdir %HOME%
start %VIM%\%VER%\gvim %*
