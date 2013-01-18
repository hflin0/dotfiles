set tabstop=2
se softtabstop=2
set autoindent
set expandtab
set shiftwidth=2
autocmd FileType make set noexpandtab

if has("autocmd")
  filetype indent on
endif

filetype plugin on
set ofu=syntaxcomplete#Complete

set number

set nolinebreak
set background=light
set showmatch
set autochdir
set shortmess=atI
set cursorline

hi CursorLine   cterm=NONE ctermbg=darkgray ctermfg=cyan guibg=darkgray guifg=cyan
