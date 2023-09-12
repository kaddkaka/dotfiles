let mapleader = " "

" Quick way to edit config file(s)
map <leader>e <cmd>e $MYVIMRC<cr>

" Convenient way to exit insert mode
inoremap kj <esc>

" Navigate quickfix list
nnoremap <a-j> <cmd>cnext<cr>
nnoremap <a-k> <cmd>cprev<cr>

call plug#begin(stdpath('data') . '/small_plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
call plug#end()

colorscheme kanagawa

" fugitive settings
nnoremap gb <cmd>Git blame<cr>

" fzf settings
nnoremap <leader>b <cmd>Buffers<cr>
nnoremap <leader>f <cmd>GFiles<cr>
nnoremap <leader>F <cmd>Files<cr>
nnoremap <leader>l <cmd>Files %:h<cr>
let g:fzf_preview_window = ['hidden', 'ctrl-o']

augroup init_group
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }

  autocmd FileType xml,cpp,vim,lua setlocal shiftwidth=2
  autocmd FileType systemverilog setlocal shiftwidth=3

  autocmd FileType groovy,rst syntax sync fromstart
  autocmd FileType rst,markdown setlocal textwidth=80
augroup END

set cursorline          " highlight current line
set scrolloff=3         " number of screen lines to show around the cursor
set sidescrolloff=2     " min # of columns to keep left/right of cursor
set cmdheight=2         " cmdheight=2 helps avoid 'Press ENTER...' prompts
set nowrap              " don't wrap lines
set diffopt=filler,vertical  " options for diff mode
set lazyredraw          " Makes applying macros faster
set ignorecase
set smartcase           " ignore case when pattern is lowercase only
set expandtab           " replace tabs with spaces
set textwidth=100
set list listchars=tab:>-,trail:.

" treesitter (recomended ':TSInstall python', ':TSInstall cpp')
lua <<END
require('nvim-treesitter.configs').setup {
  highlight = {enable=true, disable={"verilog"}},
  playground = {enable=true},
}
END

" lsp settings
lua <<END
local lsp = require('lspconfig')
-- This is coupled with config files:
--   ~/.config/pycodestyle
--   ~/.config/pylintrc
lsp.pylsp.setup { settings = { pylsp = { plugins = { pylint = { enabled = true }}}}}
lsp.clangd.setup { cmd = {"clangd", "--clang-tidy", "--background-index", "--cross-file-rename"}}
END

nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> <leader>R <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>t <cmd>lua vim.lsp.buf.type_definition()<cr>
