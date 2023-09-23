---@return string
function _G.nvim_tabline()
    local s = ""
    for i = 1, vim.fn.tabpagenr("$") do
        local bufnr = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
        local bufname = vim.fn.bufname(bufnr)
        local bufselected = vim.fn.tabpagenr() == i
        local bufmodified = vim.fn.getbufvar(bufnr, "&mod") == 1
        s = s .. "%" .. "T" .. (bufselected and "%#TabLineSel#" or "%#TabLine#")
        s = s .. " " .. vim.fn.fnamemodify(bufname, ":t") .. " " .. (bufmodified and "[+]" .. " " or "")
    end

    return s .. "%#TabLineFill#"
end

vim.o.showtabline = 1
vim.o.tabline = "%!v:lua.nvim_tabline()"
