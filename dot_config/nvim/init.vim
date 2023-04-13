let mapleader = " "
noremap <leader>ev <cmd>e $MYVIMRC<cr>
noremap <leader>eb <cmd>e ~/.bashrc<cr>
inoremap jk <esc>
inoremap kj <esc>
nnoremap <leader><leader> <C-^>

" Navigate quickfix list and location list
nnoremap <a-j> <cmd>cnext<cr>
nnoremap <a-k> <cmd>cprev<cr>
nnoremap <c-j> <cmd>lnext<cr>
nnoremap <c-k> <cmd>lprev<cr>

" Stamping, overwrite paste and sub in selection
nnoremap S "_ciw<c-r>"<esc>
xnoremap s :s/\%V

" makes * and # work in visual mode ("very nomagic")
function! g:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<c-u>call g:VSetSearch('/')<cr>/<c-r>=@/<cr><cr>
xnoremap # :<c-u>call g:VSetSearch('?')<cr>?<c-r>=@/<cr><cr>
nnoremap <leader>g :Ggrep -q <c-r><c-w>
nnoremap <leader>/ <cmd>nohlsearch<cr>
nnoremap <leader>gv `[v`]
nnoremap gb :Git blame<cr>

" Repeat the last : command
nnoremap , @:

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'

Plug 'mhartington/oceanic-next'

Plug 'neovim/nvim-lspconfig'
Plug 'alaviss/nim.nvim'
Plug 'mfussenegger/nvim-lint'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'michaeljsmith/vim-indent-object'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

Plug 'jbyuki/venn.nvim'
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'numToStr/Navigator.nvim'
call plug#end()

colorscheme OceanicNext

lua require("Navigator").setup()
nnoremap <a-h> <cmd>NavigatorLeft<cr>
nnoremap <a-l> <cmd>NavigatorRight<cr>
nnoremap <a-left>  <cmd>NavigatorLeft<cr>
nnoremap <a-right> <cmd>NavigatorRight<cr>

"Plug 'inkarkat/vim-JumpToVerticalOccurrence'
"Plug 'tommcdo/vim-fugitive-blame-ext'
"Plug 'hotwatermorning/auto-git-diff'
"let auto_git_diff_show_window_at_right = 1
"Plug 'nvim-neorg/neorg'
"Plug 'folke/twilight.nvim'

map <leader>b <cmd>Buffers<cr>
map <leader>f <cmd>GFiles<cr>
map <leader>F <cmd>Files<cr>
map <leader>l <cmd>Files %:h<cr>
map <leader>L <cmd>Lines<cr>
map <leader>T <cmd>Tags<cr>

augroup netrw
  autocmd!
  autocmd FileType netrw nmap <buffer> <leader>l <cmd>execute("Files " .. g:netrw_dirhist_0)<cr>
augroup END

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"telescope, lsp, treesitter, etc...
lua require('plugins')

nnoremap <silent> gR <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gA <cmd>lua vim.lsp.buf.code_action()<cr>

" Treesitter: Toggle playground, check for parser
nnoremap <leader>tp <cmd>TSPlaygroundToggle<cr>
nnoremap <leader>tc <cmd>lua print(require'nvim-treesitter.parsers'.has_parser())<cr>
nnoremap <leader>tt <cmd>TroubleToggle<cr>
nnoremap <leader>tl <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>

augroup init_group
  autocmd!
  autocmd BufWritePost ~/.local/share/chezmoi/* silent! !chezmoi apply
  autocmd BufWritePost /tmp/chezmoi-edit*       silent! !chezmoi apply

  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }

  autocmd BufWritePost,BufNewFile,BufRead *.yaml lua require('lint').try_lint()

  " Trim trailing Whitespaces on save
  function! TrimWhitespace()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
  endfunction
  autocmd BufWritePre * :call TrimWhitespace()
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
set gdefault            " for :substitute, use the /g flag by default
set expandtab           " replace tabs with spaces
set mouse=
"set list listchars=tab:>-,trail:.
"set grepprg=rg\ --vimgrep  " program for the :grep command
"set directory=/tmp,~/tmp,.,/var/tmp  " directories for swap file

nnoremap <s-Up>    :resize +10<cr>
nnoremap <s-Down>  :resize -10<cr>
nnoremap <s-Left>  :vertical resize +20<cr>
nnoremap <s-Right> :vertical resize -20<cr>

"au TermOpen term://* startinsert
"nnoremap <leader>ut <cmd>vsp term://tig %:p<cr>
"nnoremap <leader>ul :vsp term://tig -L<c-r>=line(".")<cr>,+1:%:p
"nnoremap <leader>uk <cmd>vsp term://kak %:p<cr>
