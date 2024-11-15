-- Outline

local util = require("util")
local is_ok, cfg = pcall(require, "aerial")
if not is_ok then
	util.log_warn("aerial init failed.")
	return
end

cfg.setup({
	-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	-- on_attach = function(bufnr)
	--     -- Jump forwards/backwards with '{' and '}'
	--     -- vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
	--     -- vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	-- end,

	layout = {
		max_width = { 48, 0.25 },
		min_width = 16,
		resize_to_content = true,
		preserve_equality = true,
	},

	keymaps = {
		["q"] = {
			callback = function()
				vim.cmd([[ :AerialClose ]])
			end,
			desc = "Close the aerial window",
			nowait = true,
		},
	},
})

-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<F12>", "<cmd>AerialToggle!<CR>")
local found_telescope, telescope = pcall(require, "telescope")
if found_telescope then
	telescope.load_extension("aerial")
end
