local M = {}

function M.init()
    require("byut.lsp.handlers.diagnostics")
    require("byut.lsp.handlers.rename")
    require("byut.lsp.handlers.hover")
end

return M
