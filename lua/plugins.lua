local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

return require("packer").startup({
	function()
		-- Autorecompile packages
		vim.cmd([[
  augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end

  nnoremap <F9> :PackerSync<CR>
]])

		use("wbthomason/packer.nvim")

		use({
			"neovim/nvim-lspconfig",
		})

		-- use lspsaga or
		use({
			"glepnir/lspsaga.nvim",
			branch = "main",
		})
		-- navigator.lua
		-- use({
		-- 	"ray-x/navigator.lua",
		-- 	requires = {
		-- 		{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
		-- 		{ "neovim/nvim-lspconfig" },
		-- 	},
		-- })

		use({
			"ray-x/go.nvim",
			requires = {
				{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
			},
		})

		use({
			"norcalli/nvim-colorizer.lua",
		})

		use({
			"terrortylor/nvim-comment",
			requires = {
				{
					"JoosepAlviste/nvim-ts-context-commentstring",
					after = "nvim-treesitter",
				},
			},
		})
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
		})
		use("chr4/nginx.vim")
		use("towolf/vim-helm")
		use("nelsyeung/twig.vim")
		use("j-hui/fidget.nvim")

		-- use({
		--   "kyazdani42/nvim-tree.lua",
		--   requires = {
		--     "kyazdani42/nvim-web-devicons", -- optional, for file icon
		--   },
		-- })

		use({
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
				{
					-- only needed if you want to use the commands with "_with_window_picker" suffix
					"s1n7ax/nvim-window-picker",
					tag = "v1.*",
				},
			},
		})

		use({
			"onsails/lspkind-nvim",
		})

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim builtin LSP client
				"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
				"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words.
				"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
				"saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
				"L3MON4D3/LuaSnip", -- Snippets plugin
			},
		})

		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		})

		use({
			"sainnhe/sonokai",
			config = function()
				vim.cmd([[ colorscheme sonokai ]])
			end,
		})
		use({
			"whatsthatsmell/codesmell_dark.vim",
			config = function()
				-- configs (just yank what's in quotes and drop in your .vimrc if you're not Lua'd yet)
				-- vim.cmd("set fillchars+=vert:│")
				-- vim.cmd("colorscheme codesmell_dark")
			end,
		})
		use({
			"chentoast/marks.nvim",
		})
		use({
			"sonph/onehalf",
			rtp = "vim",
			config = function()
				-- vim.opt.background = "light"
				-- vim.cmd([[ colorscheme onehalflight ]])

				-- vim.cmd([[ colorscheme onehalfdark ]])
			end,
		})
		use({
			"humanoid-colors/vim-humanoid-colorscheme",
			config = function()
				-- vim.opt.background = "light"
				-- vim.cmd([[ colorscheme humanoid ]])
			end,
		})
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			event = "BufWinEnter",
			requires = {
				{
					"p00f/nvim-ts-rainbow",
					after = "nvim-treesitter",
				},
				{
					"nvim-treesitter/nvim-treesitter-refactor",
					after = "nvim-treesitter",
				},
				{
					"windwp/nvim-ts-autotag",
					event = "InsertEnter",
					after = "nvim-treesitter",
				},
			},
		})

		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use({
			"gpanders/editorconfig.nvim",
		})
		use({
			"jose-elias-alvarez/null-ls.nvim",
		})
		use({
			"jose-elias-alvarez/nvim-lsp-ts-utils",
		})
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})
