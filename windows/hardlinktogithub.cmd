@echo on
pushd "%~dp0..\..\..\homeofunix"
set "vimrc=%cd%\_vimrc"
set "gvimrc=%cd%\_gvimrc"

pushd "%~dp0..
mklink /h _vimrc "%vimrc%"
mklink /h _gvimrc "%gvimrc%"

set/p=done
