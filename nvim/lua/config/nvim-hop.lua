-- Smart move

local ok, cfg = pcall(require, "hop")

if not ok then
    return
end

cfg.setup({
    vim.keymap.set({'n', 'v'}, ',', function() cfg.hint_char1({ current_line_only = false }) end, { remap=true }),
})
