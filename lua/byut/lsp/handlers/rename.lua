local nvim = require("byut.utils.nvim")

vim.lsp.handlers["textDocument/rename"] = vim.lsp.with(function(_, result, ctx, _)
    if not result then
        vim.notify("Language server couldn't provide rename result", vim.log.levels.INFO)
        return
    end

    local cword, pos = nvim.cword()
    if #cword > 0 then
        vim.api.nvim_win_set_cursor(0, {
            vim.api.nvim_win_get_cursor(0)[1],
            pos[1],
        })
    end

    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client ~= nil then
        vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
    end

    local cword_new, pos_new = nvim.cword()
    if #cword_new > 0 then
        vim.api.nvim_win_set_cursor(0, {
            vim.api.nvim_win_get_cursor(0)[1],
            pos_new[2],
        })
    end
end, {})
