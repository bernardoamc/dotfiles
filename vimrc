execute pathogen#infect()

set shell=/bin/bash

set number
set ruler

" colors
set t_Co=256
color summerfruit256

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

" Set a column at 80 character
" set colorcolumn=80

" lightline Plugin
 set laststatus=2
 set noshowmode

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

 let g:go_highlight_functions = 1
 let g:go_highlight_methods = 1
 let g:go_highlight_fields = 1
 let g:go_highlight_types = 1
 let g:go_highlight_operators = 1
 let g:go_highlight_build_constraints = 1

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

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
