" --------------------------------------
"                Plugins
" --------------------------------------
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'mhinz/vim-startify'

Plug 'dylanaraps/wal.vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'christoomey/vim-sort-motion'
Plug 'honza/vim-snippets'

" Language specific
Plug 'lervag/vimtex'
Plug 'heavenshell/vim-jsdoc'
Plug 'neovimhaskell/haskell-vim'

call plug#end()


" --------------------------------------
"             Vim config
" --------------------------------------
colorscheme wal

set bg=dark
set go=a
set mouse=a
set nohlsearch
set clipboard=unnamedplus
set wildmenu
set nocompatible
set encoding=utf-8
set number relativenumber
set splitbelow splitright
set title

" No need to show '-- INSERT --' because of lightline
set noshowmode

set signcolumn=no
set updatetime=300

set tabstop=2
set shiftwidth=2
set expandtab

filetype plugin on
filetype plugin indent on
syntax on

" --------------------------------------
"             General config
" --------------------------------------
let mapleader = ","
let b:signcolumn_on=0
let g:vimtex_compiler_latexmk_engine='xelatex'
let g:lightline = {
      \ 'colorscheme': 'wal',
      \ }

" --------------------------------------
"              Coc settings
" --------------------------------------
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Start autocomplete/move down list
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Move up in autocomplete list
inoremap <silent><expr> <S-Tab>
      \ pumvisible() ? "\<C-p>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Expand snippet on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use Alt+Tab to move forward in snippet
let g:coc_snippet_next = '<M-Tab>'


" --------------------------------------
"                Remaps
" --------------------------------------
nnoremap c "_c

" JsDoc
nmap <silent> <C-l> <Plug>(jsdoc)

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Replace all occurences of word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Shortcut for finding a parenthesis and changing its content from anywhere on a line
nnoremap <leader>p %ci(

" Shortcut for formatting document
nnoremap <leader>fi gg=G<CR>

" Compile Haskell file using GHCi
nnoremap <leader>hb :!ghci %<CR>

" Toggles the workspace on/off
nnoremap <leader>w :ToggleWorkspace<CR>

" Toggle gutter
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=auto
        let b:signcolumn_on=1
    endif
endfunction
nnoremap <leader>gs :call ToggleSignColumn()<CR>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" Disable the arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>


" --------------------------------------
"              Color fixes
" --------------------------------------
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" Change the color of comments
hi Comment ctermfg=9

" Change color of line numbers
hi LineNr ctermfg=1

" Change color of selected line number
hi CursorLineNr ctermfg=7

" Change the background color of highlighted matching tags
hi MatchParen ctermbg=2 ctermfg=0

" Change the colors for the dropdown menu for autocomplete
hi Pmenu ctermbg=0 ctermfg=3

" Fix the coloring of ; and : in CSS-files
hi CssNoise ctermfg=4

" --------------------------------------
"              Autocommands
" --------------------------------------
command Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" File type specific indentation guides
" Set tab width to 4 in python files
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" Automatically recompile dwm and dwmblocks.
autocmd BufWritePost */dwm/config.h !sudo make install && { killall -q dwm;setsid dwm & }
autocmd BufWritePost */dwmblocks/config.h !sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
