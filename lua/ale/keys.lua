-- Shared keymap helper: every mapping in the config goes through here so that
-- all maps get --noremap--, --silent--, and a --desc-- consistently.
local M = {}

---Set a keymap with common options.
---@param mode string|string[] Mode(s), e.g. "n" or { "n", "v" }
---@param lhs string Left-hand side (the keys pressed)
---@param rhs string|function Right-hand side (command, keys, or callback)
---@param desc string Human-readable description (shown in :map, Mini.clue, etc.)
---@param opts table|nil Extra options merged on top (e.g. { expr = true })
function M.map(mode, lhs, rhs, desc, opts)
  vim.keymap.set(
    mode,
    lhs,
    rhs,
    vim.tbl_extend("force", { noremap = true, silent = true, desc = desc }, opts or {})
  )
end

return M