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
 set wildmode=list:longest,full

" Set the leader key
 let mapleader = ","

" ctrlp config
 let g:ctrlp_map = '<leader>f'
 let g:ctrlp_max_height = 30
 let g:ctrlp_working_path_mode = 0
 let g:ctrlp_match_window_reversed = 0

"Silver Searcher
 map <leader>a :Ag!<space>

" Hides buffer instead of closing them
 set hidden

" Indentation settings for using 2 spaces instead of tabs.
 set tabstop=2
 set shiftwidth=2
 set expandtab

 set encoding=utf-8

" Set a column at 80 character
" set colorcolumn=80

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

" run test with ,r
 function! RunFileWithRspec()
   exec ":!NO_DEPRECATIONS=1 bin/rspec %:p"
 endfunction

" run test with ,t
 function! RunTests(filename)
  :w
  :silent !clear
  if match(a:filename, '\.feature$') != -1
    exec ":!script/features " . a:filename
  elseif match(a:filename, '_test\.rb$') != -1
    exec ":!ruby -Itest " . a:filename
  else
    if filereadable("script/test")
      exec ":!script/test " . a:filename
    elseif filereadable("Gemfile")
      exec ":!bundle exec rspec --color " . a:filename
    else
      exec ":!rspec --color " . a:filename
    end
  end
 endfunction

 function! SetTestFile()
   let t:grb_test_file=@%
 endfunction

 function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
 endfunction

 function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number . " -b")
 endfunction

" run test runner
 map <leader>t :call RunTestFile()<cr>
 map <leader>T :call RunNearestTest()<cr>
 map <leader>r :call RunFileWithRspec()<cr>

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
