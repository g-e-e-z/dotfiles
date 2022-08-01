echo "Hello - init.vim"
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set signcolumn=yes
set cmdheight=1
set colorcolumn=80
set cursorline

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
"	While the menu is active these keys have special meanings:
"
"	CTRL-Y		- accept the currently selected match and stop
"			  completion.
"	CTRL-E		- end completion, go back to what was there before
"			  selecting a match.
"	<Left> <Right>	- select previous/next match (like CTRL-P/CTRL-N)
"	<Down>		- in filename/menu name completion: move into a
"			  subdirectory or submenu.
"	<CR>		- in menu completion, when the cursor is just after a
"			  dot: move into a submenu.
"	<Up>		- in filename/menu name completion: move up into
"			  parent directory or parent menu.
"
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*



call plug#begin('~/local/share/nvim/plugged')
" Color Scheme
Plug 'gruvbox-community/gruvbox'

" Neovim Tree shitter -> Parser
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'


call plug#end()

"lua require("geezee")
"lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

colorscheme gruvbox
highlight Normal ctermbg=NONE guibg=NONE
hi CursorLineNr guifg=#fabd2f

let mapleader = " "
"nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
"nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
"nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
"nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
"nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>

nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

augroup GEEZ
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
