local M = {}

local adapter = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.glob("~/.local/share/nvim/mason/packages/codelldb/codelldb"),
        args = { "--port", "${port}" },
    },
}

local configuration = {
    {
        name = "Debug",
        type = "codelldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
    },
}

M.setup = function(dap)
    dap.adapters["codelldb"] = adapter

    dap.configurations["c"] = configuration
    dap.configurations["cpp"] = configuration
    dap.configurations["rust"] = configuration
end

return M
