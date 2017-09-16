
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set smarttab
set hls
set laststatus=2
syntax on

autocmd FileType make set noexpandtab
autocmd FileType python setlocal et sta sw=4 sts=4
"tab显示为红色
autocmd FileType python match ErrorMsg /\s*\t/
set foldmethod=indent
set foldlevel=99


if has("autocmd")
  filetype indent on
endif

filetype plugin on
set ofu=syntaxcomplete#Complete

set number
set ruler

set nolinebreak
set background=light
set showmatch
set autochdir
set shortmess=atI
set shiftround

set t_Co=256
colorscheme desert

hi LineNr ctermfg=245 ctermbg=235 
"set cursorline
"hi CursorLine ctermbg=235 cterm=NONE guibg=Grey40

" python文件高亮显示行尾的空格，Tab

"记住上次打开的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
" 退出粘贴模式
au InsertLeave * set nopaste

auto BufNewFile *.py call PythonHeader()
func PythonHeader()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    call append(2, "")
    call append(3, "from __future__ import unicode_literals")
    call append(4, "from __future__ import absolute_import")
endf

noremap <F1> <Esc>
noremap <F2>  :set number!<CR>
nnoremap <F3> :set list!<CR>

" 关闭上下左右按键
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" press space to fold/unfold code
nnoremap <space> za
vnoremap <space> zf

