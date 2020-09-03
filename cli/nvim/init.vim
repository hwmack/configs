" Use the mouse
set mouse=a

syntax enable

" Line numbering
set relativenumber

" Tabbing behaviour:
set expandtab
set tabstop=4
set smartindent
set shiftwidth=4
set softtabstop=4
set autoindent

" Messaging qol
set cmdheight=2
set updatetime=300

set shortmess+=c
set signcolumn=yes

set nocompatible
filetype off
""""""""""""""""""""""""""""""""""""""""""""""
" Set up Plugins
""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" Color theme
Plug 'morhetz/gruvbox'

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Status bar
Plug 'vim-airline/vim-airline'

" Betty syntax highlighting
Plug 'sheerun/vim-polyglot'

" File formats
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'dag/vim-fish'
Plug 'plasticboy/vim-markdown'


call plug#end()

" Configure theme
set termguicolors
set background=dark
colorscheme gruvbox

" Shortcuts

" Configure tabbing behaviour
inoremap <S-Tab> <C-d>
nnoremap <S-Tab> <<
vnoremap <S-Tab> <<<Esc>gv
nnoremap <Tab> >>
vnoremap <Tab> >><Esc>gv

" Map to breaking and joining lines
nnoremap <C-J> i<CR><Esc>
nnoremap <C-K> <Esc>I<Backspace><Esc>l
inoremap <C-J> <CR>
inoremap <C-K> <Esc>I<Backspace>

" Map to pasting in insert
inoremap <C-P> <Esc>Pi

