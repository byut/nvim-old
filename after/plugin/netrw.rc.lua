local nvim = require("byut.utils.nvim")

vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    callback = function()
        local keymap = function(lhs, rhs)
            nvim.keymap.set(lhs, rhs, { buffer = 0 })
        end

        keymap("<C-h>", "<C-w>h")
        keymap("<C-j>", "<C-w>j")
        keymap("<C-k>", "<C-w>k")
        keymap("<C-l>", "<C-w>l")
    end,
})

nvim.keymap.set("<leader>eo", ":Explore<CR>")
