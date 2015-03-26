set tabstop=4
set softtabstop=4
set autoindent
set expandtab
set shiftwidth=4

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

set t_Co=256
colorscheme desert

hi LineNr ctermfg=245 ctermbg=235 
set cursorline
hi CursorLine ctermbg=235 cterm=NONE guibg=Grey40
