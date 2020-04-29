let mapleader=' '

" Copy to system buffer
vnoremap <leader>c "+y
vnoremap <leader>с "+y
" Paste from system buffer
nnoremap <leader>v "+p
nnoremap <leader>м "+p

" Normal mode key remap
inoremap qq <ESC>
inoremap йй <ESC>

" Numbers
set number relativenumber

set ignorecase
set smartcase
set incsearch

set autoindent
set expandtab

" Backspace like in other programs
set backspace=indent,eol,start

" Numbers
set number relativenumber

" Search
set hlsearch
set incsearch

" New line in normal mode
nnoremap <C-Y> a<CR><Esc>k$

