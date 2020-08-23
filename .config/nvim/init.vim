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
noremap <leader>p :!opout <c-r>%<CR><CR>

nnoremap <leader>u :!ctags -R .<CR>

nnoremap <esc> :set nohlsearch<CR>

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
Plug 'maralla/completor.vim'
Plug 'junegunn/fzf'
Plug 'Chiel92/vim-autoformat'
Plug 'preservim/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()
" }}}

" ########## Plugin Settings ########## {{{
let g:ale_linters = {'rust': ['cargo', 'rls']}
let g:deoplete#enable_at_startup = 1

nmap <leader>an <Plug>(ale_next)
nmap <leader>ap <Plug>(ale_previous)

let g:completor_filetype_map = {}
" Enable lsp for rust by using rls
let g:completor_filetype_map.rust = {'ft': 'lsp', 'cmd': 'rls'}

augroup rust
    autocmd!
    autocmd FileType rust au BufWrite <buffer> :Autoformat
    autocmd FileType rust let b:delimitMate_smart_quotes='\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)\|\<\%#\|\&\%#'
augroup END

" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
" dictionary, source files, and completor to find matching words to complete.

" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete() abort
    " If completor is already open the `tab` cycles through suggested completions.
    if pumvisible()
        return "\<C-N>"
        " If completor is not open and we are in the middle of typing a word then
        " `tab` opens completor menu.
    elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^[[:keyword:][:ident:]]'
        return "\<C-R>=completor#do('complete')\<CR>"
    else
        " If we aren't typing a word and we press `tab` simply do the normal `tab`
        " action.
        return "\<Tab>"
    endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab to trigger auto completion.
inoremap <expr> <Tab> Tab_Or_Complete()
" }}}
