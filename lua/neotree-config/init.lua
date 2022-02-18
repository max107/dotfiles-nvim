require("neo-tree").setup({
	popup_border_style = "rounded",
	enable_git_status = false,
	enable_diagnostics = true,
	default_component_configs = {
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "ﰊ",
			default = "*",
		},
		name = {
			trailing_slash = true,
			use_git_status_colors = true,
		},
	},
	filesystem = {
		-- hijack_netrw_behavior = "open_split",
		filters = { --These filters are applied to both browsing and searching
			show_hidden = true,
			respect_gitignore = false,
		},
		follow_current_file = false, -- This will find and focus the file in the
		-- active buffer every time the current file is changed while the tree is open.
		use_libuv_file_watcher = true, -- This will use the OS level file watchers
		-- to detect changes instead of relying on nvim autocmd events.
		window = {
			position = "left",
			width = 32,
			mappings = {
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				["C"] = "close_node",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["I"] = "toggle_gitignore",
				["R"] = "refresh",
				["/"] = "filter_as_you_type",
				--["/"] = "none" -- Assigning a key to "none" will remove the default mapping
				["f"] = "filter_on_submit",
				["<c-x>"] = "clear_filter",
				["a"] = "add",
				["d"] = "delete",
				["r"] = "rename",
				["c"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
			},
		},
	},
	buffers = {
		show_unloaded = true,
		window = {
			position = "left",
			mappings = {
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["R"] = "refresh",
				["a"] = "add",
				["d"] = "delete",
				["r"] = "rename",
				["c"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["bd"] = "buffer_delete",
			},
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				["C"] = "close_node",
				["R"] = "refresh",
				["d"] = "delete",
				["r"] = "rename",
				["c"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
			},
		},
	},
})

vim.cmd([[nnoremap <F3> :NeoTreeFocusToggle<cr>]])
vim.cmd("nnoremap <leader>fr :NeoTreeReveal<cr>")
vim.cmd("nnoremap <F4> :NeoTreeShow buffers<cr>")

vim.cmd([[ hi link NeoTreeDirectoryName yellow ]])
vim.cmd([[ hi link NeoTreeDirectoryIcon yellow ]])
-- vim.cmd([[ hi link NeoTreeDirectoryName Directory ]])
-- vim.cmd([[ hi link NeoTreeDirectoryIcon NeoTreeDirectoryName ]])
