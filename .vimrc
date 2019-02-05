
set tabstop=4
set softtabstop=4
set autoindent
"set smartindent
set expandtab
set shiftwidth=4
set smarttab
set laststatus=2
syntax on

autocmd FileType make set noexpandtab
autocmd FileType python setlocal et sta sw=4 sts=4
"tab显示为红色
autocmd FileType python match ErrorMsg /\s*\t/
"autocmd FileType javascript set sw=2
"autocmd FileType vue set sw=2
"
set tags=./tags;/


set foldmethod=indent
set foldlevel=99


set hls


if has("autocmd")
  filetype indent on
endif

execute pathogen#infect()
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
    "call append(3, "from __future__ import unicode_literals")
    "call append(4, "from __future__ import absolute_import")
endf

auto BufNewFile *.vue call VueInit()
func VueInit()
    call append(1, "<template>")
    call append(2, "</template>")
    call append(3, "")
    call append(4, "<script>")
    call append(5, "</script>")
    call append(6, "")
    call append(7, "<style>")
    call append(8, "</style>")
endf

noremap <F1> <Esc>
noremap <F2>  :set number!<CR>
nnoremap <F3> :set list!<CR>
nnoremap <F4> :set paste!<CR>o

" 关闭上下左右按键
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

map <C-n> :NERDTreeToggle<CR>
map <D-p>  <C-p>

" press space to fold/unfold code
nnoremap <space> za

set nocompatible
vnoremap <space> zf


"winpos 5 5 
"set mouse=a "不带行号

"autocmd InsertLeave * se nocul  " 用浅色高亮当前行
"autocmd InsertEnter * se cul    " 用浅色高亮当前行

set showcmd         " 输入的命令显示出来，看的清楚些

" NERDTree setting defaults to work around http://github.com/scrooloose/nerdtree/issues/489
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"let g:NERDTreeGlyphReadOnly = "RO"
"let g:NERDTreeNodeDelimiter = "#"
"
"ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.o,*/dist/*,*/node_modules/*


" emmet
let g:user_emmet_mode='a'
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue EmmetInstall

if $TERM_PROGRAM =~ "iTerm"
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

hi Search guibg=yellow guifg=wheat
hi LineNr ctermfg=245 ctermbg=235 

"set background=dark
set encoding=utf-8


