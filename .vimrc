""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Necessary for cool features of vim
set nocompatible

" Sets how many lines of history VIM has to remember and undolevels
set history=9999
set undolevels=9999

" If you want mouse support
set mouse=a

" Do not format 007 as oct number
set nrformats=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-plug
" Automatic installaion of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.vim/plugged')
" Latex
Plug 'lervag/vimtex'
" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsEditSplit="vertical"
" Snippets themselves
Plug 'honza/vim-snippets'
" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LaTeX config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg' 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UltiSnips configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips/'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the title of the terminal
set title

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Always show current position
set ruler

"This is the most awesome configurationa ever, is shows both
"the absolute and relative numbering together to make jumps
"easier
set number
" set relativenumber
nnoremap <silent><leader>n :set relativenumber!<cr>

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" How many tenths of a second to blink when matching brackets
set mat=4

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Mark the current line on entering insert mode
set cursorline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=>Search Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When searching try to be smart about cases
set smartcase
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" Don't open folds on search
set fdo-=search

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=>Fold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding is enabled by default
set foldenable

" Only very nested blocks will be folded
set foldlevelstart=2 " 99 means everything will open up

" The maximum nesting level
set foldnestmax=10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set utf8 as standard encoding and en_US as the standard language
set fileencoding=utf-8
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set to auto read when a file is changed from the outside
set autoread

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on
"
" Enable syntax highlighting
syntax enable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Be smart when using tabs ;)
set smarttab

" Migrated to editorconfig
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab "Converts tabs into space characters


" Textwrap at 120 haracters
"set tw=120
"set wrap

" Tab completion: mimics the behaviour of zsh
set wildmenu
set wildmode=list:longest,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.so,*.swp,*.zip,*/tmp/*

" Indentation
set autoindent "Auto indent
set smartindent "Smart indent

"Adding omnicomplete
set ofu=syntaxcomplete#Complete

" Set proper cursor depending on mode 
" Default is blinking block
let &t_ti.="\e[1 q"
let &t_te.="\e[0 q"
" For insert: blicking bar
let &t_SI.="\e[5 q"
" On exit insert: blinking block
let &t_EI.="\e[1 q"
" On replace mode: blinking underline
let &t_SR.="\e[3 q"

" Spell check
setlocal spell
set spelllang=en,ru
" Binding for text fix via <c-l>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

