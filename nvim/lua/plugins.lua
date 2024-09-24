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
    use("wbthomason/packer.nvim")

    -- Note:
    --     the default search path for `require` is ~/.config/nvim/lua
    --     use a `.` as a path seperator
    --     the suffix `.lua` is not needed

    ---------------------------------------
    -- NOTE: PUT YOUR THIRD PLUGIN HERE --
    ---------------------------------------

    -- 1. colorschem
    use { "ellisonleao/gruvbox.nvim" }

    -- 2. status line
    use { 'nvim-lualine/lualine.nvim', 
            requires = { 'nvim-tree/nvim-web-devicons', opt = true },
            config = [[require('config.nvim-lualine')]]
    }

    -- 3. File explorer
    use({ "nvim-tree/nvim-tree.lua",
          requires = {
                -- optional
              "nvim-tree/nvim-web-devicons",
          },
          config = [[require('config.nvim-tree')]],
    })
    use("christoomey/vim-tmux-navigator") -- Ctrl - hjkl 定位窗口

    -- 4. Treesitter
    use({ "nvim-treesitter/nvim-treesitter",
          "nvim-treesitter/nvim-treesitter-textobjects",
          "nvim-treesitter/nvim-treesitter-context",

        'windwp/nvim-ts-autotag',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'andymass/vim-matchup',
        'mfussenegger/nvim-treehopper',

          run = function()
              local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
              ts_update()
          end,
          config = [[require('config.nvim-treesitter')]],
    })

    -- 5. rainbow
    use("p00f/nvim-ts-rainbow")
    use({ "kylechui/nvim-surround",
          config = [[require('config.nvim-surround')]]
    })


    -- 6. Show indentation and blankline
    use { 'lukas-reineke/indent-blankline.nvim', config = [[require('config.nvim-indent-blankline')]] }

    -- 7. Git integration
    use("tpope/vim-fugitive")
    use({ "lewis6991/gitsigns.nvim",
          config = [[require('config.nvim-gitsigns')]]
    })

    -- 8. Vscode-like pictograms
    use({ "onsails/lspkind.nvim", event = "VimEnter" })

    -- 9. Auto-completion engine
    use({ "hrsh7th/nvim-cmp", after = "lspkind.nvim", config = [[require('config.nvim-cmp')]] })
    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" }) 
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" }) 

    -- 10. Autopairs: [], (), "", '', ete. It relies on nvim-cmp
    use({ "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = [[require('config.nvim-autopairs')]],
    })

    -- 11. Code comment helper
        -- 1. `gcc` to comment a line
        -- 2. select lines in visual mode and run `gc` to comment/uncomment lines
    use("tpope/vim-commentary")

    -- 12. Buffer line
    use({ "akinsho/bufferline.nvim",
          tag = '*',
          requires = { 'famiu/bufdelete.nvim' },
          config = [[require('config.nvim-bufferline')]],
    })

    -- 13. Smart motion
        -- FIXME 不知如何使用
    use {'smoka7/hop.nvim',
      tag = '*', -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }

    -- cursor motion
    use({
        "folke/which-key.nvim",
        config = [[require('config.nvim-which-key')]],
    })

    -- 14. Better terminal integration
        -- tag = string,
        -- Specifies a git tag to use. Supports '*' for "latest tag"
    use({ "akinsho/toggleterm.nvim",
          tag = "*",
          config = [[require('config.nvim-toggleterm')]],
    })

    -- 15. Todo
    use({ "folke/todo-comments.nvim",
          config = function() require"todo-comments".setup{} end
    })

    -- 16. Telescope
    use({ "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = [[require('config.nvim-telescope')]],
    })

    -- 17. LSP manager
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({ "neovim/nvim-lspconfig" })
    -- Add hooks to LSP to support Linter && Formatter
    use({ "nvim-lua/plenary.nvim" })
    use({ "jay-babu/mason-null-ls.nvim",
          after = "plenary.nvim",
          requires = { "jose-elias-alvarez/null-ls.nvim" },
          config = [[require('config.nvim-mason-null-ls')]],
    })
    use( {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function() require("trouble").setup{} end,
    })

    -- 18. 弹出窗口
    -- use ( "nvim-lua/popup.nvim" )

    -- 19. nvim-notify
    use ({'rcarriga/nvim-notify',
          config = [[require('config.nvim-notify')]],
    })


    -- 20. Markdown support
    use({ "preservim/vim-markdown",
          "mzlogin/vim-markdown-toc",
          ft = { "markdown" }
    })
    -- Markdown previewer
    -- install without yarn or npm
    use({ "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        requires = 'iamcco/mathjax-support-for-mkdp',
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

