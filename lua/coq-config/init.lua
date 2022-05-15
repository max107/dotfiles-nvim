local remap = vim.api.nvim_set_keymap

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

vim.g.coq_settings = {
	auto_start = "shut-up",
	xdg = true,
	keymap = { recommended = false },
	clients = {
		tabnine = { enabled = true },
	},
	display = {
		preview = {
			border = "single",
			positions = { north = 2, south = 3, west = 4, east = 1 },
		},
	},
	keymap = {
		bigger_preview = "<C-b>",
		jump_to_mark = "C-m",
	},
}
