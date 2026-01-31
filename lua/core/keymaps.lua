-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map helper
local M = {}
local function map(mode, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    opts.noremap = opts.noremap ~= false
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end
M.map = map

-- Window management
map("n", "<C-w>o", "<cmd>only<CR>",   "Close other windows")
map("n", "<C-w>d", "<cmd>close<CR>",  "Close current window")
map("n", "<C-w>s", "<cmd>split<CR>",  "Horizontal split")
map("n", "<C-w>v", "<cmd>vsplit<CR>", "Vertical split")
map("n", "<C-w>=",  "<cmd>vertical resize -5<CR>", "Shrink window width")
map("n", "<C-w>.", "<cmd>vertical resize +5<CR>", "Increase window width")
map("n", "<C-w>=",    "<cmd>resize +3<CR>", "Increase window height")
map("n", "<C-w>-",  "<cmd>resize -3<CR>", "Decrease window height")
map("n", "<C-w>r", "<C-w>=", "Equalize window sizes")

-- Move lines (Normal)
map("n", "<M-j>", function()
    local n = vim.v.count1
    vim.cmd("m .+" .. n)
    vim.cmd("normal! ==")
end, "Move line down")
map("n", "<M-k>", function()
    local n = vim.v.count1
    vim.cmd("m .-" .. (n + 1))
    vim.cmd("normal! ==")
end, "Move line up")

-- Move selection (Visual)
map("v", "<M-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "<M-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- Visual keep selection
map("v", ">", ">gv", "Indent selection")
map("v", "<", "<gv", "Outdent selection")
map("v", "=", "=gv", "Format selection")

return M
