-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local vim = vim
local home = os.getenv("HOME")
-- remove check is windows because I only use mac or linux
local cache_dir = home .. "/.cache/nvim/"

-- Create cache dir and subs dir
local createdir = function()
	local data_dir = {
		cache_dir .. "backup",
		cache_dir .. "session",
		cache_dir .. "swap",
		cache_dir .. "tags",
		cache_dir .. "undo",
	}
	-- There only check once that If cache_dir exists
	-- Then I don't want to check subs dir exists
	if vim.fn.isdirectory(cache_dir) == 0 then
		os.execute("mkdir -p " .. cache_dir)
		for _, v in pairs(data_dir) do
			if vim.fn.isdirectory(v) == 0 then
				os.execute("mkdir -p " .. v)
			end
		end
	end
end

createdir()

vim.opt.directory = cache_dir .. "swag/"
vim.opt.undodir = cache_dir .. "undo/"
vim.opt.backupdir = cache_dir .. "backup/"
vim.opt.viewdir = cache_dir .. "view/"
vim.opt.spellfile = cache_dir .. "spell/en.uft-8.add"

require("core.options")
require("core.groups")
require("core.disable")
require("core.keymap")
require("core.term")
