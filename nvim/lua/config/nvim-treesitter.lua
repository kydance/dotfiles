-- Treesitter

local util = require("core.util")
local is_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not is_ok then
	util.log_warn("treesitter init failed!")
	return
end

treesitter.setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = {
		"c",
		"cmake",
		"comment",
		"cpp",
		"dockerfile",
		"gitignore",
		"go",
		"gomod",
		"ini",
		"json",
		"latex",
		"lua",
		"make",
		"markdown",
		"markdown_inline",
		"python",
		"rust",
		"sql",
		"vim",
		"yaml",
		"xml",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		-- When `enable` is `true` this will enable the module for all supported languages,
		-- `false` will disable the whole extension
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
	},

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

-- vim.g.skip_ts_context_commentstring_module = true
-- vim.g.matchup_matchparen_offscreen = { method = "status" }
-- vim.g.matchup_surround_enabled = 1
-- vim.g.matchup_delim_noskips = 2

-- Hints:
--   A uppercase letter followed `z` means recursive
--   zo: open one fold under the cursor
--   zc: close one fold under the cursor
--   za: toggle the folding
--   zv: open just enough folds to make the line in which the cursor is located not folded
--   zM: Close all foldings
--   zR: Open all foldings
-- source: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldlevel = 99
	end,
})
