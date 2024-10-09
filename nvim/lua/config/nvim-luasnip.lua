-- LuaSnip

local util = require("core.util")

local ok, luasnip = pcall(require, "luasnip")
if not ok then
	util.log_warn("nim-bufferline init failed.")
	return
end

local opts = { noremap = true, silent = true }

vim.keymap.set("s", "<Tab>", function()
	luasnip.jump(1)
end, opts)
vim.keymap.set("s", "<S-Tab>", function()
	luasnip.jump(-1)
end, opts)
vim.keymap.set("i", "<Tab>", function()
	return luasnip.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
end, { silent = true, expr = true })
vim.keymap.set("i", "<S-Tab>", function()
	luasnip.jump(-1)
end, opts)
