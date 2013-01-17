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
