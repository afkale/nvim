return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "djlint", "flake8", "ty" }
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        if not vim.opt_local.modifiable:get() then return end

        local available = vim.tbl_filter(function(linter)
          local cmd = lint.linters[linter] and lint.linters[linter].cmd
          return cmd and vim.fn.executable(cmd) == 1
        end, lint.linters_by_ft[vim.bo.filetype] or {})

        if #available > 0 then
          lint.try_lint(available)
        end
      end,
    })
  end,
}
