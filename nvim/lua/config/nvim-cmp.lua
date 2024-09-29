--

local luasnip_ok, luasnip = pcall(require, "luasnip")
local cmp_ok, cfg_cmp = pcall(require, "nvim-cmp")
local lspkind_ok, lspkind = pcall(require, "lspkind")

if not luasnip_ok or not cmp_ok or not lspkind_ok then
    return
end

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cfg_cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    mapping = cfg_cmp.mapping.preset.insert({
        -- Use <C-b/f> to scroll the docs
        -- XXX
        ["<C-b>"] = cfg_cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cfg_cmp.mapping.scroll_docs(4),

        -- Use <C-k/j> to switch in items
        ["<C-k>"] = cfg_cmp.mapping.select_prev_item(),
        ["<C-j>"] = cfg_cmp.mapping.select_next_item(),

        -- Use <CR>(Enter) to confirm selection
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cfg_cmp.mapping.confirm({ select = true }),

        -- A super tab
        -- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        ["<Tab>"] = cfg_cmp.mapping(function(fallback)
            -- Hint: if the completion menu is visible select next one
            if cfg_cmp.visible() then
                    cfg_cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                    -- they way you will only jump inside the snippet region
                    luasnip.expand_or_jump()
            elseif has_words_before() then
                    cfg_cmp.complete()
            else
                    fallback()
            end
        end, { "i", "s" }), -- i - insert mode; s - select mode

        ["<S-Tab>"] = cfg_cmp.mapping(function(fallback)
            if cfg_cmp.visible() then
                    cfg_cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
            else
                    fallback()
            end
        end, { "i", "s" }),
    }),

    -- Let's configure the item's appearance
    -- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
    formatting = {
        -- customize the appearance of the completion menu
        format = lspkind.cmp_format({
            -- show only symbol annotations
            mode = "symbol_text", -- symbol
            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            maxwidth = 100,
            -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            ellipsis_char = "...",

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = "[Lsp]",
                    luasnip = "[Luasnip]",
                    buffer = "[File]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        }),
    },

    -- Set source precedence
    sources = cfg_cmp.config.sources({
        { name = "nvim_lsp" }, -- For nvim-lsp
        { name = "luasnip" }, -- For luasnip user
        { name = "buffer" }, -- For buffer word completion
        { name = "path" }, -- For path completion
    }),
})

-- Set configuration for specific filetype.
cfg_cmp.setup.filetype("gitcommit", {
    sources = cfg_cmp.config.sources({
        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = "buffer" },
    }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cfg_cmp.setup.cmdline({ "/", "?" }, {
    mapping = cfg_cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cfg_cmp.setup.cmdline(":", {
    mapping = cfg_cmp.mapping.preset.cmdline(),
    sources = cfg_cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})
