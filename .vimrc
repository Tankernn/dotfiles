" ########## General ########## {{{
syntax on
colorscheme peachpuff
let g:airline_theme='angr'
set wildmenu
set autoindent

set number relativenumber
set so=7

set tabstop=4 shiftwidth=4
set expandtab

let mapleader = ","
let maplocalleader = "\\"
" }}}

" ########## Highlighting ########## {{{
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup trailingwhitespace
    autocmd!
    autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
augroup END
" }}}

" ########## Keybinds ########## {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>f :tabfind ./**/

" Local (scope) replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" Global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

nnoremap Y y$
nnoremap H ^
nnoremap L $

vnoremap H ^
vnoremap L $

inoremap jk <esc>
inoremap <esc> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
" }}}

" ########## Abbreviations ########## {{{
iabbrev ret return
iabbrev @@ frans@tankernn.eu
iabbrev ssig -- <cr>Frans Bergman<cr>frans@tankernn.eu
" }}}

" ########## File-specific settings ########## {{{
autocmd FileType gitcommit :set spell
autocmd FileType vim :set foldmethod=marker
" }}}

" ########## Plugins ########## {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mkitt/tabline.vim'
Plugin 'valloric/youcompleteme'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'raimondi/delimitmate'
call vundle#end()
filetype plugin indent on    " required
" }}}
