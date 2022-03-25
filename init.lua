require("settings")
require("plugins")

vim.cmd([[
autocmd FileType terraform setlocal commentstring=#\ %s
]])
