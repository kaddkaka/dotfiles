-- Setup for plugins

local ts = require('telescope')
ts.setup { extensions = { fzf = {
  override_generic_sorter = true,
  override_file_sorter = true,
}}}
ts.load_extension('fzf')

local lsp = require('lspconfig')
-- This is coupled with config files:
--   ~/.config/pycodestyle
--   ~/.config/pylintrc
lsp.pylsp.setup { settings = { pylsp = { plugins = { pylint = { enabled = true }}}}}
lsp.clangd.setup { cmd = {"clangd", "--clang-tidy", "--background-index", "--cross-file-rename"}}
lsp.nimls.setup{}
require'lspconfig'.rust_analyzer.setup { settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
                extraArgs = {
                    "--target-dir", "$HOME/.cache/rust_analyzer",
                    "--",
                    "-W", "clippy::pedantic",
                }, }}}}

require('lint').linters_by_ft = {
  yaml = {'yamllint',}
  --c = {'comotidy',},
  --c = {'clangtidy',},
  --bash = {'shellcheck',},
}

require('nvim-treesitter.configs').setup {
  highlight = {enable=true, disable={"verilog"}},
  playground = {enable=true},
}

require'treesitter-context'.setup {
  max_lines = 4,
  patterns = {
    default = { 'class', 'function', },
    cpp = { 'class_specifier', 'struct_specifier', },
    verilog = { 'function_declaration' },
  },
}

require("trouble").setup { position = "right" }

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
