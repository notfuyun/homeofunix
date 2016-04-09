"pathogen
call pathogen#infect()
filetype plugin on
let g:go_disable_autoinstall = 0
" Highlight
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1



autocmd! bufwritepost _vimrc source ~/_vimrc
syntax enable
set nocompatible " above vi
set smartindent
set confirm "tip
" set autowriteall
set number "line
" set textwidth=
set nowrap "break line
set numberwidth=6
"fonts for windows
set guifont=Iosevka
"set guifont="Sauce Code PowerLine"
set gfw=Iosevka
"encoding begin
set fileformat=unix
set fileencodings=ucs-bom,utf-8,cp936,chinese,latin-1 "detect
set encoding=utf-8 "buffer
set termencoding=utf-8
"End encoding
"%F%m%r%h%w fullpath
set statusline=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}\_%{&ff}\_%Y\][%L=%l,%v\_%p%%]\ %{strftime(\"%d/%m/%H:%M\")}\ %m%R\ %<%=%F%h%w
set laststatus=2
" Theme
set background=dark
"colorscheme lucius
colorscheme jellybeans
" LuciusBlack
if !has("gui_running")
    set term=xterm
    set t_Co=256
    colorscheme desert
endif

highlight LineNR ctermfg=DarkMagenta guifg=#336600 guibg=#000000
highlight StatusLine guifg=#669900 guibg=#000000
set directory=$VIM/swap,.,~/tmp " swap file
"show Show invisibles
set list
set listchars=eol:¬,tab:>-,trail:•,extends:>,precedes:<,
"syn match 0x20Spaces ' ' 
"hi 0x20Spaces guibg=#000300
"Invisible character colors
highlight NonText guifg=#666633
highlight SpecialKey guifg=#669966
"End Show invisibles
iab xdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>
imap <F5> <Esc> :w<CR> :GoRun<CR>
map <F5> <Esc> :w<CR> :GoRun<CR>
