vim.cmd([[
if has('termguicolors')
		set termguicolors
endif
]])
vim.o.cursorline = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.lazyredraw = true
vim.o.smarttab = true
-- vim.o.shifttab = 4
vim.o.tabstop = 4
vim.o.autoindent = true
vim.o.cindent = true
-- vim.o.nowrap = true
vim.o.clipboard = "unnamed"
vim.o.number = true
vim.o.relativenumber = true

vim.cmd([[
" Only show the cursor line in the active buffer.
augroup CursorLine
		au!
		au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
		au WinLeave * setlocal nocursorline
augroup END
]])

vim.cmd([[
map <Leader>w :w<CR>
imap <Leader>w <ESC>:w<CR>
vmap <Leader>w <ESC><ESC>:w<CR>

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

require("plugins")
