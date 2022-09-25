require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	git = {
		enable = false,
		ignore = true,
		timeout = 500,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	view = {
		width = 25,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
})
