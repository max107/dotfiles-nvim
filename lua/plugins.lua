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
			config = function()
				require("tabline").setup({
					-- Defaults configuration options
					enable = true,
					options = {
						-- If lualine is installed tabline will use separators configured in lualine by default.
						-- These options can be used to override those settings.
						section_separators = { "", "" },
						component_separators = { "", "" },
						max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
						show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
						show_devicons = true, -- this shows devicons in buffer section
						show_bufnr = false, -- this appends [bufnr] to buffer section,
						show_filename_only = false, -- shows base filename only instead of relative path in filename
						modified_icon = "+ ", -- change the default modified icon
						modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
						show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
					},
				})
				vim.cmd([[
		      set guioptions-=e " Use showtabline in gui vim
		      set sessionoptions+=tabpages,globals " store tabpages and globals in session
		    ]])
			end,
			requires = { { "hoob3rt/lualine.nvim", opt = true }, { "kyazdani42/nvim-web-devicons", opt = true } },
		})

		use({
			"crispgm/nvim-go",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-lua/popup.nvim",
			},
			config = function()
				require("go").setup({
          auto_lint = false,
        })
				vim.cmd([[
            augroup NvimGo
                autocmd!
                autocmd User NvimGoLintPopupPost wincmd p
            augroup END
        ]])
			end,
		})

		use({
			"terrortylor/nvim-comment",
			requires = {
				{
					"JoosepAlviste/nvim-ts-context-commentstring",
					after = "nvim-treesitter",
				},
			},
			config = function()
				require("comment-config")
			end,
		})
		use({
			"windwp/nvim-autopairs",
			-- after = "nvim-cmp",
			config = function()
				require("autopairs-config")
			end,
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

		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons", -- optional, for file icon
			},
			config = function()
				require("nvimtree-config")
			end,
		})

		-- use({
		-- 	"nvim-neo-tree/neo-tree.nvim",
		-- 	branch = "v1.x",
		-- 	requires = {
		-- 		"nvim-lua/plenary.nvim",
		-- 		"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
		-- 		"MunifTanjim/nui.nvim",
		-- 	},
		-- 	config = function()
		-- 		require("neotree-config")
		-- 	end,
		-- })

		use({
			"onsails/lspkind-nvim",
			config = function()
				require("lspkind-config")
			end,
		})

		use({
			"ms-jpq/coq.artifacts",
		})

		use({
			"ms-jpq/coq_nvim",
			run = ":COQdeps",
			config = function()
        require("coq-config")
			end,
		})

		-- use({
		-- 	"hrsh7th/nvim-cmp",
		-- 	requires = {
		-- 		"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim builtin LSP client
		-- 		"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
		-- 		"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words.
		-- 		"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
		-- 		"saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
		-- 		"L3MON4D3/LuaSnip", -- Snippets plugin
		-- 	},
		-- 	config = function()
		-- 		require("nvim-cmp-config")
		-- 	end,
		-- })

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
			config = function()
				require("treesitter-config")
			end,
		})

		use({
			"nvim-lua/plenary.nvim",
		})

		use({
			"neovim/nvim-lspconfig",
			config = function()
				require("lspconfig-config")
			end,
		})

		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("telescope-config")
			end,
		})

		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("null-ls-config")
			end,
		})
		use({
			"jose-elias-alvarez/nvim-lsp-ts-utils",
		})
		use({
			"sainnhe/sonokai",
			config = function()
				-- vim.cmd([[ let g:sonokai_style = 'andromeda' ]])
				-- vim.cmd([[ let g:sonokai_style = 'shusia' ]])
				vim.cmd([[ let g:sonokai_style = 'maia' ]])
				-- vim.cmd([[ let g:sonokai_style = 'atlantis' ]])
				-- vim.cmd([[ let g:sonokai_style = 'espresso' ]])
				vim.cmd([[ colorscheme sonokai ]])
			end,
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
