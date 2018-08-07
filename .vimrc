syntax on
set wildmenu

set number relativenumber

set tabstop=4

let mapleader = ","
let maplocalleader = "\\"

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>f :tabfind ./**/

nnoremap Y y$
nnoremap H ^
nnoremap L $

inoremap jk <esc>
inoremap <esc> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>

iabbrev ret return
iabbrev @@ frans@tankernn.eu
iabbrev ssig -- <cr>Frans Bergman<cr>frans@tankernn.eu
