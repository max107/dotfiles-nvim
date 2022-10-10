-- https://bryankegley.me/posts/nvim-getting-started/
local key_mapper = function(mode, key, result)
	-- vim.api.nvim_set_keymap('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
	-- key_mapper('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>")
	vim.api.nvim_set_keymap(mode, key, result, {
		noremap = true,
		silent = true,
	})
end

return {
	key_mapper = key_mapper,
}
