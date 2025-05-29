local utils = require("ale.extra.utils")


local function grep()
	local find = vim.fn.input({ prompt = "Search: ", text = "<complete>" })
	if not find then return end

	vim.cmd("sil!grep! " .. find)

	local items = #vim.fn.getqflist() > 1
	if not items then return end

	vim.cmd("copen")
end

local function grep_and_replace()
	local find = vim.fn.input({ prompt = "Search: " })
	local replace = vim.fn.input({ prompt = "Replace: " })
	if not find or not replace then return end

	local safe_find = vim.fn.escape(find, '/\\')

	vim.cmd("sil!grep! " .. find)
	local items = #vim.fn.getqflist() > 1
	if not items then return end

	vim.cmd("cdo s/" .. safe_find .. "/" .. replace .. "/gc | update")
	vim.cmd("cclose")
end

utils.kmset("n", "<leader>ff", ":find ")
utils.kmset("n", "<leader>fh", ":help ")
utils.kmset("n", "<leader>hw", ":help <C-R>=expand('<cword>')<CR><CR>")
utils.kmset("n", "<leader>fg", grep)
utils.kmset("n", "<leader>crn", grep_and_replace)
