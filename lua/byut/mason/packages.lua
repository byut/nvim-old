local lspconfig_status, lspconfig = pcall(require, "mason-lspconfig")
local pkg_core_status, pkg_core = pcall(require, "mason-core.package")
local registry_status, registry = pcall(require, "mason-registry")

local M = {
    list = {
        language_servers = {
            "tsserver",
            "cssmodules_ls",
            "rust_analyzer",
            "pyright",
            "jsonls",
            "cssls",
            "lua_ls",
            "cmake",
            "html",
            "bashls",
            "clangd",
        },
        formatters = {
            "black",
            "stylua",
            "prettierd",
            "clang-format",
        },
    },
}

function M.ensure()
    if pkg_core_status and registry_status then
        registry.refresh(vim.schedule_wrap(function()
            for group, pkgs in pairs(M.list) do
                if group == "language_servers" then
                    if lspconfig_status then
                        lspconfig.setup({
                            ensure_installed = pkgs,
                        })
                    end
                else
                    for _, name in ipairs(pkgs) do
                        local pkg_name, pkg_version = pkg_core.Parse(name)
                        local pkg_status, pkg = pcall(registry.get_package, pkg_name)
                        if pkg_status then
                            if not pkg:is_installed() then
                                vim.notify(("[mason.nvim] -> [%s]: Installing %s..."):format(group, pkg.name))
                                pkg:install({ version = version })
                            end
                        else
                            vim.notify(
                                ("[mason.nvim] -> [%s]: %s is not a valid package name"):format(group, pkg_name),
                                vim.log.levels.ERROR
                            )
                        end
                    end
                end
            end
        end))
    end
end

return M
