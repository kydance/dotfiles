-- local theme = 'gruvbox'
-- local theme = 'nord'
local theme = 'zephyr'

local ok, _ = pcall(vim.cmd, "colorscheme " .. theme)

if not ok then
    return
end
