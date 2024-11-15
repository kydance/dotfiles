-- null_ls format

local util = require("core.util")
local ok, null_ls = pcall(require, "null-ls")
if not ok then
	util.log_warn("nvim-null-ls init failed.")
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	log_level = "warn",
	update_in_insert = false,
	sources = {
		-- Python
		null_ls.builtins.formatting.black.with({
			extra_args = {
				"--target-version",
				"py312",
			},
		}),

		-- Lua
		null_ls.builtins.formatting.stylua,

		-- Go
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.formatting.golines,
	},

	-- auto format when write file
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
