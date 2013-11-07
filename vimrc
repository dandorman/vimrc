set nocompatible
filetype off

" bundles

set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"

Bundle "openssl.vim"

Bundle "guns/vim-clojure-static"
Bundle "kien/ctrlp.vim"
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
Bundle "noahfrederick/vim-hemisu"
Bundle "rking/ag.vim"
Bundle "tpope/vim-commentary"
Bundle "tpope/vim-fireplace"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-rails"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-sensible"
Bundle "tpope/vim-sleuth"
Bundle "tpope/vim-surround"
Bundle "vim-ruby/vim-ruby"

filetype plugin indent on

" settings

colorscheme hemisu
set background=dark

set backupdir=$HOME/.vimbackup,.
set cursorline
set directory=$HOME/.vimswap,.
set formatoptions=croqwanl
set gdefault
set hidden
set number
set visualbell
set wildmode=list:longest
set wildignore=.git,public/images,tmp,vendor,*.gif,*.jpeg,*.jpg,*.png

" autocommands

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" mappings

let mapleader = " "
let maplocalleader = " "

cnoremap w!! %!sudo tee > /dev/null %
cnoremap %% <C-R>=expand('%:h').'/'<CR>

nnoremap <Leader><Leader> <C-^>

nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" abbreviations

iabbrev dbg require "ruby-debug"; Debugger.start; debugger; 1
iabbrev bbg require "byebug"; byebug

" seeing is believing

function! SeeingIsBelievingGeneral()
  let cursor_pos = getpos(".")
  execute ":%!seeing_is_believing"
  call setpos(".", cursor_pos)
endfunction

function! SeeingIsBelievingSpecific()
  let cursor_pos = getpos(".")
  execute ":%!seeing_is_believing -x"
  call setpos(".", cursor_pos)
endfunction

function! SeeingIsBelievingClear()
  let cursor_pos = getpos(".")
  execute ":%s/\\s\\+# [=~]>.*$//e"
  silent execute ":g/^# [=~>]>/d"
  silent execute ":v/\\_s*\\S/d"
  call setpos(".", cursor_pos)
endfunction

nnoremap <Leader>ss :call SeeingIsBelievingGeneral()<CR>
nnoremap <Leader>sx :call SeeingIsBelievingSpecific()<CR>
nnoremap <Leader>sc :call SeeingIsBelievingClear()<CR>
