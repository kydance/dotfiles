-- Notify

local util = require("util")
local ok, notify = pcall(require, "notify")
if not ok then
	util.log_warn("notify init failed!")
	return
end

notify.setup({
	-- "fade", "slide", "fade_in_slide_out", "static"
	stages = "static",

	-- "default" "minimal" "simple" "compact"
	render = "minimal",

	timeout = 2400,
	background_colour = "Normal",
	max_width = math.floor(vim.api.nvim_win_get_width(0) / 2),
	max_height = math.floor(vim.api.nvim_win_get_height(0) / 4),

	-- ERROR > WARN > INFO > DEBUG > TRACE
	level = "INFO",
})

vim.notify = notify
