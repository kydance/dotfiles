-- Notification system configuration

local util = require("util")
local ok, notify = pcall(require, "notify")
if not ok then
	util.log_warn("notify load failed")
	return
end

-- Get screen dimensions safely
local function get_max_width()
	local width = vim.o.columns
	return math.min(120, math.floor(width * 0.6))
end

local function get_max_height()
	local height = vim.o.lines
	return math.min(20, math.floor(height * 0.25))
end

notify.setup({
	-- Animation style: "fade", "slide", "fade_in_slide_out", "static"
	stages = "static",

	-- Render style: "default", "minimal", "simple", "compact"
	render = "minimal",

	-- Notification timeout in milliseconds
	timeout = 3000,

	-- Background color
	background_colour = "Normal",

	-- Size constraints
	max_width = get_max_width(),
	max_height = get_max_height(),

	-- Minimum log level to display
	-- Hierarchy: ERROR > WARN > INFO > DEBUG > TRACE
	level = "INFO",

	-- Icons for different notification levels
	icons = {
		ERROR = "✗",
		WARN = "⚠",
		INFO = "i",
		DEBUG = "",
		TRACE = "✎",
	},

	-- Function called when a new window is opened, use for enhancing appearance
	on_open = function(win)
		vim.api.nvim_win_set_config(win, { border = "rounded" })
		-- Optional: set window transparency
		if vim.api.nvim_win_set_option then
			vim.api.nvim_win_set_option(win, "winblend", 10)
		end
	end,
})

-- Override the global notify function
vim.notify = notify
