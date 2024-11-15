-- Surround

local util = require("core.util")
local ok, cfg = pcall(require, "nvim-surround")
if not ok then
	util.log_warn("nvim-surround init failed.")
	return
end

cfg.setup({
	context_offset = 100,
	load_autogroups = false,
	mappings_style = "surround",
	map_insert_mode = true,
	quotes = { "'", '"' },
	brackets = { "(", "{", "[" },
	space_on_closing_char = true,
	pairs = {
		nestable = {
			b = { "(", ")" },
			s = { "[", "]" },
			B = { "{", "}" },
			a = { "<", ">" },
		},
		linear = {
			q = { "'", "'" },
			t = { "`", "`" },
			d = { '"', '"' },
		},
		-- prefix = "s",
	},
})
