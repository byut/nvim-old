local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, sign in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = sign, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    underline = true,
    severity_sort = true,
    float = {
        header = "",
        border = "single",
        source = false,
    },
    virtual_text = {
        spacing = 4,
        prefix = function(diagnostic)
            return ({
                [vim.diagnostic.severity.ERROR] = "E:",
                [vim.diagnostic.severity.WARN] = "W:",
                [vim.diagnostic.severity.INFO] = "I:",
                [vim.diagnostic.severity.HINT] = "H:",
            })[diagnostic.severity]
        end,
    },
})
