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

" ===== KEYMAPS ESTILO NANO =====
" Ctrl+O = Guardar (WriteOut)
nnoremap <C-o> :w<CR>
inoremap <C-o> <Esc>:w<CR>a

" Ctrl+X = Salir (eXit)
nnoremap <C-x> :q<CR>
inoremap <C-x> <Esc>:q<CR>

" Ctrl+K = Cortar línea (Kut)
nnoremap <C-k> dd
inoremap <C-k> <Esc>ddi

" Ctrl+U = Pegar (Uncut)
nnoremap <C-u> p
inoremap <C-u> <Esc>pa

" Ctrl+W = Buscar (Where is)
nnoremap <C-w> /
inoremap <C-w> <Esc>/

" Ctrl+\ = Buscar y reemplazar
nnoremap <C-\> :%s/

" Ctrl+G = Ayuda
nnoremap <C-g> :help<CR>

" Navegación splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l

" ===== STATUSLINE COMPACTO =====
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
