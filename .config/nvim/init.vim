call plug#begin()
	" Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    
    " Colorscheme
    Plug 'ellisonleao/gruvbox.nvim'

    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-commentary'
    Plug 'preservim/nerdtree'
call plug#end()

set path+=**

" colorscheme
set background="dark"
colorscheme gruvbox

filetype plugin indent on
syntax on

set nocompatible
set number
set encoding=UTF-8
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set hidden
set title
set undofile
set ignorecase
set smarttab
set cursorline
set nowrap
set backspace=start,eol,indent
set cmdheight=1

" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai
set si

" better tabbing
vnoremap < <gv
vnoremap > >gv

" window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" NerdTree
let g:NERDTreeWinSize=15
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" vim-airline
let g:airline#extensions#tabline#enabled = 1
