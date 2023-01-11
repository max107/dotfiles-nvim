-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------
-- Open a terminal pane on the right using :Term
vim.cmd([[command Term :botright split term://$SHELL]])

-- Terminal visual tweaks:
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
vim.cmd([[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]])
