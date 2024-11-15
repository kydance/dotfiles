local util = require("core.util")

local ok, gs = pcall(require, "gitsigns")
if not ok then
	util.log_warn("nvim-gitsigns init failed.")
	return
end

gs.setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},

	current_line_blame = true,
	on_attach = function(bufnr)
		local function map(mode, lhs, rhs, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Next hunk
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Previous hunk
		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "ghp", gs.preview_hunk)
		map("n", "ghb", function()
			gs.blame_line({ full = true })
		end)
		map("n", "ghd", gs.diffthis)
		map("n", "ghD", function()
			gs.diffthis("~")
		end)
		map("n", "ghr", gs.reset_hunk)
	end,
})
