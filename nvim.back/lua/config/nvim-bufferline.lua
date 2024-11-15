-- Buffer line

local util = require("core.util")

local is_ok, bufferline = pcall(require, "bufferline")
if not is_ok then
	util.log_warn("nvim-bufferline init failed.")
	return
end

local hide = { qf = true }

bufferline.setup({
	options = {
		mode = "buffers",
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
				padding = 1,
			},
		},
		custom_filter = function(bufnr)
			return not hide[vim.bo[bufnr].filetype]
		end,
	},
})

-- <leader> number
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function()
		bufferline.go_to(i, true)
	end)
end

-- buffer line
vim.keymap.set({ "v", "n" }, "gt", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set({ "v", "n" }, "gT", "<cmd>BufferLineCyclePrev<CR>")

vim.keymap.set({ "v", "n" }, "ZZ", function()
	if vim.bo.modified then
		util.log_err("No write sine last change.")
		return
	end
	local buf = vim.fn.bufnr()
	bufferline.cycle(-1)
	vim.cmd.bdelete(buf)
end)
