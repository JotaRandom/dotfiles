" init.vim - Neovim optimizado para ThinkPad L420 (1366x768)

" ===== CONFIGURACIÓN BÁSICA =====
set nocompatible
syntax on
file type plugin indent on

" ===== OPTIMIZACIONES PANTALLA 1366x768 =====
" Números de línea (relativos + absolutos)
set number relativenumber

" Combinar signcolumn con number column (ahorra 1 columna)
set signcolumn=number

" Statusline siempre visible
set laststatus=2

" Tabline solo si hay >1 tab (ahorra espacio vertical)
set showtabline=1

" Command height reducido
set cmdheight=1

" ===== PERFORMANCE (ThinkPad L420 limitado) =====
" No redibujar durante macros (más rápido)
set lazyredraw

" Tiempos de respuesta más rápidos
set updatetime=300
set timeoutlen=500

" Reducir syntax highlighting para performance
set synmaxcol=200

" ===== SPLITS OPTIMIZADOS =====
" Splits más naturales
set splitbelow splitright

" Caracteres de relleno minimalistas
set fillchars=vert:│,fold:─,diff:─

" ===== FUENTE (para GUI) =====
if has('gui_running')
  set guifont=Cascadia\ Code:h9
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
set termguicolors
set background=dark

" Esquema de colores (si está disponible)
silent! colorscheme monokai

" ===== KEYMAPS =====
" Leader
let mapleader = " "

" Guardar
nnoremap <leader>w :w<CR>

" Salir
nnoremap <leader>q :q<CR>

" Navegación entre splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Redimensionar splits (útil para 1366x768)
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-j> :resize -2<CR>

" Limpiar highlight
nnoremap <leader>h :noh<CR>

" ===== AUTOCOMMANDS =====
augroup OptimizedSettings
  autocmd!
  " Retornar a última posición al abrir archivo
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" ===== STATUSLINE COMPACTO =====
" Solo info esencial para pantalla pequeña
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
