local theme = 'gruvbox'

local ok, _ = pcall(vim.cmd, "colorscheme " .. theme)
if not ok then
    vim.notify('colorscheme ' .. theme .. ' not found!')
    return
end
