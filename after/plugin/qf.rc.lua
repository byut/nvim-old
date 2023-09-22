local nvim = require("byut.utils.nvim")
local keymap = nvim.keymap.set

keymap("<leader>qo", ":copen<CR>")
keymap("<leader>qc", ":ccl<CR>")

keymap("<leader>qn", ":cnext<CR>")
keymap("<leader>qN", ":cprev<CR>")
keymap("<leader>qp", ":cprev<CR>")
