set linebreak
set title
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 
" Show line numbers
"set number
" Auto newline
set tw=80
" visualise tabs and trailing spaces
set list
" Tabs to spaces
set tabstop=4
set shiftwidth=4
set expandtab

" code highlighting in markdown code thingies
let g:markdown_fenced_languages = ['bash=sh', 'javascript', 'js=javascript', 'json=javascript', 'typescript', 'ts=typescript', 'php', 'html', 'css', 'cpp', 'ruby', 'c', 'python', 'java' ]

" Plugins
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

"Plug 'arcticicestudio/nord-vim'
"Plug 'ghifarit53/tokyonight-vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Initialize plugin system
call plug#end()

" colours ^^
set termguicolors
"let g:tokyonight_style = 'storm' " available: night, storm
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight
"colorscheme nord
colorscheme onehalflight
let g:airline_theme='onehalflight'

