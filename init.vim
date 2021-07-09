set shell=/bin/bash

set number
set ruler

" use the system clipboard
 set clipboard=unnamed

" enable bash style tab completion
 set wildmenu
" set wildmode=list:longest,full
 set wildmode=list:longest,list:full

" Set the leader key
 let mapleader = ","

"FZF
 set rtp+=/usr/local/opt/fzf
 map <leader>f :FZF<CR>
 map <leader>g :call fzf#run({'source': 'git diff --name-only $(git rev-parse --abbrev-ref HEAD)..master', 'sink': 'e'})<CR>

" Hides buffer instead of closing them
 set hidden

" Indentation settings for using 2 spaces instead of tabs.
 set tabstop=2
 set shiftwidth=2
 set expandtab

 set encoding=utf-8

" lightline Plugin
 set laststatus=2
 set noshowmode

call plug#begin()
  Plug 'lifepillar/vim-solarized8'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'junegunn/fzf.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'stefandtw/quickfix-reflector.vim'
  Plug 'jremmen/vim-ripgrep'
  Plug 'tpope/vim-surround'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdtree'
call plug#end()

" colors
set background=light
colorscheme solarized8

" NerdTree
 map <leader>t :NERDTreeToggle<CR>
 let g:NERDTreeShowLineNumbers=1
 let NERDTreeMinimalUI = 1

" Highlight searches
 set hlsearch

" Show matches as i type
 set incsearch

" Tab ou shift+tab in a selection
 vmap <Tab> >gv
 vmap <S-Tab> <gv

" shift+tab
 imap <S-Tab> <Esc><<i

" Remove whitespaces from the end of the line
 autocmd BufWritePre * :%s/\s\+$//e
 autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" Disable arrow keys
 map <up> <nop>
 map <down> <nop>
 map <left> <nop>
 map <right> <nop>

" Split screen navigation
 nnoremap <C-J> <C-W><C-J>
 nnoremap <C-K> <C-W><C-K>
 nnoremap <C-L> <C-W><C-L>
 nnoremap <C-H> <C-W><C-H>

 set nocompatible      " We're running Vim, not Vi!
 syntax on             " Enable syntax highlighting
 filetype on           " Enable filetype detection
 filetype plugin on    " Enable filetype-specific plugins

" map git commands
 map <leader>b :Gblame<cr>
 map <leader>l :!clear && git log -p %<cr>
 map <leader>d :!clear && git diff %<cr>
 map <leader>y :!pbcopy<bar>pbpaste<cr>

"ctags
set tags=./tags;/
nnoremap <leader>. :CtrlPTag<cr>

" remap bufexplorer
nnoremap <leader>e :BufExplorer<cr>

" remap ripgrep
nnoremap <leader>r :Rg
let g:rg_highlight = 1

" toggle class methods
map <leader>l :TlistToggle<cr>
map <BS> :noh<CR>

" let AsyncRun open quickfix window
let g:asyncrun_open = 8

" asm syntax to always e nasm
let g:asmsyntax = 'nasm'

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
