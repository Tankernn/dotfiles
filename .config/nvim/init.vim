" ########## General ########## {{{
syntax on
colorscheme elflord
let g:airline_theme='atomic'
set encoding=utf-8
set fileencoding=utf-8
set wildmenu
set autoindent
set smartindent
set incsearch
set hlsearch
set smarttab
set ignorecase
set smartcase
set mouse=

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

" Tabs
set list
set listchars=tab:\|\ ,
" }}}

" ########## Keybinds ########## {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>f :FZF<cr>

nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gr :Git rebase -i

noremap <leader>c :w! \| !compiler <c-r>%<CR><CR>
noremap <leader>o :!open <c-r>%<CR><CR>
noremap <leader>p :!opout <c-r>%<CR><CR>

nnoremap <leader>u :!ctags -R .<CR>

" Local (scope) replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" Global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" Cscope keybinds
map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>

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
iabbrev @@ frans@tankernn.eu
iabbrev ssig -- <cr>Frans Bergman<cr>frans@tankernn.eu
" }}}

" ########## File-specific settings ########## {{{
autocmd FileType gitcommit,groff :set spell
autocmd FileType vim :set foldmethod=marker
autocmd BufNewFile,BufRead *.ms,*.me,*.mom,*.man set filetype=groff
" }}}

" ########## Plugin Settings ########## {{{
let g:ale_linters = {'rust': ['analyzer']}
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'rust': ['rustfmt'],
\}

nmap <leader>an <Plug>(ale_next)
nmap <leader>ap <Plug>(ale_previous)

augroup rust
    autocmd!
    autocmd FileType rust let b:delimitMate_smart_quotes='\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)\|\<\%#\|\&\%#'
augroup END

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}

" ########## Plugins ########## {{{
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mkitt/tabline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'raimondi/delimitmate'
Plug 'fisadev/dragvisuals.vim'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf'
Plug 'preservim/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'ashinkarov/nvim-agda'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()
" }}}
