return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "igorlfs/nvim-dap-view",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local view = require("dap-view")
      local widgets = require("dap.ui.widgets")
      local dapPython = require("dap-python")

      view.setup(
        {
          winbar = {
            show = true,
            -- You can add a "console" section to merge the terminal with the other views
            sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
            -- Must be one of the sections declared above
            default_section = "watches",
          },
          windows = {
            height = 12,
            terminal = {
              -- 'left'|'right'|'above'|'below': Terminal position in layout
              position = "left",
              -- List of debug adapters for which the terminal should be ALWAYS hidden
              hide = {},
              -- Hide the terminal when starting a new session
              start_hidden = true,
            },
          },
          -- Controls how to jump when selecting a breakpoint or navigating the stack
          switchbuf = "usetab",
        }
      )

      dapPython.setup("python")

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        view.open()
      end
    end,
  },
}
