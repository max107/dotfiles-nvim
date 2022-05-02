local null = require("null-ls")
null.setup({
	on_attach = function(client)
		-- if client.resolved_capabilities.document_formatting then
		-- 	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		-- end
	end,
	sources = {
		null.builtins.formatting.stylua,
		null.builtins.formatting.black,
		null.builtins.formatting.prettier.with({
			filetypes = { "scss", "css", "json", "yaml", "markdown", "graphql" },
		}),
	},
})
