set nocompatible
filetype off

" bundles

set rtp+=$MYVIMDIR/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"

Bundle "mileszs/ack"
let g:ackprg = 'ag --nogroup --nocolor --column'
Bundle "kien/ctrlp"
Bundle "vim-scripts/openssl"
Bundle "tpope/vim-rails"
Bundle "tpope/vim-repeat"
Bundle "vim-ruby/vim-ruby"
Bundle "tpope/sensible"
Bundle "tpope/sleuth"
Bundle "tpope/surround"

filetype plugin indent on

" settings

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

nnoremap <Leader>p :CtrlP<CR>

nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" abbreviations

iabbrev dbg require "ruby-debug"; Debugger.start; debugger; 1

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
