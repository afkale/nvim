return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      {
        "igorlfs/nvim-dap-view",
        opts = {
          -- winbar: optional, show section labels
          winbar = {
            show = true,
            sections = { "watches", "exceptions", "breakpoints", "threads", "repl" },
            default_section = "watches",
          },

          windows = {
            terminal = {
              position = "left",
              hide = {}, -- which adapters to hide terminal
            },
          },

          auto_toggle = true, -- open / close dap-view automatically

        }
      },
    },
    config = function()
      local dap = require("dap")
      local view = require("dap-view")
      require("dap-python").setup("python3")

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        view.open()
      end

      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red', linehl = '', numhl = '' })
    end,
  },
}
