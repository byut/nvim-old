require("byut.colors.tokyonight")

---A list of all available colorschemes
---in the current Neovim configuration.
local colorschemes = vim.fn.getcompletion("", "color")

---Retrieve the most recently used colorscheme.
---@return string|nil
local function retrieve_colorscheme()
    local file = io.open(vim.fn.stdpath("data") .. "/color", "r")
    if not file then
        return nil
    end

    local data = file:read("*a")
    file:close()

    local colorscheme, _ = data:gsub("[\n\r]", "")
    return colorscheme
end

---Triggers when a new colorscheme is applied.
---Records the name of the newly applied colorscheme in a file.
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(info)
        for _, group_name in ipairs({
            "Normal",
            "NormalNC",
            "CursorLineNr",
            "CursorLineSign",
            "CursorLineFold",
            "SignColumn",
            "EndOfBuffer",
            "LineNr",
            "NonText",
        }) do
            vim.cmd(string.format("highlight %s guibg=NONE ctermbg=NONE", group_name))
        end

        local colorscheme = info.match
        if not vim.tbl_contains(colorschemes, colorscheme) then
            return
        end

        local file = io.open(vim.fn.stdpath("data") .. "/color", "w")
        if not file then
            return
        end

        file:write(string.format("%s\n", colorscheme))
        file:flush()
        file:close()
    end,
})

---Applies the most recent colorscheme. If it is not found
---or is unavailable, it defaults to retrobox.
vim.cmd.colorscheme(retrieve_colorscheme() or "retrobox")
