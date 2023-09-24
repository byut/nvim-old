local pkg_core_status, pkg_core = pcall(require, "mason-core.package")
local registry_status, registry = pcall(require, "mason-registry")

local M = {
    list = {
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
        end))
    end
end

return M
