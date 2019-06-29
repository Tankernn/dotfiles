" ########## General ########## {{{
syntax on
colorscheme peachpuff
let g:airline_theme='atomic'
set wildmenu
set autoindent
set smartindent
set incsearch
set smarttab
set smartcase

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

nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gr :Git rebase -i

noremap <leader>c :w! \| !compiler <c-r>%<CR>
noremap <leader>p :!opout <c-r>%<CR><CR>

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

" Dragvisuals keybinds
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1


" }}}

" ########## Abbreviations ########## {{{
iabbrev ret return
iabbrev @@ frans@tankernn.eu
iabbrev ssig -- <cr>Frans Bergman<cr>frans@tankernn.eu
" }}}

" ########## File-specific settings ########## {{{
autocmd FileType gitcommit,groff :set spell
autocmd FileType vim :set foldmethod=marker
autocmd BufNewFile,BufRead *.ms,*.me,*.mom,*.man set filetype=groff
" }}}

" ########## Plugins ########## {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mkitt/tabline.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'raimondi/delimitmate'
Plugin 'neomake/neomake'
Plugin 'fisadev/dragvisuals.vim'
Plugin 'maralla/completor.vim'
call vundle#end()
filetype plugin indent on    " required
" }}}

" ########## Plugin Settings ########## {{{
autocmd FileType java setlocal omnifunc=javacomplete#Complete
call neomake#configure#automake('nrwi', 500)
let g:neomake_open_list = 2
" }}}
