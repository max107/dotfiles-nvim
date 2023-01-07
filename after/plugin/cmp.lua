local ok, _ = pcall(require, "cmp")
if not ok then
	return
end

local lspkind = require("lspkind")
lspkind.init({
	-- default: 'default'
	preset = "codicons",
	-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	mode = "symbol_text",
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "ﰠ",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
})

local cmp = require("cmp")
cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			maxwidth = 50,
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		-- ["<C-p>"] = cmp.mapping.select_prev_item(),
		-- ["<C-n>"] = cmp.mapping.select_next_item(),
		-- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
		-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
		["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_diagnostic" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
	},
})

vim.cmd([[
augroup NvimCmp
au!
au FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
augroup END
]])

local null = require("null-ls")
null.setup({
	on_attach = function(client)
		-- if client.server_capabilities.document_formatting then
		-- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
		-- end
	end,
	sources = {
		-- null.builtins.formatting.stylua,
		null.builtins.formatting.black,
		null.builtins.formatting.prettier.with({
			filetypes = {
				"scss",
				"css",
				"json",
				"yaml",
				"markdown",
				"graphql",
				"vue",
			},
		}),
	},
})
