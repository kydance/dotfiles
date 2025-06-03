-- Aerial: code outline and symbol navigation plugin

local util = require("util")
local is_ok, aerial = pcall(require, "aerial")
if not is_ok then
	util.log_warn("aerial load failed")
	return
end

aerial.setup({
	-- 当 aerial 附加到缓冲区时设置快捷键
	on_attach = function(bufnr)
		-- 使用 '{' 和 '}' 在符号之间跳转
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "PrevSymbol" })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "NextSymbol" })

		vim.keymap.set("n", "<leader>as", "<cmd>AerialNavToggle<CR>", { buffer = bufnr, desc = "SymbolQuickNav" })
	end,

	-- Automatically open aerial when entering supported buffers.
	-- This can be a function (see :help aerial-open-automatic)
	open_automatic = true,

	layout = {
		default_direction = "right",
		max_width = { 64, 0.2 },
		min_width = 24,
		width = nil, -- automatic
		resize_to_content = true,
		preserve_equality = true,
		placement = "edge",
	},

	icons = {
		show_icons = true,
		icons = "nvim-web-devicons",
		prioritize_glyph = true,
	},

	window = {
		width = nil,
		height = nil,
		border = "rounded",
		background_highlight = "Normal",
	},

	-- 快捷键设置
	keymaps = {
		["?"] = {
			callback = function()
				vim.cmd([[h aerial]])
			end,
			desc = "显示帮助文档",
		},
		["q"] = {
			callback = function()
				vim.cmd([[ :AerialClose ]])
			end,
			desc = "关闭大纲窗口",
			nowait = true,
		},
		["<CR>"] = {
			callback = function()
				aerial.select()
			end,
			desc = "跳转",
		},
		["o"] = {
			callback = function()
				aerial.select()
			end,
			desc = "选择",
		},
		["<Esc>"] = {
			callback = function()
				vim.cmd([[ :AerialClose ]])
			end,
			desc = "关闭大纲窗口",
		},
	},

	-- 性能优化
	throttle = 500, -- 节流更新间隔（毫秒）
	lazy_load = true, -- 懒加载符号
	close_automatic_events = { "unsupported" }, -- 当切换到不支持的缓冲区时自动关闭

	-- 高亮设置
	highlight_mode = "split_width", -- 根据分割宽度决定高亮模式
	highlight_closest = true, -- 高亮最接近的符号
	highlight_on_hover = true, -- 悬停时高亮符号
	highlight_on_jump = 300, -- 跳转后高亮持续时间（毫秒）
})

-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<F12>", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })

-- Telescope 集成
local found_telescope, telescope = pcall(require, "telescope")
if found_telescope then
	telescope.load_extension("aerial")
	-- 添加使用 Telescope 搜索符号的快捷键
	vim.keymap.set("n", "<leader>a.", "<cmd>Telescope aerial<CR>", { desc = "搜索符号" })
end

-- 添加状态栏集成
local found_lualine, _ = pcall(require, "lualine")
if found_lualine then
	-- 注意：这需要在lualine配置中添加 aerial 组件
	vim.g.aerial_lualine = true
end

-- 添加命令别名以便于使用
vim.cmd([[command! AerialNavOpen lua require('aerial').nav_open()]])

-- 添加自动命令以在特定文件类型中自动打开 Aerial（不跳转光标）
local augroup = vim.api.nvim_create_augroup("AerialAutoOpen", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "python", "go", "lua", "rust", "typescript", "javascript" },
	callback = function()
		-- 延迟加载以确保文件已完全加载
		vim.defer_fn(function()
			if vim.bo.buftype == "" and vim.fn.winnr("$") == 1 then
				local current_win = vim.api.nvim_get_current_win() -- save current window ID
				vim.cmd("AerialOpen") -- open Aerial window
				vim.api.nvim_set_current_win(current_win) -- ensure cursor returns to original window
			end
		end, 300)
	end,
	desc = "在特定文件类型中自动打开 Aerial (不跳转光标)",
})
