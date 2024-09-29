-----------------
-- Packer.nvim --
-----------------
-- Install Packer automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Install plugins here - `use ...`
-- Packer.nvim hints
--     after = string or list,           -- Specifies plugins to load before this plugin. See "sequencing" below
--     config = string or function,      -- Specifies code to run after this plugin is loaded
--     requires = string or list,        -- Specifies plugin dependencies. See "dependencies".
--     ft = string or list,              -- Specifies filetypes which load this plugin.
--     run = string, function, or table, -- Specify operations to be run after successful installs/updates of a plugin
return require("packer").startup(function(use)
    -- Packer can manage itself
    use({'wbthomason/packer.nvim'})

    -- NOTE:
        -- the default search path for `require` is ~/.config/nvim/lua
        -- use a `.` as a path seperator
        -- the suffix `.lua` is not needed
        -- tag = string, Specifies a git tag to use. Supports '*' for "latest tag"

    ---------------------------------------
    -- NOTE: PUT YOUR THIRD PLUGIN HERE --
    ---------------------------------------

    -- Colorschem
    use ({'ellisonleao/gruvbox.nvim',
        -- 'glepnir/zephyr-nvim',
        -- 'shaunsingh/nord.nvim',
        requires = 'rktjmp/lush.nvim',
    })

    -- yank
    use ({'gbprod/yanky.nvim',
        config = function() require'yanky'.setup{} end,
    })

    -- Status line
    use ({'nvim-lualine/lualine.nvim',
        config = [[require('config.nvim-lualine')]]
    })

    -- Which key
    use ({'folke/which-key.nvim',
        config = [[require('config.nvim-which-key')]],
    })

    -- -- nvim-notify
    use ( 'nvim-lua/plenary.nvim' )
    -- use ( "nvim-lua/popup.nvim" )
    -- use ({'rcarriga/nvim-notify',
    --       config = [[require('config.nvim-notify')]],
    -- })

    -- File explorer
    use ({'nvim-tree/nvim-web-devicons'}) -- icons
    use ({'nvim-tree/nvim-tree.lua',
        config = [[require('config.nvim-tree')]],
    })
    use ({'christoomey/vim-tmux-navigator'}) -- Ctrl - hjkl 定位窗口

    -- Treesitter
    use ({'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,

        requires = {
            'p00f/nvim-ts-rainbow',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context',

            'windwp/nvim-ts-autotag',
            'JoosepAlviste/nvim-ts-context-commentstring',
            'andymass/vim-matchup',
            'mfussenegger/nvim-treehopper',
        },

        config = [[require('config.nvim-treesitter')]],
    })

    -- Surround
    use ({'kylechui/nvim-surround',
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = [[require('config.nvim-surrounding')]],
    })

    -- Show indentation and blankline
    use ({'lukas-reineke/indent-blankline.nvim',
        config = [[require('config.nvim-indent-blankline')]]
    })

    -- Git integration
    use ({'tpope/vim-fugitive'})
    use ({'lewis6991/gitsigns.nvim',
        config = [[require('config.nvim-gitsigns')]]
    })

    use ({
        "NeogitOrg/neogit",
        requires = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = function() require'neogit'.setup{} end,
    })

    -- Code comment helper
        -- 1. `gcc` to comment a line
        -- 2. select lines in visual mode and run `gc` to comment/uncomment lines
    use ({'tpope/vim-commentary'})

    -- Buffer line
    use({ 'akinsho/bufferline.nvim',
          tag = '*',
          requires = { 'famiu/bufdelete.nvim' },
          config = [[require('config.nvim-bufferline')]],
    })

    -- Todo comments
    use ({'folke/todo-comments.nvim',
        config = function () require("todo-comments").setup({ }) end
    })

    -- Better terminal integration
    use ({'akinsho/toggleterm.nvim',
        tag = "*",
        config = [[require('config.nvim-toggleterm')]],
    })

    -- Telescope
    use ({'nvim-telescope/telescope.nvim',
        config = [[require('config.nvim-telescope')]],
    })

    -- Smart motion
    use ({'smoka7/hop.nvim',
        tag = '*', -- optional but strongly recommended
        config = [[require('config.nvim-hop')]],
    })

    -- Markdown support
    use ({'preservim/vim-markdown',
          'mzlogin/vim-markdown-toc',
          ft = { "markdown" }
    })
    -- Markdown previewer
    use ({'iamcco/markdown-preview.nvim',
        run = function() vim.fn["mkdp#util#install"]() end,
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        requires = 'iamcco/mathjax-support-for-mkdp',
    })

    -- LSP syntax diagnostics
    use ({"neovim/nvim-lspconfig" })
    use ({"williamboman/mason.nvim",
        requires = {
            "williamboman/mason-lspconfig.nvim",
            "mason-org/mason-registry",
        },
        config = [[require('lsp')]],
    })

    -- Vscode-like pictograms
    use ({'onsails/lspkind.nvim', event = 'VimEnter' })

    -- Auto-completion engine
    -- Note:
    --     the default search path for `require` is ~/.config/nvim/lua
    --     use a `.` as a path seperator
    --     the suffix `.lua` is not needed
    use({ "hrsh7th/nvim-cmp",
        after = "lspkind.nvim",
        config = [[require('config.nvim-cmp')]]
    })
    use ({'onsails/lspkind-nvim', after = "nvim-cmp"  })
    use ({'hrsh7th/cmp-nvim-lsp', after = "nvim-cmp"  })
    use ({'hrsh7th/cmp-nvim-lsp-signature-help', after = "nvim-cmp" })
    use ({'hrsh7th/cmp-buffer', after = "nvim-cmp" })
    use ({'hrsh7th/cmp-path', after = "nvim-cmp" })
    use ({'hrsh7th/cmp-cmdline',after = "nvim-cmp" })
    use ({'f3fora/cmp-spell', after = "nvim-cmp" })
    use ({'hrsh7th/cmp-calc', after = "nvim-cmp" })
    use ({'hrsh7th/cmp-emoji', after = "nvim-cmp" })
    use ({'chrisgrieser/cmp_yanky', after = "nvim-cmp" })
    use ({'lukas-reineke/cmp-rg', after = "nvim-cmp" })
    use ({"lukas-reineke/cmp-under-comparator", after = "nvim-cmp" })

    -- Code snippet engine
    use("L3MON4D3/LuaSnip")
    use({ "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } })

    -- Autopairs: [], (), "", '', ete. It relies on nvim-cmp
    use ({'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        config = [[require('config.nvim-autopairs')]],
    })

    -- LSP Linter && Formatter
    use({ "jay-babu/mason-null-ls.nvim",
          after = "plenary.nvim",
          requires = {
              "jose-elias-alvarez/null-ls.nvim",
              "nvimtools/none-ls.nvim",
          },
          config = [[require('config.nvim-mason-null-ls')]],
    })

    use ({'folke/trouble.nvim',
        config = [[require("config.nvim-trouble")]]
    })

    use ({'ray-x/lsp_signature.nvim', event = "VimEnter",
        config = [[require('config.nvim-lsp-signature')]]
    })

    -- Outline
    use ({'stevearc/aerial.nvim',
        config = function() require"config/nvim-aerial" end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

