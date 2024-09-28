local is_ok, configs = pcall(require, 'nvim-treesitter')
if not is_ok then
    return
end

configs.setup({
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = {
        'c', 'cmake', 'comment', 'cpp',
        'dockerfile',
        'gitignore', 'go', 'gomod',
        'ini',
        'json',
        'latex', 'lua',
        'make', 'markdown', 'markdown_inline',
        'python',
        'rust',
        'sql',
        'vim',
        'yaml',
        'xml',
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        -- When `enable` is `true` this will enable the module for all supported languages,
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- if you want to disable the module for some languages you can pass a list to the `disable` option.
        disable = {

        },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 1000 * 1024 -- 1000 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    -- rainbow = {
    --     enable = true,
    --     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    --     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    --     max_file_lines = nil, -- Do not enable for files with more than n lines, int
    --     -- colors = {}, -- table of hex strings
    --     -- termcolors = {} -- table of colour name strings
    -- },

    -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
    -- indent = {
    --     enable = true
    -- },
    incremental_selection = {
        enable = true,
        -- init_selection: in normal mode, start incremental selection.
        -- node_incremental: in visual mode, increment to the upper named parent.
        -- scope_incremental: in visual mode, increment to the upper scope
        -- node_decremental: in visual mode, decrement to the previous named node.
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
})

-- Hints:
--   A uppercase letter followed `z` means recursive
--   zo: open one fold under the cursor
--   zc: close one fold under the cursor
--   za: toggle the folding
--   zv: open just enough folds to make the line in which the cursor is located not folded
--   zM: Close all foldings
--   zR: Open all foldings
-- source: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
        vim.opt.foldlevel = 99
    end
})

