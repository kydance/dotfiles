local lspconfig = require("lspconfig")
local telescope_builtin = require("telescope.builtin")

local function on_attach(client_, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<C-o>", function()
		telescope_builtin.lsp_document_symbols({ symbol_width = 0.8 })
	end, bufopts)
	vim.keymap.set("n", "gd", function()
		telescope_builtin.lsp_definitions({ fname_width = 0.4 })
	end, bufopts)
	vim.keymap.set("n", "gr", function()
		telescope_builtin.lsp_references({ fname_width = 0.4 })
	end, bufopts)
	vim.keymap.set("n", "gi", function()
		telescope_builtin.lsp_implementations({ fname_width = 0.4 })
	end, bufopts)

	-- vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

	vim.api.nvim_create_autocmd(
		{ "CursorHold", "CursorHoldI" },
		{ callback = vim.lsp.buf.document_highlight, buffer = bufnr }
	)
	vim.api.nvim_create_autocmd(
		{ "CursorMoved", "CursorMovedI" },
		{ callback = vim.lsp.buf.clear_references, buffer = bufnr }
	)
	vim.api.nvim_create_autocmd(
		{ "TextChangedI", "TextChangedP" },
		{ callback = vim.lsp.buf.signature_help, buffer = bufnr }
	)

	-- Format
	vim.api.nvim_buf_create_user_command(bufnr, "Fmt", function(opts)
		local range
		if opts.range == 2 then
			range = { ["start"] = { opts.line1, 0 }, ["end"] = { opts.line2, 0 } }
		end
		vim.lsp.buf.format({
			async = true,
			range = range,
			filter = function(client)
				return client.name == "null-ls"
			end,
		})
	end, { range = true })
	vim.keymap.set("n", "<space>=", ":Fmt<CR>", bufopts)
end

-- Configure each language
lspconfig.gopls.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })
lspconfig.pylsp.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
		},
	},
})

-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>x", vim.diagnostic.setloclist, opts)
