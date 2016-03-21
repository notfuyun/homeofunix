autocmd! bufwritepost _vimrc source ~/_vimrc
"Vundle
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=$HOME/vimfiles/bundle/Vundle.vim
call vundle#begin('$HOME/vimfiles/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



syntax on
set nocompatible " above vi
set smartindent
set confirm "tip
" set autowriteall
set number "line
" set textwidth=
set nowrap "break line
set numberwidth=1
set guifont=Consolas
set gfw="Source Han Sans HW TC"
"encoding begin
"set fileformat=unix
set fileencodings=ucs-bom,utf-8,cp936 "detect
set encoding=utf-8 "buffer
"End encoding
"%F%m%r%h%w fullpath
set statusline=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}\_%{&ff}\_%Y\][%L=%l,%v\_%p%%]\ %{strftime(\"%d/%m/%H:%M\")}\ %m%R\ %<%=%F%h%w
set laststatus=2
highlight StatusLine guifg=#000c00 guibg=#909f90
highlight LineNr guifg=#339933
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
