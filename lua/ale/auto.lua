-- LSP completion, format-on-save, spell checking and quickfix hooks.

-- Editor behaviour that is independent of LSP.
local edit_group = vim.api.nvim_create_augroup('my.edit', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = edit_group,
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en'
    vim.opt_local.wrap = true
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

-- Auto-create parent directories when saving a new file
vim.api.nvim_create_autocmd('BufWritePre', {
  group = edit_group,
  callback = function(args)
    local filepath = vim.api.nvim_buf_get_name(args.buf)
    if filepath ~= '' then
      local dir = vim.fn.fnamemodify(filepath, ':h')
      if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, 'p')
      end
    end
  end,
})

-- Resize splits on window resize (helps with tmux)
vim.api.nvim_create_autocmd('VimResized', {
  group = edit_group,
  command = 'tabdo wincmd =',
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
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- Use LSP's inlay hints if supported (e.g. rust-analyzer, lua_ls)
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
  end,
})

-- Format on save with the first attached client that supports formatting.
-- A single handler avoids one BufWritePre per LSP client.
vim.api.nvim_create_autocmd('BufWritePre', {
  group = lsp_group,
  callback = function(args)
    -- Respect the manual format toggle (gft in lsp.lua).
    if not vim.g.autoformat then
      return
    end

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

-- Augroup for tool integrations (quickfix, etc.)
local tools_group = vim.api.nvim_create_augroup('my.tools', { clear = true })

-- Open QuickfixList always after grep
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = tools_group,
  pattern = 'grep',
  command = ":lua require('quicker').open()",
})
