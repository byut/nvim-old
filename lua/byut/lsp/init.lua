local handlers = require("byut.lsp.handlers")
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

local servers = require("byut.mason.packages").list.language_servers
for _, server in pairs(servers) do
    local server_opts = require("byut.lsp.opts")
    local opts_status, opts = pcall(require, "byut.lsp.settings." .. server)
    if opts_status then
        server_opts = vim.tbl_deep_extend("force", opts, server_opts)
    end

    lspconfig[server].setup(server_opts)
end

handlers.init()
