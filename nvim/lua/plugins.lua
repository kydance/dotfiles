-- Install Lazy.nvim automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- After installation, run `checkhealth lazy` to see if everything goes right
-- Hints:
--     build: It will be executed when a plugin is installed or updated
--     config: It will be executed when the plugin loads
--     event: Lazy-load on event
--     dependencies: table
--                   A list of plugin names or plugin specs that should be loaded when the plugin loads.
--                   Dependencies are always lazy-loaded unless specified otherwise.
--     ft: Lazy-load on filetype
--     cmd: Lazy-load on command
--     init: Functions are always executed during startup
--     branch: string?
--             Branch of the repository
--     main: string?
--           Specify the main module to use for config() or opts()
--           , in case it can not be determined automatically.
--     keys: string? | string[] | LazyKeysSpec table
--           Lazy-load on key mapping
--     opts: The table will be passed to the require(...).setup(opts)
require("lazy").setup({
	-- Colorscheme
	"tanvirtin/monokai.nvim",
	"glepnir/zephyr-nvim",
	"folke/tokyonight.nvim",
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({})
		end,
	},

	-- Improve the performance of big file
	"pteroctopus/faster.nvim",

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.lualine")
		end,
	},

	-- UI Component Library
	"MunifTanjim/nui.nvim",

	-- Notify
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config.notify")
		end,
	},

	-- Which-key
	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end,
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPost",
		dependencies = { "famiu/bufdelete.nvim" },
		config = function()
			require("config.bufferline")
		end,
	},

	-- Show indentation and blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("config.indent-blankline")
		end,
	},

	-- yanky
	{
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({})
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
		config = function()
			require("config.nvim-tree")
		end,
	},

	-- Git integration
	"tpope/vim-fugitive",

	-- Git decorations
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		config = function()
			require("config.gitsigns")
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
		config = function()
			require("config.neogit")
		end,
	},

	-- Outline
	{
		"stevearc/aerial.nvim",
		config = function()
			require("config/aerial")
		end,
	},

	-- Smart motion
	{
		"smoka7/hop.nvim",
		config = function()
			require("config.hop")
		end,
	},

	-- Make surrounding easier
	-- ------------------------------------------------------------------
	-- Old text                    Command         New text
	-- ------------------------------------------------------------------
	-- surr*ound_words             gziw)           (surround_words)
	-- *make strings               gz$"            "make strings"
	-- [delete ar*ound me!]        gzd]            delete around me!
	-- remove <b>HTML t*ags</b>    gzdt            remove HTML tags
	-- 'change quot*es'            gzc'"           "change quotes"
	-- delete(functi*on calls)     gzcf            function calls
	-- ------------------------------------------------------------------
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		-- You can use the VeryLazy event for things that can
		-- load later and are not important for the initial UI
		event = "VeryLazy",
		config = function()
			require("config.nvim-surround")
		end,
	},

	-- Ctrl - hjkl 定位窗口
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	-- Commentary
	{ "tpope/vim-commentary" },

	-- Todo comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- Better terminal integration
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("config.toggleterm")
		end,
	},

	-- Markdown support
	{
		"preservim/vim-markdown",
		require = { "godlygeek/tabular" },
		ft = { "markdown" },
	},

	-- Markdown preview
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },

		config = function()
			require("config.render-markdown")
		end,
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		event = "BufReadPost",
		cmd = { "Glg", "Gst", "Diag", "Tags" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
		},
		config = function()
			require("config.telescope")
		end,
	},

	-- Autopairs: [], (), "", '', etc
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("config.nvim-autopairs")
		end,
	},

	-- Treesitter-integration
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

	-- Vscode-like pictograms
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},

	-- LSP manager
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	-- Add hooks to LSP to support Linter && Formatter
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			-- Note:
			--     the default search path for `require` is ~/.config/nvim/lua
			--     use a `.` as a path separator
			--     the suffix `.lua` is not needed
			require("config.mason-null-ls")
		end,
	},

	-- Auto-completion engine
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},

	-- Code snippet engine
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},

	-- LSP Rename
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({})
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			require("config.trouble")
		end,
	},

	-- Codeium
	{
		"Exafunction/windsurf.vim",
		config = function()
			vim.g.codeium_no_map_tab = 1
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
})
