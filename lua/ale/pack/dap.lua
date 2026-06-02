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

local kmopts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, kmopts)
vim.keymap.set("n", "<leader>dc", dap.continue, kmopts)
vim.keymap.set("n", "<leader>do", dap.step_over, kmopts)
vim.keymap.set("n", "<leader>di", dap.step_into, kmopts)
vim.keymap.set("n", "<leader>dO", dap.step_out, kmopts)
vim.keymap.set("n", "<leader>dq", dap.terminate, kmopts)
vim.keymap.set("n", "<Leader>dr", dap.repl.open, kmopts)
vim.keymap.set("n", "<Leader>dl", dap.run_last, kmopts)
vim.keymap.set("n", "<leader>dd", view.toggle, kmopts)
vim.keymap.set({ "n", "v" }, "<Leader>dh", widgets.hover, kmopts)
vim.keymap.set({ "n", "v" }, "<Leader>dp", widgets.preview, kmopts)
