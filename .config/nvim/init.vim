" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
" Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-renderer-devicons.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'godlygeek/tabular'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'tacahiroy/ctrlp-funky'
Plug 'liuchengxu/vista.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jremmen/vim-ripgrep'
" Plug 'majutsushi/tagbar'
call plug#end()

" if executable('rg')
"   set grepprg=rg\ --color=never
"   let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
"   let g:ctrlp_use_caching = 0
" endif

" let g:fern#renderer = [ "devicons" ]
" let g:fern#renderers, { 'devicons': function('fern#renderer#devicons#new'), }

" let g:tagbar_compact = 1
" let g:tagbar_iconchars = ['+', '-']

let g:python_highlight_all = 1
let g:python_highlight_builtin_funcs = 0
let g:python_highlight_space_errors = 0

set updatetime=200

set ttimeout
set ttimeoutlen=50

set incsearch
set smartcase

set lazyredraw

set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list

let g:lightline = {
      \ 'colorscheme': 'seoul256'
      \ }

" Disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

let g:vista_fold_toggle_icons = ['+', '-']

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  if !isdirectory(expand('%'))
    return
  endif
  Fern %
endfunction

let mapleader=','
nnoremap <c-n> :Fern . -toggle -drawer<cr>
nnoremap <c-l> :noh<cr>
nnoremap <leader>s :mksession!<cr>
nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>
vnoremap <leader>t :Tab /
nnoremap <leader>t :Vista<cr>
" nnoremap <leader>v :Vista<cr>
inoremap jk <esc>
nnoremap <leader>gr :Rg<space>

" Default indentation settings
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
" Disable filetype-based indentation. Use simpler indentation rules instead,
" since they are less annoying.
filetype indent off
set autoindent
set smartindent
set copyindent

" set wrap
" set wrapmargin=120
" set textwidth=80

let g:cc_status = 0
set cc=
function ToggleCC()
    if g:cc_status == 1
        set cc=
        let g:cc_status = 0
    else
        set cc=80,100,120
        let g:cc_status = 1
    endif
endfunction
nnoremap <leader>c :call ToggleCC()<cr>

set number

set clipboard=unnamedplus
set wildmenu

set termguicolors
set background=dark
let g:seoul256_background = 235
colorscheme seoul256

" Some tweaks
highlight PMenu ctermbg=240 guibg=#585858 ctermfg=NONE guifg=NONE
highlight PmenuThumb ctermbg=249 guibg=#b2b2b2
highlight PmenuSbar ctermbg=234 guibg=#1c1c1c

" colorscheme alduin
