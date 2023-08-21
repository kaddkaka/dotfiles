let mapleader = " "

map <leader>e <cmd>Files $CHEZMOI_HOME<cr>
inoremap jk <esc>
inoremap kj <esc>
nnoremap <leader><leader> <C-^>

" Navigate quickfix list
nnoremap <a-j> <cmd>cnext<cr>
nnoremap <a-k> <cmd>cprev<cr>

" Stamping and substitute inside selection
nnoremap S "_ciw<c-r>"<esc>
xnoremap s :s/\%V
nmap <leader>p pgVr<space>
nmap <leader>P PgVr<space>

" makes * and # act on whole selection in visual mode ("very nomagic")
" allows to easily find weird strings like /*foo*/
function! g:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
xnoremap * :<c-u>call g:VSetSearch('/')<cr>/<c-r>=@/<cr><cr>
xnoremap # :<c-u>call g:VSetSearch('?')<cr>?<c-r>=@/<cr><cr>

nnoremap <leader>g :Ggrep -q <c-r><c-w>
nnoremap <leader>G :Ggrep -q <c-r><c-w> -- <c-r>%
nnoremap <leader>/ <cmd>nohlsearch<cr>
nnoremap gV `[v`]
nnoremap gb :Git blame<cr>

" Repeat the last : command
nnoremap , @:
xnoremap , @:

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'

Plug 'rebelot/kanagawa.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'alaviss/nim.nvim'
Plug 'mfussenegger/nvim-lint'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
"Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'michaeljsmith/vim-indent-object'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'folke/twilight.nvim'

Plug 'jbyuki/venn.nvim'
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'numToStr/Navigator.nvim'
Plug 'habamax/vim-rst'

Plug 'jpalardy/vim-slime'
Plug 'anuvyklack/pretty-fold.nvim'
call plug#end()

colorscheme kanagawa

lua require("twilight").setup()
lua require("Navigator").setup()
nnoremap <a-h> <cmd>NavigatorLeft<cr>
nnoremap <a-l> <cmd>NavigatorRight<cr>
nnoremap <a-left>  <cmd>NavigatorLeft<cr>
nnoremap <a-right> <cmd>NavigatorRight<cr>
lua require("pretty-fold").setup()

"Plug 'inkarkat/vim-JumpToVerticalOccurrence'
"Plug 'MunifTanjim/nui.nvim'
"Plug 'rcarriga/nvim-notify'
"Plug 'folke/noice.nvim'

map <leader>b <cmd>Buffers<cr>
map <leader>f <cmd>GFiles<cr>
map <leader>F <cmd>Files<cr>
map <leader>l <cmd>Files %:h<cr>
map <leader>L <cmd>Lines<cr>
map <leader>t <cmd>BTags<cr>
map <leader>T <cmd>Tags<cr>

augroup netrw
  autocmd!
  autocmd FileType netrw nmap <buffer> <leader>l <cmd>execute("Files " .. g:netrw_dirhist_0)<cr>
augroup END

"vim-easy-align, see :h EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

lua require('plugins')
runtime 'mediatek.vim'

let g:slime_target = "wezterm"

"Creating some new text objects:
onoremap <silent> iT :<C-U>normal! vit<space>kojV<CR>
onoremap h[ :<c-u>normal! m'vi[``<cr>
onoremap l[ :<c-u>normal! m'vi[o``<cr>
onoremap h{ :<c-u>normal! m'vi{``<cr>
onoremap l{ :<c-u>normal! m'vi{o``<cr>
onoremap h( :<c-u>normal! m'vi(``<cr>
onoremap l( :<c-u>normal! m'vi(o``<cr>

"let g:fzf_action = {'ctrl-q': 'fill_quickfix'}

nnoremap <silent> gR <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gA <cmd>lua vim.lsp.buf.code_action()<cr>
xnoremap <silent> gA <cmd>lua vim.lsp.buf.range_code_action()<cr>
nnoremap <silent> gk <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<cr>

" Treesitter: Toggle playground, check for parser
nnoremap <leader>tp <cmd>TSPlaygroundToggle<cr>
nnoremap <leader>tc <cmd>lua print(require'nvim-treesitter.parsers'.has_parser())<cr>
nnoremap <leader>tt <cmd>TroubleToggle<cr>
nnoremap <leader>tl <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>

augroup init_group
  autocmd!
  autocmd BufWritePost ~/.local/share/chezmoi/[^.]* ! chezmoi apply --source-path <afile>
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
  autocmd BufWritePost,BufNewFile,BufRead *.yaml lua require('lint').try_lint()
  "autocmd BufWritePost,BufNewFile,BufRead, bash lua require('lint').try_lint()

  autocmd FileType xml,cpp,vim,lua setlocal shiftwidth=2
  autocmd FileType systemverilog setlocal shiftwidth=3

  autocmd FileType groovy,rst syntax sync fromstart
  autocmd FileType rst,markdown setlocal textwidth=80

  " Trim trailing Whitespaces on save
  function! TrimWhitespace()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
  endfunction
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Command to refresh quickfix list:
"call setqflist(map(getqflist(), 'extend(v:val, {"text":get(getbufline(v:val.bufnr, v:val.lnum),0)})'))

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
set textwidth=100
set formatoptions-=t    " Don't automatically format code on insert

nnoremap <s-Up>    :resize +10<cr>
nnoremap <s-Down>  :resize -10<cr>
nnoremap <s-Left>  :vertical resize +20<cr>
nnoremap <s-Right> :vertical resize -20<cr>
nnoremap <c-Left>  :vertical resize +1<cr>
nnoremap <c-Right> :vertical resize -1<cr>

"au TermOpen term://* startinsert
"nnoremap <leader>ut <cmd>vsp term://tig %:p<cr>
"nnoremap <leader>ul :vsp term://tig -L<c-r>=line(".")<cr>,+1:%:p
"nnoremap <leader>uk <cmd>vsp term://kak %:p<cr>

command! -nargs=1 -range=% Matchdo call s:Matchdo(<line1>, <line2>, <q-args>)

" Function received from AndrewRadev from discussion at
" https://www.reddit.com/r/vim/comments/125dxi8/searchdo_a_friend_of_cdobufdowindo/
function! s:Matchdo(start_line, end_line, command) abort
  " Save the current cursor position, restore it after the function is over.
  let saved_view = winsaveview()

  let stopline = 0

  if a:start_line == 1
    " The range is the whole file, we start at the end of the file and wrap
    " around so we can cover a match at line 1, column 1:
    normal! G$
    let flags = 'w'
  else
    " we start just before the start line
    exe 'normal! ' .. (a:start_line - 1) .. 'G$'
    let flags = 'W'
    let stopline = a:end_line
  endif

  while search(@/, flags, stopline) > 0
    exe a:command

    " Move to the end of the changed text to avoid matching it again:
    normal! g`]

    let flags = 'W'
    let stopline = a:end_line
  endwhile

  call winrestview(saved_view)
endfunction

" Sorting examples:
" stable sort on column 3
"   :!sort -k3,3 -s
" sort on difference between field 2 and 1
"   :%!awk ' BEGIN{OFS="\t"} { print $2-$1, $0 | "sort -nr | uniq -f5" }'
" sort on length of line
"   :%!awk '{print length(), $0 | "sort -n | cut -d\\  -f2-" }'
