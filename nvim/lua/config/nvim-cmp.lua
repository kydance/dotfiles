local luasnip_ok, luasnip = pcall(require, "luasnip")
local cmp_ok, cmp = pcall(require, "cmp")
local lspkind_ok, lspkind = pcall(require, "lspkind")

if not luasnip_ok or not cmp_ok or not lspkind_ok then
	vim.notify("nvim-cmp or its dependencies failed to load", vim.log.levels.ERROR)
	return
end

-- Helper function to check if there are words before cursor position
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	-- Add window configuration for better appearance
	window = {
		completion = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		}),
		documentation = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		}),
	},
	mapping = cmp.mapping.preset.insert({
		-- Use <C-b/f> to scroll the docs
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- Use <C-k/j> to switch in items
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		-- Use <C-Space> to trigger completion
		["<C-Space>"] = cmp.mapping.complete(),
		-- Use <C-e> to abort completion
		["<C-e>"] = cmp.mapping.abort(),
		-- Use <CR>(Enter) to confirm selection
		-- Accept the currently selected item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		-- A super tab
		-- Source: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
		["<Tab>"] = cmp.mapping(function(fallback)
			-- Hint: if the completion menu is visible select the next one
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
				-- they way you will only jump inside the snippet region
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }), -- i - insert mode; s - select mode
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
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
		-- Customize the appearance of the completion menu
		format = lspkind.cmp_format({
			-- Show only symbol annotations
			mode = "symbol_text",
			-- Prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			maxwidth = 100,
			-- When the popup menu exceeds maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
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
	-- Set source precedence with proper priority
	sources = cmp.config.sources({
		{ name = "nvim_lsp", priority = 1000 }, -- For nvim-lsp
		{ name = "luasnip", priority = 750 }, -- For luasnip user
		{ name = "buffer", priority = 500 }, -- For buffer word completion
		{ name = "path", priority = 250 }, -- For path completion
	}),

	-- Add performance settings
	performance = {
		max_view_entries = 20, -- Limit the number of items shown at once
		fetching_timeout = 500, -- Timeout for fetching completions
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	-- Allow non-prefix matching in command mode
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up LSP capabilities for nvim-cmp
-- This ensures LSP servers use nvim-cmp for autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp_lsp then
	capabilities = cmp_lsp.default_capabilities(capabilities)
	-- Make this available to lspconfig
	vim.g.cmp_capabilities = capabilities
end
