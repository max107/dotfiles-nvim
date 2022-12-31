local default_opts = { noremap = true, silent = true }

-- Clear search highlighting with <leader> and c
vim.api.nvim_set_keymap("n", "<leader>c", ":nohl<CR>", default_opts)

-- Fast saving with <leader> and w
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", default_opts)
vim.api.nvim_set_keymap("i", "<leader>w", "<C-c>:w<CR>", default_opts)

vim.cmd([[
" fix for typo like :W or :Q
command! W write
command! Q quit

" Remap VIM 0 to first non-blank character
map 0 ^
" Remap VIM - to last non-blank character
map - $
" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
]])

-- Open terminal
vim.api.nvim_set_keymap("n", "<C-t>", ":Term<CR>", { noremap = true })
