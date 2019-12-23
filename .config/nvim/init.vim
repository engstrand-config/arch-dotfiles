let mapleader = ","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'christoomey/vim-sort-motion'
Plug 'dylanaraps/wal.vim'
Plug 'https://github.com/neovimhaskell/haskell-vim.git'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'spf13/vim-autoclose'
Plug 'alvan/vim-closetag'

call plug#end()

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
set tabstop=4
set shiftwidth=4
set expandtab

filetype plugin on
filetype plugin indent on
syntax on

let g:autoclose_vim_commentmode = 1
let g:UltiSnipsExpandTrigger="<S-Tab>"
let g:UltiSnipsJumpForwardTrigger="-"
let g:lightline = {
	\'colorscheme': 'wal',
	\ }

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Nerd tree
map <leader>b :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap c "_c

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Shortcut for finding a parenthesis and changing its content from anywhere on a line
nnoremap <leader>p %ci(

" Shortcut for formatting document
nnoremap <leader>f gg=G

" Compile Haskell file using GHCi
nnoremap <leader>hb :!ghci %<CR>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

