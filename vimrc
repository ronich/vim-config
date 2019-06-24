" Basic configuration
set background=dark
colorscheme hybrid
set anti enc=utf-8
set guifont=Hack\ Regular:h11

syntax enable                   " enable syntax processing
set linebreak                   " Causes vim to not wrap text in the middle of a word
set pastetoggle=<F9>            " Useful so auto-indenting doesn't mess up code when pasting
filetype plugin indent on
set encoding=utf-8
set backspace=indent,eol,start
set clipboard=unnamed
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=2
set tabstop=2
set guioptions=	"remove scrollbars on macvim
set nocompatible              " required
set showmatch
set number
set rnu
filetype off                  " required
highlight BadWhitespace ctermbg=red guibg=red
let &colorcolumn="80,".join(range(120,999),",")

" Enable folding
nnoremap <space> za

" Enable fast searching nnoremap 
nnoremap <Leader>' :Ag<SPACE>
nnoremap <Leader>; :Ag!<CR>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" move swap files somewhere else
" set swapfile
set dir=~/tmp

" Add homebrew fzf to the vim path:
set rtp+=/usr/local/opt/fzf

" UTF-8
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'ervandew/supertab'
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
Plugin 'Yggdroot/indentLine'
Plugin 'jacoborus/tender.vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'lervag/vimtex'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Airline
let g:airline_theme='tender'

" Fix backspace
set backspace=indent,eol,start

" Splitting
set splitbelow
set splitright

" Easy file delete
nnoremap <leader>rm :call delete(expand('%')) \| bdelete!<CR>

" Tryharding - disable arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Alternative split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Navigating terminal
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

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
"    \ set textwidth=79 |
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

" enable per-command history
let g:fzf_history_dir = '~/.local/share/fzf-history'

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  try:
    exec(open(activate_this).read(), dict(__file__=activate_this))
  except:
    pass
EOF

let g:flake8_show_in_file=1  " show
let python_highlight_all=1
syntax on

highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg

"set background=dark
"colorscheme zenburn 

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd vimenter * NERDTree
:let g:NERDTreeWinSize=60
nmap <F6> :NERDTreeToggle<CR>

au VimEnter * wincmd l

" don't convert math symbols in latex
let g:tex_conceal = ""

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

"One clipboard
set clipboard=unnamed

""Custom
nnoremap gL :call python_label_thing#PythonGetLabel()<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
