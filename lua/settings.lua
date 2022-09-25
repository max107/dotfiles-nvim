-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local default_opts = { noremap = true, silent = true }

vim.g.mapleader = "\\"
vim.opt.swapfile = false
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false -- dont wrap lines
vim.opt.scrolloff = 8 -- is one of my fav

vim.opt.number = true -- Show line number
vim.opt.relativenumber = true -- Show line number
vim.opt.showmatch = true -- Highlight matching parenthesis
vim.opt.foldmethod = "marker" -- Enable folding (default 'foldmarker')
vim.opt.colorcolumn = "80" -- Line lenght marker at 80 columns
vim.opt.splitright = true -- Vertical split to the right
vim.opt.splitbelow = true -- Orizontal split to the bottom
vim.opt.ignorecase = true -- Ignore case letters when search
vim.opt.smartcase = true -- Ignore lowercase for the whole pattern
vim.opt.linebreak = false -- Wrap on word boundary

vim.opt.winminwidth = 0

-- Remove whitespace on save
vim.cmd([[au BufWritePre * :%s/\s\+$//e]])

-- Highlight on yank
vim.cmd(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=800}
  augroup end
]],
	false
)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
vim.opt.hidden = true -- Enable background buffers
vim.opt.history = 100 -- Remember N lines in history
vim.opt.lazyredraw = true -- Faster scrolling
vim.opt.synmaxcol = 240 -- Max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.cursorline = true

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Shift 4 spaces when tab
vim.opt.tabstop = 4 -- 1 tab == 4 spaces
vim.opt.smartindent = true -- Autoindent new lines

-- Don't auto commenting new lines
vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- 2 spaces for selected filetypes
vim.cmd([[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]])

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------

-- Insert mode completion options
vim.opt.completeopt = "menuone,noselect"

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------

-- Open a terminal pane on the right using :Term
vim.cmd([[command Term :botright vsplit term://$SHELL]])

-- Terminal visual tweaks:
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
vim.cmd([[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]])

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

-- Disable nvim intro
vim.opt.shortmess:append("sI")

-- Disable builtins plugins
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.cmd([[
" Only show the cursor line in the active buffer.
augroup CursorLine
		au!
		au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
		au WinLeave * setlocal nocursorline
augroup END
]])

vim.cmd([[
map <Leader>q :bd!<CR>
imap <Leader>q <ESC>:bd!<CR>
vmap <Leader>q <ESC>:bd!<CR>

map <Leader>x :x<CR>
imap <Leader>x <ESC>:x<CR>
vmap <Leader>x <ESC>:x<CR>

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

vim.cmd([[
augroup default
    au!
    " Make sure Kubernetes yaml files end up being set as helm files.
    au BufNewFile,BufRead *.{yaml,yml} if getline(1) =~ '^apiVersion:' || getline(2) =~ '^apiVersion:' | setlocal filetype=helm | endif
    autocmd BufNewFile,BufRead werf.yaml set syntax=helm
    autocmd BufNewFile,BufRead *.yaml set syntax=yaml
    autocmd BufNewFile,BufRead *.html.twig set syntax=html
    autocmd BufNewFile,BufRead *.babelrc set syntax=json
    autocmd BufNewFile,BufRead Dockerfile.* set syntax=dockerfile
    autocmd BufNewFile,BufRead *.dockerfile set syntax=dockerfile
    autocmd BufNewFile,BufRead *.tpl set syntax=php
    autocmd BufNewFile,BufRead *.ini set filetype=dosini
    autocmd BufNewFile,BufRead default set filetype=nginx
augroup END
]])

-- Clear search highlighting with <leader> and c
vim.api.nvim_set_keymap("n", "<leader>c", ":nohl<CR>", default_opts)

-- Fast saving with <leader> and s
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", default_opts)
vim.api.nvim_set_keymap("i", "<leader>w", "<C-c>:w<CR>", default_opts)

-- Move around splits using Ctrl + {h,j,k,l}
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", default_opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", default_opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", default_opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", default_opts)

-- Close all windows and exit from Neovim with <leader> and q
-- vim.api.nvim_set_keymap('n', '<leader>q', ':qa!<CR>', default_opts)

-- Open terminal
vim.api.nvim_set_keymap("n", "<C-t>", ":Term<CR>", { noremap = true })

-- nvim-tree
vim.api.nvim_set_keymap("n", "<leader>fr", ":NvimTreeFindFile<CR>", default_opts) -- open/close

vim.api.nvim_set_keymap("n", "<leader>fc", ":lua vim.lsp.buf.formatting_sync()<CR>", default_opts)
