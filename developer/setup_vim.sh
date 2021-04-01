#!/bin/bash

#vim-go
if [ ! -e ~/.vim/pack/plugins/start/vim-go ]; then
	echo " * Cloning vim-go"
	git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
else 
	echo " * Updating vim-go"
	cd ~/.vim/pack/plugins/start/vim-go
	git pull
fi
#nerdtree
if [ ! -e ~/.vim/pack/dist/start/nerdtree ]; then
	echo " * Cloning nerdtree"
	git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/dist/start/nerdtree
else 
	echo " * Updating nerdtree"
	cd ~/.vim/pack/dist/start/nerdtree
	git pull
fi
#vim-airline
if [ ! -e ~/.vim/pack/dist/start/vim-airline ]; then
	echo " * Cloning vim-airline"
	git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
else 
	echo " * Updating vim-airline"
	cd ~/.vim/pack/dist/start/vim-airline
	git pull
fi
#vim-fugitive 
if [ ! -e ~/.vim/pack/dist/start/vim-fugitive ]; then
	echo " * Cloning vim-fugitive"
	git clone https://github.com/tpope/vim-fugitive.git ~/.vim/pack/dist/start/vim-fugitive
else 
	echo " * Updating vim-fugitive"
	cd ~/.vim/pack/dist/start/vim-fugitive
	git pull
fi
#tagbar
if [ ! -e ~/.vim/pack/dist/start/tagbar ]; then
	echo " * Cloning tagbar"
	git clone https://github.com/preservim/tagbar.git ~/.vim/pack/dist/start/tagbar
else 
	echo " * Updating tagbar"
	cd ~/.vim/pack/dist/start/tagbar
	git pull
fi
#typescript-vim
if [ ! -e ~/.vim/pack/typescript/start/typescript-vim ]; then
	echo " * Cloning typescript-vim"
	git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/pack/typescript/start/typescript-vim
else 
	echo " * Updating typescript-vim"
	cd ~/.vim/pack/typescript/start/typescript-vim
	git pull
fi
#emmet-vim for developing html5 
if [ ! -e ~/.vim/pack/dist/start/emmet-vim ]; then
	echo " * Cloning emmet-vim"
	git clone https://github.com/mattn/emmet-vim.git ~/.vim/pack/dist/start/emmet-vim
else 
	echo " * Updating emmet-vim"
	cd ~/.vim/pack/dist/start/emmet-vim
	git pull
fi


exit 0

syntax on
colo pablo

" Flash screen instead of beep sound
set visualbell

" Change how vim represents characters on the screen
set encoding=utf-8

" Set the encoding of files written
set fileencoding=utf-8


autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
" ts - show existing tab with 4 spaces width
" sw - when indenting with '>', use 4 spaces width
" sts - control <tab> and <bs> keys to match tabstop

" Control all other files
set shiftwidth=4

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

" Hardcore mode, disable arrow keys.
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

filetype plugin indent on

" Allow backspace to delete indentation and inserted text
" i.e. how it works in most programs
set backspace=indent,eol,start
" indent  allow backspacing over autoindent
" eol     allow backspacing over line breaks (join lines)
" start   allow backspacing over the start of insert; CTRL-W and CTRL-U
"        stop once at the start of insert.


" go-vim plugin specific commands
" Also run `goimports` on your current file on every save
" Might be be slow on large codebases, if so, just comment it out
let g:go_fmt_command = "goimports"

" Status line types/signatures.
let g:go_auto_type_info = 1

"au filetype go inoremap <buffer> . .<C-x><C-o>

" If you want to disable gofmt on save
" let g:go_fmt_autosave = 0


" NERDTree plugin specific commands
:nnoremap <C-g> :NERDTreeToggle<CR>
"autocmd vimenter * NERDTree


" air-line plugin specific commands
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

