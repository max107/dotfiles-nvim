local ok, _ = pcall(require, "nvim-tree")
if not ok then
	return
end

require("nvim-tree").setup()

local keymap = vim.keymap.set

keymap("n", "<F2>", "<cmd>NvimTreeToggle<cr>", { silent = true })
