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
lsp.rust_analyzer.setup{}

require('lint').linters_by_ft = {
  yaml = {'yamllint',}
}

require('nvim-treesitter.configs').setup {
  highlight = {enable=true, disable={"vim", "verilog"}},
  playground = {enable=true},
}

--require'treesitter-context'.setup {
--  max_lines = 4,
--  patterns = {
--    default = {
--      'class',
--      'function',
--    },
--    cpp = {
--      'class_specifier',
--      'struct_specifier',
--    },
--    verilog = { 'function_declaration' },
--  },
--}

require("trouble").setup { position = "right" }
