local dap_view_configs = {
  winbar = {
    show = true,
    sections = { "threads", "scopes", "breakpoints", "watches", "repl", "exceptions", "console" },
    default_section = "scopes",
  },
  windows = { terminal = { position = "left", hide = {}, }, },
  auto_toggle = true,
}

local dap = require("dap")
local view = require("dap-view")
local widgets = require("dap.ui.widgets")

view.setup(dap_view_configs)
require("dap-python").setup("python3")

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "DiagnosticError", })
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "DiagnosticWarn", }
)
vim.fn.sign_define("DapBreakpointRejected", { text = "●", texthl = "DiagnosticHint", linehl = "", numhl = "", })
vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticInfo", linehl = "", numhl = "DiagnosticInfo", })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "CursorLine", numhl = "DiagnosticOk", })

local map = require("ale.keys").map

map("n", "<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
map("n", "<leader>dc", dap.continue, "Continue debugging")
map("n", "<leader>do", dap.step_over, "Step over")
map("n", "<leader>di", dap.step_into, "Step into")
map("n", "<leader>dO", dap.step_out, "Step out")
map("n", "<leader>dq", dap.terminate, "Terminate debugging session")
map("n", "<leader>dr", dap.repl.open, "Open debugger REPL")
map("n", "<leader>dd", view.toggle, "Toggle dap-view UI")
map("n", "<leader>dl", dap.run_last, "Run last debug configuration")
map({ "n", "v" }, "<leader>dh", widgets.hover, "Hover over variable")
map({ "n", "v" }, "<leader>dp", widgets.preview, "Preview variable value")
