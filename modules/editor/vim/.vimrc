" Vim minimal .vimrc
set nocompatible
syntax on
set number
set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamedplus

" Basic plugin manager placeholder (vim-plug)
if empty(glob('~/.vim/autoload/plug.vim'))
  " plug.vim not installed; install manually or ignore
endif
