-- Update ctags
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    vim.fn.system("ctags -a " .. vim.fn.expand("%"))
  end,
})

-- Auto formatting files
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          if not vim.g.autoformat then return end

          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end,
})

-- Setup mini completion config
local on_attach = function(args)
  vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
end
vim.api.nvim_create_autocmd('LspAttach', { callback = on_attach })

-- Open QuickfixList always after grep
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "grep",
  command = "copen"
})
