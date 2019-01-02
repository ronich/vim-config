syntax on
set nocompatible              " required
filetype off                  " required
highlight BadWhitespace ctermbg=red guibg=red

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" move swap files somewhere else
" set swapfile
set dir=~/tmp

" Add homebrew fzf to the vim path:
set rtp+=/usr/local/opt/fzf

" UTF-8
" UTF-8
" UTF-8
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'junegunn/fzf.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
set encoding=utf-8

" Fix backspace
set backspace=indent,eol,start

" Splitting
set splitbelow
set splitright

" Alternative split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" See the docstrings for folded code
let g:SimpylFold_docstring_preview=1

" Python indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Unnecessary whitespaces
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

let python_highlight_all=1
syntax on

"set background=dark
"colorscheme zenburn 

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd vimenter * NERDTree
au VimEnter * wincmd l

"Line Numbering
set nu

"One clipboard
set clipboard=unnamed

""Custom
nnoremap gL :call python_label_thing#PythonGetLabel()<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
