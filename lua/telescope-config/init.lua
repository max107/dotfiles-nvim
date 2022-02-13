local core = require("core")

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
local telescope = require("telescope")
telescope.setup({
	defaults = {
		-- prompt_position = "top",
		-- sorting_strategy = "ascending",
		-- file_ignore_patterns = {
		--     'node_modules',
		--     '.git',
		-- },
		file_ignore_patterns = {
			"public/build/.*",
			"node_modules",
			".git/.*",
			"symfony/var/.*",
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim",
			"--no-ignore",
			"--hidden",
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			previewer = false,
		},
		git_files = {
			hidden = true,
			previewer = false,
		},
		live_grep = {
			hidden = true,
			previewer = false,
			only_sort_text = true,
		},
		buffers = {
			previewer = false,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzf")

core.key_mapper("n", "<leader>ff", ":lua require'telescope.builtin'.find_files()<cr>")
core.key_mapper("n", "<leader>fp", ":lua require'telescope.builtin'.git_files()<cr>")
core.key_mapper("n", "<leader>fg", ":lua require'telescope.builtin'.live_grep()<cr>")
core.key_mapper("n", "<leader>fb", ":lua require'telescope.builtin'.buffers()<cr>")
