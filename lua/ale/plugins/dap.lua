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
      local widgets = require("dap.ui.widgets")

      require("dap-python").setup("python3")

      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red', linehl = '', numhl = '' })

      local kmopts = { noremap = true, silent = true }

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, kmopts)
      vim.keymap.set("n", "<leader>dc", dap.continue, kmopts)
      vim.keymap.set("n", "<leader>do", dap.step_over, kmopts)
      vim.keymap.set("n", "<leader>di", dap.step_into, kmopts)
      vim.keymap.set("n", "<leader>dO", dap.step_out, kmopts)
      vim.keymap.set("n", "<leader>dq", dap.terminate, kmopts)
      vim.keymap.set('n', '<Leader>dr', dap.repl.open, kmopts)
      vim.keymap.set('n', '<Leader>dl', dap.run_last, kmopts)
      vim.keymap.set("n", "<leader>dd", view.toggle, kmopts)
      vim.keymap.set({ 'n', 'v' }, '<Leader>dh', widgets.hover, kmopts)
      vim.keymap.set({ 'n', 'v' }, '<Leader>dp', widgets.preview, kmopts)
      vim.keymap.set('n', '<Leader>df', function() widgets.centered_float(widgets.frames) end, kmopts)
      vim.keymap.set('n', '<Leader>ds', function() widgets.centered_float(widgets.scopes) end, kmopts)
    end,
  },
}
