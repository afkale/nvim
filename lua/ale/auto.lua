-- Auto formatting files
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if not vim.g.autoformat then return end

    vim.lsp.buf.format({ async = false })
  end,
})

-- Open QuickfixList always after grep
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "grep",
  command = ":lua require('quicker').open()"
})
