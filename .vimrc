if has('vim_starting')
  set nocompatible               " Be iMproved
endif

call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'joshdick/onedark.vim'
Plug 'roman/golden-ratio'
Plug 'rking/ag.vim'
if isdirectory('/usr/bin/fzf')
  Plug '/usr/bin/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
call plug#end()

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Sets how many lines of history VIM has to remember
set history=500

filetype plugin indent on
filetype indent on

" Leader
let mapleader=','

" Fast saving
nmap <leader>w :w!<cr>

" Escape
inoremap <leader><leader> <Esc>

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch 

"" Directories for swp files
set nobackup
set noswapfile
set fileformats=unix,dos,mac

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" APPERANCES
syntax on
set ruler
set number
colorscheme onedark

" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" search map
map <space> /
map <c-space> ?
map <silent> <leader> :noh<cr>

" Indentation
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set nu

" FZF.
