" Vim - .vimrc mínimo
set nocompatible
syntax on
set number
set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamedplus

" Marcador para gestor de plugins básico (vim-plug)
if empty(glob('~/.vim/autoload/plug.vim'))
  " plug.vim no está instalado; instalar manualmente o ignorar
endif
