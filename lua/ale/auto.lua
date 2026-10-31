-- LSP completion, format-on-save, spell checking and quickfix hooks.

-- Editor behaviour that is independent of LSP.
local edit_group = vim.api.nvim_create_augroup('my.edit', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = edit_group,
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en'
  end,
})

-- Return to the last edit position. Commit and rebase buffers are excluded so
-- they always open at the top.
vim.api.nvim_create_autocmd('BufReadPost', {
  group = edit_group,
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == 'gitcommit' or ft == 'gitrebase' then
      return
    end
    if vim.api.nvim_get_current_buf() ~= args.buf then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- One group for all LSP hooks. Creating it once (clear = true) keeps reloading this
-- file idempotent; creating it inside LspAttach would wipe the group every time
-- another client attaches.
local lsp_group = vim.api.nvim_create_augroup('my.lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Format on save with the first attached client that supports formatting.
-- A single handler avoids one BufWritePre per LSP client.
vim.api.nvim_create_autocmd('BufWritePre', {
  group = lsp_group,
  callback = function(args)
    local client = vim.lsp.get_clients({
      bufnr = args.buf,
      method = 'textDocument/formatting',
    })[1]

    -- Skip when the server already formats via willSaveWaitUntil.
    if not client or client:supports_method('textDocument/willSaveWaitUntil') then
      return
    end

    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
  end,
})

-- Open QuickfixList always after grep
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = lsp_group,
  pattern = 'grep',
  command = ":lua require('quicker').open()",
})
