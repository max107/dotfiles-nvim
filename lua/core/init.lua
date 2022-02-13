vim.g.loaded_ruby_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0

-- https://bryankegley.me/posts/nvim-getting-started/
local key_mapper = function(mode, key, result)
	-- vim.api.nvim_set_keymap('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
	-- key_mapper('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>")
	vim.api.nvim_set_keymap(mode, key, result, {
		noremap = true,
		silent = true,
	})
end

function isModuleAvailable(name)
	if package.loaded[name] then
		return true
	else
		for _, searcher in ipairs(package.searchers or package.loaders) do
			local loader = searcher(name)
			if type(loader) == "function" then
				package.preload[name] = loader
				return true
			end
		end
		return false
	end
end

return {
	key_mapper = key_mapper,
	is_module_available = isModuleAvailable,
}
