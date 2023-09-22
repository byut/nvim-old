local nvim = require("byut.utils.nvim")
local keymap = nvim.keymap.set

vim.g.timeoutlen = 500
vim.g.mapleader = " "

-- Normal mode --
-- Navigate through open windows
keymap("<C-h>", "<C-w>h")
keymap("<C-j>", "<C-w>j")
keymap("<C-k>", "<C-w>k")
keymap("<C-l>", "<C-w>l")

-- Navigate through open tabs
keymap("<S-h>", ":tabprev<CR>")
keymap("<S-l>", ":tabnext<CR>")

-- Resize the window in focus
keymap("<C-Up>", "<C-w>+")
keymap("<C-Left>", "<C-w><")
keymap("<C-Right>", "<C-w>>")
keymap("<C-Down>", "<C-w>-")

-- Split the screen vertically or horizontally
keymap("<leader>wv", ":vsplit<CR>")
keymap("<leader>wh", ":split<CR>")

-- Open the current buffer in a new tab
keymap("<leader>wt", ":tab split<CR>")

-- Pend the lines below to the current line
-- and keep the cursor in the same place
keymap("J", "mzJ`z")

-- Jump across the current file
-- and keep the search terms in the middle
keymap("n", "nzzzv")
keymap("N", "Nzzzv")

-- Jump to the previous buffer
keymap("<C-o>", "<C-^>")

-- Stop the highlighting for the `hlsearch` option
keymap("<C-r>", ":nohlsearch<CR>")

-- Visual Mode --
-- Move selected lines
keymap("J", ":m '>+1<CR>gv=gv", { mode = "v" })
keymap("K", ":m '<-2<CR>gv=gv", { mode = "v" })
