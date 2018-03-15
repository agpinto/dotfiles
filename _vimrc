set nocompatible " choose no compatibility with legacy vi
set encoding=utf-8 " sensible encoding
set showcmd " display incomplete commands
set shell=zsh


" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'https://github.com/vim-syntastic/syntastic.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()


" auto reload vimrc when editing it
autocmd! BufWritePost .vimrc source ~/.vimrc


" remember more commands and search history
set history=10000


"" User Interface
set number " need those line numbers
"set mouse=a
"set ttymouse=xterm2
set ruler " show the line/column number of the cursor position
set nowrap " don't wrap lines
set linebreak " break line for wrapping at end of a word
set expandtab " use spaces, not tabs (optional)
set tabstop=4 shiftwidth=4 " a tab is two spaces (or set this to 4)
set softtabstop=4
set backspace=indent,eol,start " backspace through everything in insert mode
set autoread " auto read when file is changed from outside
set clipboard=unnamed " yank to the system register (*) by default
set hid " hide abandon buffers in order to not lose undo history


"" Searching
set showmatch " cursor shows matching ) and }
set hlsearch " highlight matches
set incsearch " incremental searching
set ignorecase " searches are case insensitive...
set smartcase " ... unless they contain at least one capital letter


"" Colors
set term=xterm-256color
syntax enable
if has('gui_running')
  set background=light
else
  set background=dark
endif
colorscheme solarized " can't work with anything else
"highlight LineNr ctermfg=darkgrey
set cursorline " highlight current line
set list " turn on invisible characters
set listchars=tab:▸\ ,trail:▝ " which characters to highlight
"highlight NonText guifg=#444444
"highlight SpecialKey guifg=#444444
set t_Co=256 " 256 color mode
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/ "highlight everything after 81 characters

" Window
set laststatus=2 " always have a status line
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set showtabline=2 " always show tab bar

" Syntax checking
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


