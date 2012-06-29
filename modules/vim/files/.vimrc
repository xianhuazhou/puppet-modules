if has("autocmd")
    filetype plugin indent on
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set nocompatible
set foldopen=all
set sm
set columns=80
set background=dark
set et
set softtabstop=4
set tabstop=4
set smarttab
set shiftwidth=4
set nobk
set nu
set backspace=indent,eol,start
set history=50
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
autocmd FileType text setlocal textwidth=80
set autoindent
au BufNewFile,BufRead *.twig set filetype=twig
au BufRead,BufNewFile *.js set syntax=jquery
au BufRead,BufNewFile *.tpl set filetype=smarty
au BufRead,BufNewFile *.pp set filetype=puppet

map <f2> :w<CR>:!php -f %<CR>
map <f3> :w<CR>:!ruby %<CR>
