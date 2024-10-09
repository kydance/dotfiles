-- LSP Manager
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	-- A list of servers to automatically install if they're not already installed
	ensure_installed = {
		"pylsp", -- Python
		"gopls", -- Go
		"clangd", -- C/C++
		"marksman", -- Markdown
		"lua_ls", -- lua_ls
		"cmake", -- CMake
	},
})

-- Fomater
local util = require("core.util")
local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_ok then
	util.log_warn("nim-mason-null-ls init failed.")
	return
end

mason_null_ls.setup({
	-- A list of sources to install if they're not already installed.
	-- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = {
        "goimports",
		"black",
		"stylua",
		"jq",
		"markdownlint",
	},
	automatic_installation = false,
	-- Sources found installed in mason will automatically be setup for null-ls.
	automatic_setup = true,
	handlers = {},
})
