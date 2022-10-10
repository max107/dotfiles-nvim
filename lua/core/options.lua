vim.cmd("autocmd!")

vim.g.loaded_ruby_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0

local cache_dir = os.getenv("HOME") .. "/.cache/nvim/"

-- vim.g.mapleader = "\\"
vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.lazyredraw = true -- Faster scrolling
-- vim.opt.cursorline = true
vim.opt.title = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
-- vim.opt.mouse = "a"
vim.opt.backspace = { "start", "eol", "indent" }
-- vim.opt.backspace = "indent,eol,start"
vim.opt.softtabstop = 4
-- vim.opt.softtabstop = -1
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding

vim.opt.termguicolors = true
vim.opt.mouse = "nv"
vim.opt.errorbells = true
vim.opt.visualbell = true
vim.opt.hidden = true
vim.opt.fileformats = "unix,mac,dos"
vim.opt.magic = true
vim.opt.virtualedit = "block"
vim.opt.encoding = "utf-8"
vim.opt.viewoptions = "folds,cursor,curdir,slash,unix"
vim.opt.sessionoptions = "curdir,help,tabpages,winsize"
-- vim.opt.clipboard = "unnamed"
vim.opt.clipboard = "unnamedplus"
vim.opt.wildignorecase = true
vim.opt.wildignore =
	".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/vendor/**,**/bower_modules/**"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.directory = cache_dir .. "swag/"
vim.opt.undodir = cache_dir .. "undo/"
vim.opt.backupdir = cache_dir .. "backup/"
vim.opt.viewdir = cache_dir .. "view/"
vim.opt.spellfile = cache_dir .. "spell/en.uft-8.add"
vim.opt.history = 2000
vim.opt.shada = "!,'300,<50,@100,s10,h"
vim.opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100
vim.opt.redrawtime = 1500
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.complete = ".,w,b,k"
vim.opt.inccommand = "nosplit"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --hidden --vimgrep --smart-case --"
vim.opt.breakat = [[\ \	;:,!?]]
vim.opt.startofline = false
vim.opt.whichwrap = "h,l,<,>,[,],~"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = "useopen"
vim.opt.diffopt = "filler,iwhite,internal,algorithm:patience"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.jumpoptions = "stack"
vim.opt.showmode = false
vim.opt.shortmess = "aoOTIcF"
vim.opt.scrolloff = 2
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.sidescrolloff = 5
vim.opt.foldlevelstart = 99
vim.opt.ruler = false
vim.opt.list = true
vim.opt.showtabline = 2
vim.opt.winwidth = 30
vim.opt.winminwidth = 10
vim.opt.pumheight = 15
vim.opt.helpheight = 12
vim.opt.previewheight = 12
vim.opt.showcmd = false
-- just for nightly
vim.opt.cmdheight = 2
vim.opt.cmdwinheight = 5
vim.opt.equalalways = false
vim.opt.laststatus = 2
vim.opt.display = "lastline"
vim.opt.showbreak = "↳  "
vim.opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
vim.opt.pumblend = 10
vim.opt.winblend = 10

vim.opt.undofile = true
vim.opt.synmaxcol = 2500
vim.opt.formatoptions = "1jcroql"
vim.opt.textwidth = 80
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.breakindentopt = "shift:2,min:20"
vim.opt.wrap = false
vim.opt.relativenumber = true -- Show line number
-- vim.opt.linebreak = true
vim.opt.linebreak = false -- Wrap on word boundary
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.foldenable = true
vim.opt.signcolumn = "yes"
vim.opt.conceallevel = 2
vim.opt.concealcursor = "niv"
vim.opt.showmatch = true -- Highlight matching parenthesis

if vim.loop.os_uname().sysname == "Darwin" then
	vim.g.clipboard = {
		name = "macOS-clipboard",
		copy = {
			["+"] = "pbcopy",
			["*"] = "pbcopy",
		},
		paste = {
			["+"] = "pbpaste",
			["*"] = "pbpaste",
		},
		cache_enabled = 0,
	}
	vim.g.python_host_prog = "/usr/bin/python"
	vim.g.python3_host_prog = "/usr/local/bin/python3"
end

-- Undercurl
-- vim.cmd([[let &t_Cs = "\e[4:3m"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m"]])

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

-- Only show the cursor line in the active buffer.
vim.cmd([[
augroup CursorLine
		au!
		au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
		au WinLeave * setlocal nocursorline
augroup END
]])

-- Remove whitespace on save
vim.cmd([[au BufWritePre * :%s/\s\+$//e]])

-- Don't auto commenting new lines
vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
