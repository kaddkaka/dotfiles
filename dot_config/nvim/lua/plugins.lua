-- Setup for plugins

local ts = require('telescope')
ts.setup { extensions = { fzf = {
  override_generic_sorter = true,
  override_file_sorter = true,
}}}
ts.load_extension('fzf')

local lsp = require('lspconfig')
lsp.pylsp.setup { settings = { pylsp = { plugins = { pylint = { enabled = true }}}}}
lsp.clangd.setup { cmd = {"clangd", "--background-index", "--cross-file-rename"}}
lsp.nimls.setup{}

require('lint').linters_by_ft = {
  yaml = {'yamllint',}
}

require('nvim-treesitter.configs').setup {
  highlight = {enable=true, disable={"vim"}},
  playground = {enable=true},
}

require("trouble").setup { position = "right" }
