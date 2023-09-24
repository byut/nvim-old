local cmp_status, cmp = pcall(require, "cmp_nvim_lsp")
local lsp_keymaps = require("byut.lsp.keymaps")
local opts = {}

-- executes whenever a language server
-- is attached to a buffer
opts.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    lsp_keymaps.set(bufnr)
end

if cmp_status then
    opts.capabilities = cmp.default_capabilities()
    opts.capabilities.offsetEncoding = { "utf-16" }
end

return opts
