require("settings")
require("plugins")

-- lua vim.lsp.buf.formatting_sync()

vim.cmd([[
autocmd FileType terraform setlocal commentstring=#\ %s
]])
