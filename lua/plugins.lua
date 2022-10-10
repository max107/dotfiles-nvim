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
			"kdheepak/tabline.nvim",
			requires = {
				{ "hoob3rt/lualine.nvim", opt = true },
				{ "kyazdani42/nvim-web-devicons", opt = true },
			},
		})

		use("ray-x/go.nvim")
		use("ray-x/guihua.lua") -- recommanded if need floating window support
		-- use({
		-- 	"crispgm/nvim-go",
		-- 	requires = {
		-- 		"nvim-lua/plenary.nvim",
		-- 		"nvim-lua/popup.nvim",
		-- 	},
		-- })

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
		use("fgsch/vim-varnish")
		use("chr4/nginx.vim")
		use("towolf/vim-helm")
		use("nelsyeung/twig.vim")
		use({
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup({})
			end,
		})

		-- use({
		-- 	"kyazdani42/nvim-tree.lua",
		-- 	requires = {
		-- 		"kyazdani42/nvim-web-devicons", -- optional, for file icon
		-- 	},
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
					config = function()
						require("window-picker").setup({
							autoselect_one = true,
							include_current = false,
							filter_rules = {
								-- filter using buffer options
								bo = {
									-- if the file type is one of following, the window will be ignored
									filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

									-- if the buffer type is one of following, the window will be ignored
									buftype = { "terminal" },
								},
							},
							other_win_hl_color = "#e35e4f",
						})
					end,
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

		use({
			"nvim-lua/plenary.nvim",
		})

		use({
			"neovim/nvim-lspconfig",
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
			"sainnhe/sonokai",
			config = function()
				vim.cmd([[ colorscheme sonokai ]])
			end,
		})
		use({
			"folke/tokyonight.nvim",
			config = function()
				-- vim.cmd([[ colorscheme tokyonight ]])
			end,
		})
		-- use({
		-- 	"projekt0n/github-nvim-theme",
		-- 	config = function()
		-- 		vim.cmd([[ colorscheme github_dark ]])
		-- 	end,
		-- })

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
