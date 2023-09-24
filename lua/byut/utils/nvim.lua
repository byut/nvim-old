local M = {}

---@class map_arguments
---@field mode? string | string[]
---@field silent? boolean
---@field noremap? boolean
---@field nowait? boolean
---@field expr? boolean
---@field buffer? integer | boolean | nil

M.keymap = {}

---Adds a new |mapping|
---@param lhs string Left-hand side |{lhs}| of the mapping
---@param rhs string|function Right-hand side |{rhs}| of the mapping
---@param opts map_arguments|nil Table of |:map_arguments|
M.keymap.set = function(lhs, rhs, opts)
    opts = opts or {}
    vim.keymap.set(opts.mode or "n", lhs, rhs, {
        silent = opts.silent or true,
        noremap = opts.noremap or true,
        nowait = opts.nowait or false,
        expr = opts.expr or false,
        buffer = opts.buffer,
    })
end

---@return string, integer[]
M.cword = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.fn.getline(vim.fn.line(".")) --[[@cast line string]]
    local line_len = string.len(line)

    ---@param char string
    ---@return boolean
    local function char_validate(char)
        if #char ~= 1 then
            return false
        end

        local special = "!\"#$%&'()*+,-./:;<=>?@[\\]^`{|}~ "
        for i = 1, string.len(special), 1 do
            if char == special:sub(i, i) then
                return false
            end
        end

        return true
    end

    local left = cursor[2] + 1
    local right = cursor[2] > 0 and cursor[2] or 1
    if not (char_validate(line:sub(left, left)) or char_validate(line:sub(right, right))) then
        return "", { -1, -1 }
    end

    while left > 1 or right < line_len do
        local lchar_is_valid = char_validate(line:sub(left - 1, left - 1))
        if left - 1 >= 1 and lchar_is_valid then
            left = left - 1
        end

        local rchar_is_valid = char_validate(line:sub(right + 1, right + 1))
        if right + 1 <= line_len and rchar_is_valid then
            right = right + 1
        end

        if
            (not lchar_is_valid and not rchar_is_valid)
            or (not lchar_is_valid and right + 1 > line_len)
            or (not rchar_is_valid and left < 1)
        then
            break
        end
    end

    return line:sub(left, right), { left - 1, right - 1 }
end

return M
