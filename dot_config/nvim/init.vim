let mapleader = " "
noremap <leader>ev <cmd>e $MYVIMRC<cr>
inoremap jk <esc>
inoremap kj <esc>

nnoremap <a-j> <cmd>cnext<cr>
nnoremap <a-k> <cmd>cprev<cr>

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neovim/nvim-lspconfig'

Plug 'mhartington/oceanic-next'
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
