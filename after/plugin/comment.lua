local ok, _ = pcall(require, "nvim_comment")
if not ok then
	return
end

require("nvim_comment").setup({
	-- Linters prefer comment and line to have a space in between markers
	marker_padding = true,
	-- should comment out empty or whitespace only lines
	comment_empty = false,
	-- Should key mappings be created
	create_mappings = true,
	-- Normal mode mapping left hand side
	line_mapping = "gcc",
	-- Visual/Operator mapping left hand side
	operator_mapping = "gc",
	-- Hook function to call before commenting takes place
	hook = function()
		require("ts_context_commentstring.internal").update_commentstring()
	end,
})

vim.cmd([[
augroup set-commentstring-ag
autocmd!
autocmd BufEnter *.fish :lua vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
autocmd BufFilePost *.fish :lua vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
augroup END
]])
