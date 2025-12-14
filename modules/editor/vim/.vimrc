" .vimrc - Vim optimizado para ThinkPad L420 (1366x768)
" Similar a init.vim pero para Vim clásico

" ===== CONFIGURACIÓN BÁSICA =====
set nocompatible
syntax on
filetype plugin indent on

" ===== OPTIMIZACIONES PANTALLA 1366x768 =====
" Números de línea
set number relativenumber

" Statusline siempre visible
set laststatus=2

" Tabline solo si hay >1 tab
set showtabline=1

" Command height reducido
set cmdheight=1

" ===== PERFORMANCE =====
set lazyredraw
set ttyfast
set updatetime=300
set timeoutlen=500
set synmaxcol=200

" ===== SPLITS =====
set splitbelow splitright
set fillchars=vert:│,fold:─

" ===== FUENTE (GUI) =====
if has('gui_running')
  set guifont=Cascadia\ Code:h9
  set guioptions-=T  " Sin toolbar
  set guioptions-=m  " Sin menubar
  set guioptions-=r  " Sin scrollbar derecha
  set guioptions-=L  " Sin scrollbar izquierda
endif

" ===== INDENTACIÓN =====
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" ===== BÚSQUEDA =====
set ignorecase
set smartcase
set incsearch
set hlsearch

" ===== CLIPBOARD =====
set clipboard=unnamedplus

" ===== MOUSE =====
set mouse=a

" ===== WRAP =====
set nowrap
set linebreak

" ===== BACKUP =====
set nobackup
set nowritebackup
set noswapfile

" ===== WILDMENU =====
set wildmenu
set wildmode=longest:full,full

" ===== COLORES =====
if has('termguicolors')
  set termguicolors
endif
set background=dark
silent! colorscheme desert

" ===== KEYMAPS =====
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>h :noh<CR>

" ===== STATUSLINE COMPACTO =====
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
