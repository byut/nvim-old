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
        buffer = opts.buffer
    })
end

return M
