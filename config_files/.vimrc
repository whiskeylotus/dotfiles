" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Security
set modelines=0

" Show line numbers
set number
set list
set listchars=tab:──→,nbsp:_,trail:·        " Print invisible chars
set listchars+=extends:→,precedes:←

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Tips
" When copy/pasting with line number on, use Ctrl to select your block
"
" When pasting to vim many lines, apply :set paste before

" Change shortcuts
" Move paragraph down
nnoremap ( {
" Move paragraph up
nnoremap ) }

" set register as system clipboard
" set clipboard^=unnamedplus

" Handle undofile across current buffer
set undodir=~/.cache/vim//
set undofile

" Trick to choose buffer quickly
nnoremap gb :ls<CR>:buffer<Space>
" previous buffer
nnoremap é :bprevious<CR>
" next buffer
nnoremap è :bnext<CR>

" Remove trailing space on save
autocmd BufWritePre *.rst :%s/\s\+$//e

" add colorcolumn for .rst
au BufReadPost *.rst set colorcolumn=80

autocmd BufRead *.rst set syntax=off

" indent unindent (check README.md)
vnoremap < <gv
vnoremap > >gv

colorscheme evening
