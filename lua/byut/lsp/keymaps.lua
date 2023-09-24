local nvim = require("byut.utils.nvim")
local keymap = nvim.keymap.set

local M = {}

function M.set(bufnr)
    local opts = { buffer = bufnr }

    keymap("K", vim.lsp.buf.hover, opts)
    keymap("gr", vim.lsp.buf.references, opts)
    keymap("gd", vim.lsp.buf.definition, opts)
    keymap("gD", vim.lsp.buf.declaration, opts)
    keymap("gI", vim.lsp.buf.implementation, opts)
    keymap("gl", vim.diagnostic.open_float, opts)

    keymap("<leader>lj", vim.diagnostic.goto_next, opts)
    keymap("<leader>lk", vim.diagnostic.goto_prev, opts)
    keymap("<leader>la", vim.lsp.buf.code_action, opts)
    keymap("<leader>lr", vim.lsp.buf.rename, opts)

    keymap("<leader>qd", vim.diagnostic.setqflist, opts)
end

return M
