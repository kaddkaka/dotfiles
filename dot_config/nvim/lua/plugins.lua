-- Setup for plugins

--local ts = require('telescope')
--ts.setup { extensions = { fzf = {
--  override_generic_sorter = true,
--  override_file_sorter = true,
--}}}
--ts.load_extension('fzf')

vim.lsp.config('*',
  { on_attach = function(client) client.server_capabilities.semanticTokensProvider = nil end })
-- This is coupled with config files:
--   ~/.config/pycodestyle
--   ~/.config/pylintrc
vim.lsp.config('pylsp', { settings = { pylsp = { plugins = { pylint = { enabled = true }}}}})
vim.lsp.config('clangd', { cmd = {"clangd", "--clang-tidy", "--background-index", "--cross-file-rename"}})

--vim.lsp.enable('nimls')
vim.lsp.enable('zls')
vim.lsp.enable('pylsp')
vim.lsp.enable('clangd')

vim.lsp.config('rust_analyzer', { settings = {
  ["rust-analyzer"] = {
    checkOnSave = {
      command = "clippy",
      extraArgs = {
        "--target-dir", "$HOME/.cache/rust_analyzer",
        "--",
        "-W", "clippy::pedantic",
      }, }}}})

require('lint').linters_by_ft = {
  yaml = {'yamllint',}
  --c = {'comotidy',},
  --c = {'clangtidy',},
  --bash = {'shellcheck',},
}

require('nvim-treesitter.configs').setup {
  highlight = {enable=true, disable={"verilog"}},
}

require'treesitter-context'.setup {
  max_lines = 4,
  patterns = {
    default = { 'class', 'function', },
    cpp = { 'class_specifier', 'struct_specifier', },
    verilog = { 'function_declaration' },
  },
}

require("trouble").setup{}  -- { position = "right" }

require("godbolt").setup({
  languages = {
    cpp = { compiler = "g122", options = {} },
    c = { compiler = "cg122", options = {} },
    rust = { compiler = "r1650", options = {} },
    -- any_additional_filetype = { compiler = ..., options = ... },
  },
  quickfix = {
    enable = true, -- whether to populate the quickfix list in case of errors
    auto_open = false -- whether to open the quickfix list in case of errors
  },
  url = "https://godbolt.org" -- can be changed to a different godbolt instance
})
