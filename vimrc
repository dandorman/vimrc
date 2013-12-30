set nocompatible
filetype off

" bundles

set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"

Bundle "openssl.vim"

Bundle "guns/vim-clojure-static"
Bundle "kchmck/vim-coffee-script"
Bundle "kien/ctrlp.vim"
Bundle "mustache/vim-mode"
Bundle "noahfrederick/vim-hemisu"
Bundle "othree/html5.vim"
Bundle "slim-template/vim-slim"
Bundle "tommcdo/vim-exchange"
Bundle "tpope/vim-commentary"
Bundle "tpope/vim-eunuch"
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

set backupdir=$HOME/.vimbackup,.
set cursorline
set directory=$HOME/.vimswap,.
set formatoptions=croqwanl
set gdefault
set hidden
set list listchars=tab:»·,trail:·
set visualbell
set wildmode=list:longest
set wildignore=.git,public/images,tmp,vendor,*.gif,*.jpeg,*.jpg,*.png

" search

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" autocommands

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

function! TrimWhiteSpace()
  let l:cursor = getpos(".")
  %s/\s\+$//e
  call setpos('.', l:cursor)
endfunction

autocmd BufWritePre * :call TrimWhiteSpace()
autocmd FileWritePre * :call TrimWhiteSpace()

" mappings

let mapleader = " "
let maplocalleader = " "

" save file with sudo
cnoremap w!! %!sudo tee > /dev/null %
" current file's directory
cnoremap %% <C-R>=expand('%:h').'/'<CR>

nnoremap <Leader><Leader> <C-^>

nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" search
nnoremap <Leader>g :Ag<SPACE>

" abbreviations

iabbrev dbg require "ruby-debug"; Debugger.start; debugger; 1
iabbrev bbg require "byebug"; byebug

" local overrides

let s:local_config = $HOME . "/.vimrc.local"
if filereadable(s:local_config)
  execute "source " . s:local_config
endif
