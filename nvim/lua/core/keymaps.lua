vim.g.mapleader = " "

local keymap = vim.keymap
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

----------------------------------
-- Insert mode --
----------------------------------
keymap.set("i", "jk", "<ESC>")

----------------------------------
-- Normal mode --
----------------------------------
-- New windows
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- Resize with arrows
-- delta: 2 lines
keymap.set("n", "<C-Uper>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- 文件
keymap.set("n", "<leader>w", ":w!<CR>") -- Save file
keymap.set("n", "<leader>q", ":q<CR>") -- Quit file

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 光标快速移动
keymap.set({ "n", "v" }, "H", "^") -- 移动光标至行首
keymap.set({ "n", "v" }, "L", "$") -- 移动光标至行尾

----------------------------------
-- Visual mode --
----------------------------------
-- Hint: start visual mode with the same area as the previous area and the same mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- IncRename
vim.keymap.set("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- Markdown Preview
vim.keymap.set("n", "<leader>mdp", ":MarkdownPreview<CR>")
