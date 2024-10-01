-- Buffer line

local util = require("core.util")

local is_ok, cfg = pcall(require, "bufferline")
if not is_ok then
	return
end

local hide = { qf = true }

cfg.setup({
	options = {
		mode = "buffers",
		diagnostics = "nvim_lsp",
		max_name_length = 30,
		sort_by = "none",
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
		cfg.go_to(i, true)
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
	cfg.cycle(-1)
	vim.cmd.bdelete(buf)
end)
