let mapleader = " "

" Quick way to edit config file(s)
map <leader>e <cmd>Files $CHEZMOI_HOME<cr>
"map <leader>e <cmd>e $MYVIMRC<cr>
map <leader>w <cmd>w<cr>

" Convenient way to exit insert mode
inoremap kj <esc>
" Swap to previous ("alternate") buffer
noremap <leader><leader> <C-^>

" Navigate quickfix list
nnoremap <a-j> <cmd>cnext<cr>
nnoremap <a-k> <cmd>cprev<cr>
nnoremap <a-J> <cmd>cnfile<cr>
nnoremap <a-K> <cmd>cNfile<cr>

" Stamping and substitute inside selection
nnoremap S "_ciw<c-r>"<esc>
xnoremap s :s/\%V

" Repeat the last : command (warning: shadows builtin!)
nnoremap , @:
xnoremap , @:

" Repeat last change in all of file ("global repeat", similar to g&)
nnoremap g. :set nogdefault<cr> <bar> :%s//./g<cr> <bar> :set gdefault<cr>

" dim search highlight, count matches
nnoremap <leader>/ <cmd>nohlsearch<cr>
nnoremap <leader>n <cmd>%s///n<cr>

" select last changed text (similar to gv)
nnoremap gV `[v`]

call plug#begin()
" The best plugins
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'

" Restore regressions from treesitter
Plug 'https://github.com/andymass/vim-matchup'
let g:matchup_matchparen_offscreen = {}

" Great plugins
Plug 'rebelot/kanagawa.nvim'
Plug 'junegunn/vim-easy-align'  " EasyAlign
Plug 'nvim-treesitter/nvim-treesitter-context'

" Good plugins
Plug 'mfussenegger/nvim-lint'
Plug 'dhruvasagar/vim-table-mode'

" Trial mode
Plug 'https://github.com/jmbuhr/otter.nvim'

" Useful plugins/Plugins in evaluation
Plug 'tpope/vim-abolish'  " smartcase replace
Plug 'tpope/vim-repeat'   " repeat complex commands
Plug 'michaeljsmith/vim-indent-object'  " indent textobject
"Plug 'echasnovski/mini.indentscope'     " indent textobject
Plug 'https://github.com/ColinKennedy/cursor-text-objects.nvim'
Plug 'kyazdani42/nvim-web-devicons' " icons (needed?)
Plug 'folke/trouble.nvim'           " collect diagnostics and report source
Plug 'folke/twilight.nvim'          " limielight, focused highlighting
Plug 'jbyuki/venn.nvim'             " draw ascii diagrams
Plug 'powerman/vim-plugin-AnsiEsc'  " Adds annoying bindings (starting w. <leader>)
Plug 'numToStr/Navigator.nvim'      " pane/windows navigation
Plug 'habamax/vim-rst'              " restructured text
Plug 'jpalardy/vim-slime'           " interact with split terminal?
Plug 'anuvyklack/pretty-fold.nvim'  " fold and only keep 1 line
Plug 'p00f/godbolt.nvim'            " compiler explorer
Plug 'dccsillag/magma-nvim'         " jupyter related
Plug 'mfussenegger/nvim-dap'        " debug adapter protocol
Plug 'protesilaos/tempus-themes'    " colorscheme
Plug 'stevearc/oil.nvim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
"Plug 'inkarkat/vim-JumpToVerticalOccurrence'
"Plug 'MunifTanjim/nui.nvim'
"Plug 'rcarriga/nvim-notify'
"Plug 'folke/noice.nvim'
call plug#end()

colorscheme kanagawa

lua vim.diagnostic.config({virtual_text={format=function(d) return "" end}, signs=false})
nnoremap <c-j> <cmd>lua vim.diagnostic.goto_next({float={source=true}})<cr>
nnoremap <c-k> <cmd>lua vim.diagnostic.goto_prev({float={source=true}})<cr>

" fugitive settings (see also :G :Gvdiffsplit master:%)
nnoremap <leader>g :Ggrep -q <c-r><c-w>
nnoremap <leader>G :Ggrep -q <c-r><c-w> -- <c-r>%
nnoremap gb <cmd>Git blame<cr>

" fzf settings (see also :Lines :Tags :Btags) l=directory local files
nnoremap <leader>b <cmd>Buffers<cr>
nnoremap <leader>f <cmd>GFiles<cr>
nnoremap <leader>F <cmd>Files<cr>
nnoremap <leader>l <cmd>Files %:h<cr>
nnoremap <leader>h <cmd>call fzf#run({'source': 'fd . -H', 'sink': 'e'})<cr>
"let g:fzf_action = {'ctrl-q': 'fill_quickfix'}
let g:fzf_preview_window = ['hidden', 'ctrl-o']
let g:fzf_history_dir = '~/.local/share/fzf-history'

"vim-easy-align, see :h EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

onoremap [ <Plug>(cursor-text-objects-up)
onoremap ] <Plug>(cursor-text-objects-down)
xnoremap [ <Plug>(cursor-text-objects-up)
xnoremap ] <Plug>(cursor-text-objects-down)

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
  autocmd BufNewFile,BufRead *.module set filetype=tcl
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
set list listchars=tab:\|\ ,trail:. " show tabs and trailing whitespace
set gdefault            " for :substitute, use the /g flag by default
set mouse=
set formatoptions-=t    " Don't automatically format code on insert
let g:markdown_folding=1

"lua require("otter").setup()
lua require("twilight").setup()
lua require("pretty-fold").setup()

lua require("Navigator").setup()
nnoremap <a-h> <cmd>NavigatorLeft<cr>
nnoremap <a-l> <cmd>NavigatorRight<cr>
nnoremap <s-Up>    :resize +10<cr>
nnoremap <s-Down>  :resize -10<cr>
nnoremap <s-Left>  :vertical resize +20<cr>
nnoremap <s-Right> :vertical resize -20<cr>

let g:slime_target = "wezterm"

lua require('plugins')
runtime mediatek.vim

nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> <leader>R <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>t <cmd>lua vim.lsp.buf.type_definition()<cr>

" Treesitter: Toggle playground/InstepctTree, populate loclist
nnoremap <leader>tp <cmd>InspectTree<cr>
nnoremap <leader>tl <cmd>lua vim.diagnostic.setqflist()<cr>

" Sorting examples:
" stable sort on column 3
"   :!sort -k3,3 -s
" sort on difference between field 2 and 1
"   :%!awk ' BEGIN{OFS="\t"} { print $2-$1, $0 | "sort -nr | uniq -f5" }'
" sort on length of line
"   :%!awk '{print length(), $0 | "sort -n | cut -d\\  -f2-" }'

" Creating some new text objects:
onoremap <silent> iT :<C-U>normal! vit<space>kojV<CR>

" makes * and # act on whole selection in visual mode ("very nomagic")
" allows to easily find weird strings like /*foo*/
function! g:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
" warning: shadows builtins!
xnoremap * :<c-u>call g:VSetSearch('/')<cr>/<c-r>=@/<cr><cr>
xnoremap # :<c-u>call g:VSetSearch('?')<cr>?<c-r>=@/<cr><cr>
