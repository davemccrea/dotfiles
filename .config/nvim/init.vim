" Fish doesn't play all that well with others
set shell=/bin/bash

let mapleader = ","

set clipboard+=unnamedplus

" =============================================================================
" # vim-plug
" =============================================================================

set nocompatible
filetype off

call plug#begin()

" Colours
Plug 'chriskempson/base16-vim'

" Utilities
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'scrooloose/nerdtree'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'alvan/vim-closetag'
Plug 'jdhao/better-escape.vim'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}

call plug#end()

" =============================================================================
" # GUI settings
" =============================================================================

set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ttyfast
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals

" Deal with colors
set background=dark
let base16colorspace=256
colorscheme base16-gruvbox-dark-hard
syntax on
hi Normal ctermbg=NONE

" Sane splits
set splitright
set splitbelow

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Spaces & tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" =============================================================================
" # Shortcuts
" =============================================================================

" Move line(s) up or dow
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" insert blank line before current line without leaving insert mode
imap <leader>o <c-o><s-o>

" fix indentation
nnoremap <leader>i mzgg=G`z<CR>

" Quick-save and exit
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>x :x<CR>

" ; as :
nnoremap ; :

" Open new file adjacent to current file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" Buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

" Move by line
nnoremap j gj
nnoremap k gk

nmap <silent> <C-l> <C-l>:nohlsearch<CR>:match<CR>:diffupdate<CR>

" Split navigation
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

" =============================================================================
" Plugin settings
" =============================================================================

let g:better_escape_shortcut = 'jj'
let g:better_escape_interval = 200

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <C-p> <cmd>Telescope git_files<cr>

" Nerdtree
let g:NERDTreeChDirMode = 2  " Change cwd to parent node
let g:NERDTreeMinimalUI = 1  " Hide help text
let g:NERDTreeAutoDeleteBuffer = 1

" vim-closetag
let g:closetag_filetypes = 'html,xhtml,heex'

nnoremap <silent> <expr> <C-n> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

lua << EOF
require'lspconfig'.elixirls.setup{
cmd = { "/home/david/bin/elixir-ls/release/language_server.sh" };
}

require'nvim-treesitter.configs'.setup {
ensure_installed = "maintained",
highlight = {
enable = true,
},
}

require'compe'.setup {
enabled = true,
autocomplete = true,
debug = false,
min_length = 1,
preselect = "disabled",
throttle_time = 80,
source_timeout = 200,
incomplete_delay = 400,
max_abbr_width = 100,
max_kind_width = 100,
max_menu_width = 100,
documentation = true,
source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    treesitter = true
    }
}

require'lspconfig'.tsserver.setup{}
EOF
