-- Centralised external-tool detection.
-- Probes once at load time so the rest of the config can use the cached result.

local M = {}

M.has_rg = vim.fn.executable("rg") == 1
M.has_ag = vim.fn.executable("ag") == 1
M.has_fd = vim.fn.executable("fd") == 1
M.has_fzf = vim.fn.executable("fzf") == 1

return M
