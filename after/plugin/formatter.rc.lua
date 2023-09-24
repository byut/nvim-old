local formatter_status, formatter = pcall(require, "formatter")
if not formatter_status then
    return
end

formatter.setup({
    filetype = {
        c = { require("formatter.filetypes.c").clangformat },
        cpp = { require("formatter.filetypes.cpp").clangformat },
        lua = { require("formatter.filetypes.lua").stylua },
        rust = { require("formatter.filetypes.rust").rustfmt },
        python = { require("formatter.filetypes.python").black() },
        css = { require("formatter.filetypes.css").prettierd },
        html = { require("formatter.filetypes.html").prettierd },
        json = { require("formatter.filetypes.json").prettierd },
        yaml = { require("formatter.filetypes.yaml").prettierd },
        markdown = { require("formatter.filetypes.markdown").prettierd },
        javascript = { require("formatter.filetypes.javascript").prettierd },
        typescript = { require("formatter.filetypes.typescript").prettierd },
        javascriptreact = { require("formatter.filetypes.javascriptreact").prettierd },
        typescriptreact = { require("formatter.filetypes.typescriptreact").prettierd },
    },
})

vim.api.nvim_create_augroup("FormatAutogroup", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    group = "FormatAutogroup",
    callback = function()
        vim.cmd([[FormatWrite]])
    end,
})
