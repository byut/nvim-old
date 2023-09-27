local dap_status, dap = pcall(require, "dap")
local dap_ui_status, dap_ui = pcall(require, "dapui")
if not (dap_status and dap_ui_status) then
    return
end

-- Keymaps ------------------------------------------------------------------

local keymap = require("byut.utils.nvim").keymap.set

-- Start debugging session
keymap("<leader>ds", function()
    dap.continue()
    dap_ui.open()
end)

keymap("<leader>dc", dap.continue)
keymap("<leader>dn", dap.step_over)
keymap("<leader>di", dap.step_into)
keymap("<leader>do", dap.step_out)

keymap("<leader>db", dap.toggle_breakpoint)
keymap("<leader>dC", dap.clear_breakpoints)

keymap("<leader>dl", require("dap.ui.widgets").hover)

-- End debugging session
keymap("<leader>de", function()
    dap_ui.close()
    dap.terminate()
end)

-- User Interface -----------------------------------------------------------

dap_ui.setup({})
vim.fn.sign_define("DapBreakpoint", { text = " " })

-- Adapters -----------------------------------------------------------------

require("byut.dap.adapters.codelldb").setup(dap)
