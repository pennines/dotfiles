" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'danilo-augusto/vim-afterglow'
" Plug 'itchyny/lightline.vim'
" Plug 'shinchu/lightline-gruvbox.vim'
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
" Plug 'gko/vim-coloresque'
" Plug 'lilydjwg/colorizer'
" Plug 'git@gitlab.com:yorickpeterse/happy_hacking.vim.git'
Plug 'yorickpeterse/happy_hacking.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'mhinz/vim-signify'
" Plug 'severin-lemaignan/vim-minimap'
" Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
call plug#end()

" :so $VIMRUNTIME/syntax/hitest.vim

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

set guicursor=

set updatetime=200

set ttimeout
set ttimeoutlen=50

set incsearch
set smartcase

set lazyredraw

set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list

" let g:lightline = {
"       \ 'colorscheme': 'seoul256'
"       \ }

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
nnoremap <c-l> :nohl<cr>
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
" set smartindent
set copyindent

" set wrap
" set wrapmargin=120
" set textwidth=80

let g:cc_status = 1
set cc=72,80,100
function ToggleCC()
    if g:cc_status == 1
        set cc=
        let g:cc_status = 0
    else
        set cc=72,80,100
        let g:cc_status = 1
    endif
endfunction
nnoremap <leader>c :call ToggleCC()<cr>

augroup fern-custom
  autocmd! *
  autocmd FileType fern set nonu
augroup END

set number

set clipboard=unnamedplus
set wildmenu

set statusline=
set statusline+=%-00.4(%m\ %)
set statusline+=%t
set statusline+=%=
set statusline+=[%l/%L]

set nowrap

set showmatch

set termguicolors
set background=dark
let g:seoul256_background = 233
colorscheme seoul256

" Some tweaks
highlight PMenu ctermbg=0 guibg=#3f3f3f ctermfg=NONE guifg=NONE
highlight PmenuThumb ctermbg=0 guibg=#f2f2f2
highlight PmenuSbar ctermbg=0 guibg=#8c8c8c
highlight VertSplit guifg=#141414 guibg=#141414
highlight Normal guibg=#141414
highlight LineNr guibg=#141414
highlight ColorColumn guibg=#202020
highlight StatusLineNC guibg=#4c4c4c guifg=#141414
highlight StatusLine guibg=#d0d0d0 guifg=#242424
highlight SignColumn guibg=#141414
highlight IndentGuidesEven guibg=#141414
highlight SignifySignAdd guibg=#141414 guifg=#5d8760
highlight SignifySignChange guibg=#141414 guifg=#88b0d5
highlight SignifySignDelete guibg=#141414 guifg=#ba3c38
" colorscheme alduin
