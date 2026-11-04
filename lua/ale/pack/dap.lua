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

-- C/C++/Rust debugging via lldb
dap.adapters.lldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = '/usr/bin/lldb-dap',
    args = { '-p', '${port}' },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- JavaScript/TypeScript debugging via node (requires nvim-node-debugger or similar)
local function js_based_languages()
  local langs = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' }
  for _, lang in ipairs(langs) do
    dap.configurations[lang] = {
      {
        type = 'node2',
        request = 'attach',
        name = 'Attach to node process',
        processId = require 'dap.utils'.pick_process,
        cwd = '${workspaceFolder}',
      },
    }
  end
end
js_based_languages()

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "DiagnosticError", })
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "DiagnosticWarn", }
)
vim.fn.sign_define("DapBreakpointRejected", { text = "●", texthl = "DiagnosticHint", linehl = "", numhl = "", })
vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticInfo", linehl = "", numhl = "DiagnosticInfo", })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "CursorLine", numhl = "DiagnosticOk", })

local map = require("ale.keys").map

-- DAP leader group: <leader>d + key
map("n", "<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, "Set conditional breakpoint")
map("n", "<leader>dl", dap.run_last, "Run last debug config")
map("n", "<leader>dc", dap.continue, "Continue debugging")
map("n", "<leader>do", dap.step_over, "Step over")
map("n", "<leader>di", dap.step_into, "Step into")
map("n", "<leader>dO", dap.step_out, "Step out")
map("n", "<leader>dq", dap.terminate, "Terminate debugging")
map("n", "<leader>dr", dap.repl.open, "Open debugger repl")
map("n", "<leader>dd", view.toggle, "Toggle debugger ui")
map({ "n", "v" }, "<leader>dh", widgets.hover, "Hover variable")
map({ "n", "v" }, "<leader>dp", widgets.preview, "Preview variable")
