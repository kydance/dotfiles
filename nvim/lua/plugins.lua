return {
	-- Colorscheme
	{ "glepnir/zephyr-nvim" },
	{ "folke/tokyonight.nvim" },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({})
		end,
	},

	-- which key
	{
		"folke/which-key.nvim",
		config = function()
			require("config.nvim-which-key")
		end,
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPost",
		dependencies = { "famiu/bufdelete.nvim" },
		config = function()
			require("config.nvim-bufferline")
		end,
	},

	-- yank
	{
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({})
		end,
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.nvim-lualine")
		end,
	},

	-- Ctrl - hjkl 定位窗口
	{ "christoomey/vim-tmux-navigator" },

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.nvim-tree")
		end,
	},

	-- Outline
	{
		"stevearc/aerial.nvim",
		config = function()
			require("config/nvim-aerial")
		end,
	},

	-- Smart motion
	{
		"smoka7/hop.nvim",
		config = function()
			require("config.nvim-hop")
		end,
	},

	-- Surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("config.nvim-surround")
		end,
	},

	-- Indente and blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",

		---@module "ibl"
		---@type ibl.config

		config = function()
			require("config.nvim-indent-blankline")
		end,
	},

	-- LSP Rename
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({})
		end,
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		config = function()
			require("config.nvim-gitsigns")
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional

			"nvim-telescope/telescope.nvim", -- optional
			-- "ibhagwan/fzf-lua", -- optional
		},
		config = true,
		-- config = function()
		-- 	require("neogit").setup({})
		-- end,
	},

	-- Commentary
	{ "tpope/vim-commentary" },

	-- Todo comments
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

	-- terminal integration
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("config.nvim-toggleterm")
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		event = "BufReadPost",
		cmd = { "Glg", "Gst", "Diag", "Tags" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
		},
		config = function()
			require("config.nvim-telescope")
		end,
	},

	-- Highlight search
	{
		"kevinhwang91/nvim-hlslens",
		event = "BufReadPost",
		config = function()
			require("hlslens").setup({})

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
			vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
			vim.keymap.set(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				opts
			)
			vim.keymap.set(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				opts
			)
		end,
	},

	-- Markdown support
	{
		"plasticboy/vim-markdown",
		branch = "master",
		require = { "godlygeek/tabular" },
		ft = { "markdown" },
	},
	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- 代码片段管理
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		config = function()
			require("config.nvim-luasnip")
		end,
	},
	-- Auto-completion engine
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "BufReadPre", "CmdlineEnter" },
		dependencies = {
			"onsails/lspkind.nvim", -- Vscode-like pictograms
			"hrsh7th/cmp-nvim-lsp",
			-- 'hrsh7th/cmp-nvim-lsp-signature-help',
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- 'f3fora/cmp-spell',
			-- 'hrsh7th/cmp-calc',
			-- 'hrsh7th/cmp-emoji',
			-- 'chrisgrieser/cmp_yanky',
			"lukas-reineke/cmp-rg",
			-- "lukas-reineke/cmp-under-comparator",
			"quangnguyen30192/cmp-nvim-tags",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},

	-- Autopairs: [], (), "", '', ete. It relies on nvim-cmp
	{
		"windwp/nvim-autopairs",
		evnet = "InsertEnter",
		config = function()
			require("config.nvim-autopairs")
		end,
	},

	-- Treesister, 增强语法高亮和代码理解能力的工具
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"p00f/nvim-ts-rainbow",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",

			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"andymass/vim-matchup",
			"mfussenegger/nvim-treehopper",
		},
		event = "BufReadPost",
		build = ":TSUpdate",
		config = function()
			require("config.nvim-treesitter")
		end,
	},

	-- LSP syntax diagnostics
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		event = "BufReadPre",
		config = function()
			require("config.nvim-lspconfig")
		end,
	},

	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"mason-org/mason-registry",
		},
		config = function()
			require("config.nvim-mason")
		end,
	},

	-- LSP Linter && Formatter
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("config.nvim-mason-null-ls")
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "VimEnter",
		config = function()
			require("config.nvim-lsp-signature")
		end,
	},

	{
		"folke/trouble.nvim",
		config = function()
			require("config.nvim-trouble")
		end,
	},
}
