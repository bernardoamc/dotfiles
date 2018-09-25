filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Packages
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-commentary'
Plugin 'kana/vim-textobj-user'
Plugin 'mileszs/ack.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'

" Additional language support
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elixir-lang/vim-elixir'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'plasticboy/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'rstacruz/sparkup'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'lambdatoast/elm.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'rhysd/vim-crystal'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'

" Colour schemes
Plugin 'trusktr/seti.vim'

call vundle#end()
filetype plugin indent on

set background=dark
let t_Co = 265
colorscheme seti

set shell=/bin/bash

set number
set ruler

" use the system clipboard
 set clipboard=unnamed

" enable bash style tab completion
 set wildmenu
 set wildmode=list:longest,full

" Set the leader key
 let mapleader = ","

"FZF
 set rtp+=/usr/local/opt/fzf
 map <leader>f :FZF<CR>

" Use rg instead of ack
 let g:ackprg = 'rg --vimgrep'

" vim-markdown
 let g:vim_markdown_folding_disabled = 1

" vim-json
 let g:vim_json_syntax_conceal = 0

" vim-ruby
 let g:ruby_indent_access_modifier_style = 'normal'
 let g:ruby_indent_assignment_style = 'variable'
 let g:ruby_indent_block_style = 'do'

" Hides buffer instead of closing them
 set hidden

" Indentation settings for using 2 spaces instead of tabs.
 set tabstop=2
 set shiftwidth=2
 set expandtab

 set encoding=utf-8

" Highlight searches
 set hlsearch

" Show matches as i type
 set incsearch

" Tab ou shift+tab numa selecao
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
 filetype plugin indent on

" map git commands
 map <leader>b :Gblame<cr>
 map <leader>y :!pbcopy<bar>pbpaste<cr>

"ctags
 set tags=./tags;/
 nnoremap <leader>. :CtrlPTag<cr>

" remap bufexplorer
 nnoremap <leader>e :BufExplorer<cr>

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
 set wildmode=list:longest,list:full
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

" toggle class methods
 map <leader>l :TlistToggle<cr>
 map <BS> :noh<CR>

" NerdTree
" NERDTree
 nnoremap <leader>t :NERDTreeToggle<CR>
