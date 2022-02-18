-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
--local fn = vim.fn       				-- Call Vim functions
local cmd = vim.cmd -- Execute Vim commands
local exec = vim.api.nvim_exec -- Execute Vimscript
local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

g.mapleader = "\\"
opt.swapfile = false
opt.mouse = "a"
opt.clipboard = "unnamed"
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.number = true -- Show line number
opt.relativenumber = true -- Show line number
opt.showmatch = true -- Highlight matching parenthesis
opt.foldmethod = "marker" -- Enable folding (default 'foldmarker')
opt.colorcolumn = "80" -- Line lenght marker at 80 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Orizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = false -- Wrap on word boundary

-- Remove whitespace on save
cmd([[au BufWritePre * :%s/\s\+$//e]])

-- Highlight on yank
exec(
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
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.cursorline = true

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines

-- Don't auto commenting new lines
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- 2 spaces for selected filetypes
cmd([[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]])

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------

-- Insert mode completion options
opt.completeopt = "menuone,noselect"

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------

-- Open a terminal pane on the right using :Term
cmd([[command Term :botright vsplit term://$SHELL]])

-- Terminal visual tweaks:
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
cmd([[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]])

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

-- Disable nvim intro
opt.shortmess:append("sI")

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
	g["loaded_" .. plugin] = 1
end

vim.o.hlsearch = true
vim.o.incsearch = true

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
    autocmd BufNewFile,BufRead *.html.twig set syntax=html
    autocmd BufNewFile,BufRead *.babelrc set syntax=json
    autocmd BufNewFile,BufRead Dockerfile.* set syntax=dockerfile
    autocmd BufNewFile,BufRead *.tpl set syntax=php
    autocmd BufNewFile,BufRead *.ini set filetype=dosini
    autocmd BufNewFile,BufRead default set filetype=nginx
augroup END
]])

-- Clear search highlighting with <leader> and c
map("n", "<leader>c", ":nohl<CR>", default_opts)

-- Fast saving with <leader> and s
map("n", "<leader>w", ":w<CR>", default_opts)
map("i", "<leader>w", "<C-c>:w<CR>", default_opts)

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h", default_opts)
map("n", "<C-j>", "<C-w>j", default_opts)
map("n", "<C-k>", "<C-w>k", default_opts)
map("n", "<C-l>", "<C-w>l", default_opts)

-- Close all windows and exit from Neovim with <leader> and q
-- map('n', '<leader>q', ':qa!<CR>', default_opts)

-- Open terminal
map("n", "<C-t>", ":Term<CR>", { noremap = true })

-- nvim-tree
map("n", "<leader>fr", ":NvimTreeFindFile<CR>", default_opts) -- open/close
