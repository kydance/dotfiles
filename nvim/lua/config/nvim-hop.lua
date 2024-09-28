local ok, hop = pcall(require, "hop")

if not ok then
    return
end

hop.setup({
    vim.keymap.set('', ',', function()
        hop.hint_char1({ current_line_only = false })
    end, {remap=true})
})

