-- Toggleterm: Terminal

local util = require("util")
local ok, cfg = pcall(require, "toggleterm")
if not ok then
    util.log_warn("nim-toggleterm init failed.")
    return
end

cfg.setup({
    shell = vim.o.shell,   -- change the default shell
    open_mapping = [[<C-t>]], --  How to open a new terminal

    size = 10,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    direction = "float", -- "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shade_filetypes = {},
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "single",
        winblend = 0,
    },
})

-- define key mappints
--  t: terminal mode
function _G.set_terminal_keymaps()
    local opts = { noremap = true, buffer = 0 }

    vim.keymap.set("n", "<Esc>", [[<Cmd>quit<CR>]], opts)
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], opts)

    -- Use <C-\> to toggle terminals when direction='float'
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)

    -- We can use <C-h/j/k/l> to move cursor among windows(including terminal window)
    -- If we set direction='float', these key mappings wont' helpful
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Toggleterm also exposes the `Terminal` class so that this can be used to create
-- custom terminals for showing terminal UIs like `lazygit`, `htop` etc.
local Terminal = require("toggleterm.terminal").Terminal

-- cmd = string -- command to execute when creating the terminal e.g. 'top'
local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
    htop:toggle()
end
