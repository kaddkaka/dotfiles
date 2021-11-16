let mapleader = " "
noremap <leader>ev <cmd>e $MYVIMRC<cr>
inoremap jk <esc>
inoremap kj <esc>
nnoremap <leader><leader> <C-^>

" Navigate quickfix list and location list
nnoremap <a-j> <cmd>cnext<cr>
nnoremap <a-k> <cmd>cprev<cr>
nnoremap <c-j> <cmd>lnext<cr>
nnoremap <c-k> <cmd>lprev<cr>

" Stamping, overwrite paste and sub in selection
nnoremap S "_ciw<C-r>"<Esc>
xnoremap S "_dP
nnoremap <leader>R R^R0<Esc>
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
nnoremap <leader>g :Ggrep <c-r><c-w>
nnoremap <silent> <leader>/ <cmd>nohlsearch<CR>

" Repeat the last : command
nnoremap , @:
xnoremap , @:

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neovim/nvim-lspconfig'

Plug 'mhartington/oceanic-next'
"Plug 'nvim-neorg/neorg'
call plug#end()

colorscheme OceanicNext

map <leader>b <cmd>Buffers<CR>  
map <leader>f <cmd>GFiles<CR>  
map <leader>F <cmd>Files<CR>  
map <leader>l <cmd>Files %:h<CR>
map <leader>L <cmd>Lines<CR>

lua << EOF
require'lspconfig'.pylsp.setup{}
EOF

nnoremap <silent> gR <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.rename()<cr>

autocmd BufWritePost ~/.local/share/chezmoi/* silent! !chezmoi apply
autocmd BufWritePost /tmp/chezmoi-edit*       silent! !chezmoi apply
