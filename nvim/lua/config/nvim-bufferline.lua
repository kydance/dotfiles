-- Buffer line

local is_ok, cfg= pcall(require, 'bufferline')
if not is_ok then
    return
end

cfg.setup({
    options = {
        diagnostics = "nvim_lsp",
        mode = 'buffers',

        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            padding = 1,
        }},
    }
})


-- buffer line
vim.keymap.set({"v", "n"}, "gt", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set({"v", "n"}, "gT", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set({'n'}, 'ZZ', function()
    if vim.bo.modified then
        vim.cmd.write()
    end
    local buf = vim.fn.bufnr()
    cfg.cycle(-1)
    vim.cmd.bdelete(buf)
end)

vim.cmd [[
    aug buffer_accessed_time
        au!
        au BufEnter,BufWinEnter * let b:accessedtime = localtime()
    aug END

    function! BufferLineSortByMRU()
        lua require'bufferline'.sort_buffers_by(function(a, b) return (vim.b[a.id].accessedtime or 0) > (vim.b[b.id].accessedtime or 0) end)
    endfunction

    command -nargs=0 BufferLineSortByMRU call BufferLineSortByMRU()
]]
