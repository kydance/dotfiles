return {
    {
        'petertriho/nvim-scrollbar',
        event = 'BufReadPost',
        config = function()
            require('scrollbar').setup({
                -- Nothing
            })
        end
    },

    -- Colorscheme
    {'glepnir/zephyr-nvim'},
    {'shaunsingh/nord.nvim'},
    {   "ellisonleao/gruvbox.nvim",
        priority = 1000 ,
        config = function() require('config.nvim-colorscheme') end
    },

    -- Buffer line
    { 'akinsho/bufferline.nvim',
    	version = "*",
        dependencies = { 'famiu/bufdelete.nvim' },
        config = function() require('config.nvim-bufferline') end
    },

    -- which key
    {'folke/which-key.nvim',
        config = function() require('config.nvim-which-key') end,
    },

    -- yank
    {'gbprod/yanky.nvim',
	config = function() require'yanky'.setup{} end
    },

    -- Status line
    {'nvim-lualine/lualine.nvim',
        config = function() require('config.nvim-lualine') end
    },

    -- Ctrl - hjkl 定位窗口
    { 'christoomey/vim-tmux-navigator' },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        keys = {
            {'<leader>e', '<Cmd>NvimTreeFindFileToggle<CR>', mode = {'n', 'i', 't'}},
        },
        config = function() require("config.nvim-tree") end
    },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPost',
        dependencies = {
            'petertriho/nvim-scrollbar'
        },

        config = function() require("config.nvim-gitsigns") end
    },
    {"NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = function() require'neogit'.setup{} end,
    },

    -- Treesister
    {'nvim-treesitter/nvim-treesitter',
	dependencies = {
            'p00f/nvim-ts-rainbow',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context',

            'windwp/nvim-ts-autotag',
            'JoosepAlviste/nvim-ts-context-commentstring',
            'andymass/vim-matchup',
            'mfussenegger/nvim-treehopper',
	},
	event = 'BufReadPost',
	build = function()
		local ts_update = require('nvim-treesitter.install').update({with_sync = true})
		ts_update()
	end,
	config = function()  require("config.nvim-treesitter") end
    },

    -- Smart motion
    {'smoka7/hop.nvim',
        config = function() require('config.nvim-hop') end,
    },

    -- Surround
    {"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function() require("config.nvim-surround") end
    },

    -- Indente and blankline
    {'lukas-reineke/indent-blankline.nvim',
        config = function() require('config.nvim-indent-blankline') end
    },

    -- Commentary
    {'tpope/vim-commentary'},

    -- Todo comments
    {'folke/todo-comments.nvim',
        config = function () require("todo-comments").setup({ }) end
    },

    -- terminal integration
    {'akinsho/toggleterm.nvim',
        config = function() require('config.nvim-toggleterm') end,
    },

    -- Telescope
    {'nvim-telescope/telescope.nvim',
        event = 'BufReadPost',
        cmd = {
            'Glg', 'Gst', 'Diag', 'Tags'
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
        },
        config = function() require('config.nvim-telescope') end,
    },

    -- Markdown support
    {'preservim/vim-markdown',
        dependencies = {'mzlogin/vim-markdown-toc'},
        ft = { "markdown" }
    },
    -- Markdown previewer
    {'iamcco/markdown-preview.nvim',
        run = function() vim.fn["mkdp#util#install"]() end,
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        dependencies = {'iamcco/mathjax-support-for-mkdp'},
    },


    -- LSP syntax diagnostics
    {"neovim/nvim-lspconfig" },
    {"williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "mason-org/mason-registry",
        },
        config = function() require('config.nvim-lspconfig') end,
    },

    -- Vscode-like pictograms
    {'onsails/lspkind.nvim', event = 'VimEnter'},
    -- Auto-completion engine
    {'hrsh7th/nvim-cmp',
        version = false,
        event = {'BufReadPre', 'CmdlineEnter'},
        dependencies = {
            "L3MON4D3/LuaSnip",
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'f3fora/cmp-spell',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-emoji',
            'chrisgrieser/cmp_yanky',
            'lukas-reineke/cmp-rg',
            "lukas-reineke/cmp-under-comparator",
            'quangnguyen30192/cmp-nvim-tags',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function() require('config.nvim-cmp') end
    },

    -- Autopairs: [], (), "", '', ete. It relies on nvim-cmp
    {'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        config = function () require('config.nvim-autopairs') end,
    },

    -- LSP Linter && Formatter
    { "jay-babu/mason-null-ls.nvim",
          after = "plenary.nvim",
          dependencies = {
              "jose-elias-alvarez/null-ls.nvim",
              "nvimtools/none-ls.nvim",
          },
          config = function() require('config.nvim-mason-null-ls') end,
    },

    -- LSP Rename
    {'smjonas/inc-rename.nvim',
        config = function() require("inc_rename").setup({}) end,
    },

    {'folke/trouble.nvim',
        config = function () require("config.nvim-trouble") end
    },

    {'ray-x/lsp_signature.nvim',
        event = "VimEnter",
        config = function() require('config.nvim-lsp-signature') end
    },

    -- Outline
    {'stevearc/aerial.nvim',
        config = function() require"config/nvim-aerial" end,
    },

    -- {'mg979/vim-visual-multi',
	-- keys = {{'<C-n>', mode = {'n', 'v'}}, '<C-Down>', '<C-Up>'},
	-- config = function()
	-- 	vim.g.VM_maps = {['I BS'] = ''}
	-- 	vim.g.VM_silent_exit = 1
	-- 	vim.g.VM_plugins_compatibilty = {['lualine.nvim'] = {
	-- 	    test = function() return true end,
	-- 	    enable = 'lua require("lualine").hide{unhide = true}',
	-- 	    disable = 'lua require("lualine").hide()',
	-- 	}}
	-- 	vim.g.VM_Mono_hl = 'Cursor'
	-- 	vim.g.VM_Extend_hl  = 'Visual'
	-- end
    -- },
}

