-- Trouble

local util = require("core.util")
local is_ok, trouble = pcall(require, "trouble")
if not is_ok then
	util.log_warn("trouble init failed!")
	return
end

trouble.setup({
	icons = {
		indent = {
			top = "│ ",
			middle = "├╴",
			last = "└╴",
			fold_open = " ",
			fold_closed = " ",
			ws = "  ",
		},

		folder_closed = " ",
		folder_open = " ",

		kinds = {
			Array = " ",
			Boolean = "󰨙 ",
			Class = " ",
			Constant = "󰏿 ",
			Constructor = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Function = "󰊕 ",
			Interface = " ",
			Key = " ",
			Method = "󰊕 ",
			Module = " ",
			Namespace = "󰦮 ",
			Null = " ",
			Number = "󰎠 ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			String = " ",
			Struct = "󰆼 ",
			TypeParameter = " ",
			Variable = "󰀫 ",
		},
	},
})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>")

vim.cmd([[
augroup trouble_setlocal
    autocmd!
    autocmd FileType trouble setlocal wrap
augroup END
]])
