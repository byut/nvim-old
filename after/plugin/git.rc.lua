local gitsigns_status, gitsigns = pcall(require, "gitsigns")
if gitsigns_status then
    gitsigns.setup({})
end

local nvim = require("byut.utils.nvim")
local keymap = nvim.keymap.set

-- :Git add
keymap("<leader>ga", ":Git add %:p<CR>")
keymap("<leader>gc", ":Git commit<CR>")
keymap("<leader>gr", ":Git restore %:p<CR>")
keymap("<leader>gp", ":Git push origin HEAD<CR>")
keymap("<leader>gl", ":Git log --pretty=fuller<CR>")
keymap("<leader>gs", ":Git status<CR>")
