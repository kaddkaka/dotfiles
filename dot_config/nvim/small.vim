let mapleader = " "

" Quick way to edit config file(s)
map <leader>e <cmd>e $MYVIMRC<cr>
"map <leader>e <cmd>Files $CHEZMOI_HOME<cr>

" Convenient way to exit insert mode
inoremap kj <esc>

" Navigate quickfix list
nnoremap <a-j> <cmd>cnext<cr>
nnoremap <a-k> <cmd>cprev<cr>

" Stamping and substitute inside selection
nnoremap S "_ciw<c-r>"<esc>
xnoremap s :s/\%V

" Repeat the last : command (warning: shadows builtin!)
nnoremap , @:
xnoremap , @:

" Repeat last change in all of file ("global repeat", similar to g&)
nnoremap g. :%s//./&<esc>

" dim search highlight
nnoremap <leader>/ <cmd>nohlsearch<cr>

" select last changed text (similar to gv)
nnoremap gV `[v`]

call plug#begin(stdpath('data') . '/small_plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'rebelot/kanagawa.nvim'
Plug 'junegunn/vim-easy-align'  " EasyAlign
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'mfussenegger/nvim-lint'
Plug 'dhruvasagar/vim-table-mode'
Plug 'echasnovski/mini.indentscope'  " indent textobject
call plug#end()

colorscheme kanagawa

" fzf settings (see also :Lines :Tags :Btags) l=directory local files
nnoremap <leader>b <cmd>Buffers<cr>
nnoremap <leader>f <cmd>GFiles<cr>
nnoremap <leader>F <cmd>Files<cr>
nnoremap <leader>l <cmd>Files %:h<cr>
nnoremap <leader>h <cmd>call fzf#run({'source': 'fd . -H', 'sink': 'e'})<cr>
"let g:fzf_action = {'ctrl-q': 'fill_quickfix'}
let g:fzf_preview_window = ['hidden', 'ctrl-o']

" fugitive settings (see also :G :Gvdiffsplit master:%)
nnoremap <leader>g :Ggrep -q <c-r><c-w>
nnoremap <leader>G :Ggrep -q <c-r><c-w> -- <c-r>%
nnoremap gb <cmd>Git blame<cr>

" lsp bindings
nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> <leader>R <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>t <cmd>lua vim.lsp.buf.type_definition()<cr>

"vim-easy-align, see :h EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

augroup init_group
  autocmd!
  " Automatically apply update to config files with chezmoi
  autocmd BufWritePost ~/.local/share/chezmoi/[^.]* ! chezmoi apply --source-path <afile>
  " Trim trailing whitespace on save (circumvent w :noautocmd w)
  autocmd BufWritePre * let pos = getpos(".") | %s/\s\+$//e | call setpos(".", pos)
  " give feedback on yanked text
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
  " 'mfussenegger/nvim-lint' linters
  autocmd BufWritePost,BufNewFile,BufRead *.yaml lua require('lint').try_lint()
  " support <leader>l binding in :Explore
  autocmd FileType netrw nmap <buffer> <leader>l <cmd>execute("Files " .. b:netrw_curdir)<cr>
  " set some filetype specific options
  autocmd BufNewFile,BufRead *.vh set filetype=verilog
  autocmd FileType xml,cpp,vim,lua setlocal shiftwidth=2
  autocmd FileType verilog,systemverilog setlocal shiftwidth=3
  autocmd FileType groovy,rst syntax sync fromstart
  autocmd FileType rst,markdown setlocal textwidth=80  " narrower for prose
augroup END

" Command to refresh quickfix list:
"call setqflist(map(getqflist(), 'extend(v:val, {"text":get(getbufline(v:val.bufnr, v:val.lnum),0)})'))

set cursorline          " highlight current line
set scrolloff=3         " number of screen lines to show around the cursor
set sidescrolloff=2     " min # of columns to keep left/right of cursor
set cmdheight=2         " cmdheight=2 helps avoid 'Press ENTER...' prompts
set nowrap              " don't wrap lines
set lazyredraw          " Makes applying macros faster
set ignorecase
set smartcase           " ignore case when pattern is lowercase only
set expandtab           " replace tabs with spaces
set textwidth=100
set diffopt+=vertical   " options for diff mode
set list listchars=tab:>-,trail:.     " show tabs and trailing whitespace

set gdefault            " for :substitute, use the /g flag by default
set mouse=
set formatoptions-=t    " Don't automatically format code on insert
let g:markdown_folding=1

nnoremap <s-Up>    <cmd>resize +10<cr>
nnoremap <s-Down>  <cmd>resize -10<cr>
nnoremap <s-Left>  <cmd>vertical resize +20<cr>
nnoremap <s-Right> <cmd>vertical resize -20<cr>

lua <<END
local lsp = require('lspconfig')
lsp.util.default_config = vim.tbl_extend( "force", lsp.util.default_config,
  { on_attach = function(client) client.server_capabilities.semanticTokensProvider = nil end })
-- This is coupled with config files:
--   ~/.config/pycodestyle
--   ~/.config/pylintrc
lsp.pylsp.setup { settings = { pylsp = { plugins = { pylint = { enabled = true }}}}}
lsp.clangd.setup { cmd = {"clangd", "--clang-tidy", "--background-index", "--cross-file-rename"}}

-- treesitter (recommended ':TSInstall vim lua python cpp')
require('nvim-treesitter.configs').setup { highlight = {enable=true, disable={"verilog"}}}
require('treesitter-context').setup { max_lines = 4 }
require('lint').linters_by_ft = { yaml = {'yamllint'}}
require('mini.indentscope').setup {}
END
