local comment_status, comment = pcall(require, "Comment")
if not comment_status then
    return
end

comment.setup({
    opleader = { line = "<leader>cc", block = "<leader>cb" },
    toggler = { line = "<leader>cc", block = "<leader>cbc" },
})
