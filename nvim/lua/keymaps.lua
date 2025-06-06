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
keymap.set("n", "<leader>j", ":resize -2<CR>", opts)
keymap.set("n", "<leader>k", ":resize +2<CR>", opts)
keymap.set("n", "<leader>h", ":vertical resize -2<CR>", opts)
keymap.set("n", "<leader>l", ":vertical resize +2<CR>", opts)

-- Ctrl + hjkl  窗口之间跳转
-- keymap.set("n", "<C-h>", "<C-w>h", opts)
-- keymap.set("n", "<C-j>", "<C-w>j", opts)
-- keymap.set("n", "<C-k>", "<C-w>k", opts)
-- keymap.set("n", "<C-l>", "<C-w>l", opts)

-- 文件
keymap.set("n", "<leader>w", ":w!<CR>", { desc = "Save" }) -- Save file
keymap.set("n", "<leader>q", ":wq<CR>", { desc = "Save and quit" }) -- Quit file

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 光标快速移动
keymap.set({ "n", "v" }, "H", "^", { desc = "Move to start of line" }) -- 移动光标至行首
keymap.set({ "n", "v" }, "L", "$", { desc = "Move to end of line" }) -- 移动光标至行尾

----------------------------------
-- Visual mode --
----------------------------------
-- Hint: start visual mode with the same area as the previous area and the same mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set({ "n" }, "J", "5j")

-- Visual mode, 粘贴不要复制
keymap.set("v", "p", '"_dP', opts)

-- IncRename
vim.keymap.set("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- Markdown Preview
vim.keymap.set("n", "<leader>mdp", ":MarkdownPreview<CR>")
