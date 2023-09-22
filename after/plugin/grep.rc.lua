local nvim = require("byut.utils.nvim")
local keymap = nvim.keymap.set

---@param str string
local function grep_string(str)
    if #str > 0 then
        local status, _ = pcall(
            vim.api.nvim_cmd,
            vim.api.nvim_parse_cmd(str.format("vimgrep /%s/j **/*", str), {}),
            { output = true }
        )

        if status then
            vim.cmd([[copen]])
        end
    end
end

keymap("<leader>qe", function()
    grep_string(vim.fn.input("Your regular expression: "))
end)

keymap("<leader>qw", function()
    local cword = vim.fn.expand("<cword>")
    grep_string(cword)
end)
