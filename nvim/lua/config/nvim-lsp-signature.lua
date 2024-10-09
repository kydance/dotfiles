-- LSP signature

local ok, cfg = pcall(require, "lsp_signature")

if not ok then
	return
end

cfg.setup({
	bind = true,
	doc_lines = 0,
	handler_opts = {
		border = "none",
	},

	floating_window = true,
	floating_window_above_cur_line = true,
	floating_window_off_x = 3,
	floating_window_off_y = 0,
	fix_pos = false,

	hint_enable = false,
	hint_prefix = "",
	hint_scheme = "Comment",
	hi_parameter = "LspSignatureActiveParameter",
	debug = false,

	toggle_key = "<M-p>",
	toggle_key_flip_floatwin_setting = true,
	select_signature_key = "<M-n>",
	timer_interval = 40,
	-- transparency = 1,
})

vim.keymap.set("n", "gH", function()
	vim.lsp.buf.signature_help()
end)
