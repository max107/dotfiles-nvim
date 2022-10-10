local ok, _ = pcall(require, "nvim-treesitter")
if not ok then
	return
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity_limit = "Warning",
	},
	update_in_insert = true,
})

require("nvim-treesitter.configs").setup({
	rainbow = {
		enable = true,
		extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	refactor = {
		highlight_definitions = {
			enable = true,
		},
		highlight_current_scope = {
			enable = true,
		},
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
		navigation = {
			enable = false,
			-- enable = true,
			-- keymaps = {
			--   goto_definition = "gd",
			--   list_definitions = "gD",
			--   list_definitions_toc = "gO",
			--   goto_next_usage = "<a-*>",
			--   goto_previous_usage = "<a-#>",
			-- },
		},
	},
	context_commentstring = {
		enable = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"python",
		"lua",
		"comment",
		"json",
		"php",
		"typescript",
		"vue",
		"css",
		"regex",
		"gomod",
		"bash",
		"yaml",
		"vim",
		"html",
		"javascript",
		"go",
		"fish",
		"dockerfile",
		"rust",
		"toml",
		"graphql",
		"scss",
		"hcl",
	},
	sync_install = false,
})
