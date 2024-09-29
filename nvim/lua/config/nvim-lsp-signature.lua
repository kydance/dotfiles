-- LSP signature

local ok, cfg = pcall(require, "lsp_signature")

if not ok then
    return
end

cfg.setup({
    bind = false,
    doc_lines = 0,
    handler_opts = {
        border = "single",
    },

    floating_window = true,
    floating_window_above_cur_line = true,
    floating_window_off_x = 1,
    floating_window_off_y = 0,
    fix_pos = true,
    hint_enable = true,

    -- hint_prefix = require'archvim.options'.nerd_fonts and "" or "",
    hint_prefix = "",
    hint_scheme = "Comment",
    hi_parameter = "LspSignatureActiveParameter",
    debug = false,

    toggle_key = '<M-p>',
    toggle_key_flip_floatwin_setting = true,
    select_signature_key = '<M-n>',
    timer_interval = 40,
    -- transparency = 1,
})

vim.keymap.set('n', 'gH', function ()
    vim.lsp.buf.signature_help()
end)
