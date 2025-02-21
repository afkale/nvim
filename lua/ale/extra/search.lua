local utils = require("ale.extra.utils")

--- Executes a command in a floating window and handles the result.
---@param opts table Options for configuring the floating window command.
--- - `command` (string) : The shell command to execute.
--- - `capture_output` (boolean) : If true, saves the command output in a temporary file.
--- - `on_enter` (function) : A callback function to run when the floating window is created.
--- - `on_result` (function) : A callback function that receives the command output.
local function floating_window_command(opts)
	opts = opts or {}
	opts.capture_output = opts.capture_output ~= nil and opts.capture_output

	local float = utils.create_floating_window({})
	if opts.on_enter then opts.on_enter(float.buf, float.win) end

	local tmp = nil
	local command = opts.command

	if opts.capture_output then
		tmp = vim.fn.tempname()
		command = opts.command .. " > " .. tmp
	end

	vim.fn.termopen(command, {
		on_exit = function()
			local result = tmp and vim.fn.readfile(tmp) or {}

			vim.api.nvim_win_close(float.win, true)
			vim.api.nvim_buf_delete(float.buf, {})

			if opts.on_result then opts.on_result(result) end

			if tmp then vim.fn.delete(tmp) end
		end
	})
end


local function rg_search()
	vim.ui.input({ prompt = "Search for: " }, function(input)
		-- Define directories and files to ignore
		local wildignore = vim.opt.wildignore:get()

		-- Convert the table into `--ignore-file` flags for `rg`
		local ignore_files = ""
		for _, pattern in ipairs(wildignore) do
			pattern = pattern:gsub("**/", "*/")
			ignore_files = ignore_files .. " --glob '!" .. pattern .. "'"
		end

		if input then
			-- Construct and run the `rg` command
			local cmd = vim.opt.grepprg:get() .. " " .. vim.fn.shellescape(input) .. ignore_files
			local results = vim.fn.systemlist(cmd)

			if #results > 0 then
				-- Clear insert
				vim.cmd("stopinsert")

				-- Create a quickfixlist from the results to replace old results
				vim.fn.setqflist({}, "r", { title = "Search Results", lines = results })
				vim.cmd("botright copen")
			end
		end
	end)
end

vim.api.nvim_create_user_command("RgSearch", rg_search, {
	desc = "Search for a pattern in files using ripgrep (rg)."
})
vim.keymap.set("n", "<leader>fs", ":RgSearch<CR>")



local fzf = function(command, delimiter)
	delimiter = delimiter or -1

	local opts = {
		command = command,
		capture_output = true,
		on_enter = function()
			vim.cmd("startinsert")
		end,
		on_result = function(result)
			local filename = result[1]

			if delimiter then
				filename = vim.fn.split(filename, delimiter)[1]
			end

			if vim.fn.filereadable(filename) == 1 then
				vim.cmd('edit ' .. vim.fn.fnameescape(filename))
			end
		end
	}

	floating_window_command(opts)
end

local fzf_git_files = function()
	local command = "git ls-files | fzf --preview 'bat --color=always --style=numbers --theme=Catppuccin\\ Mocha {}'"
	fzf(command)
end

local fzf_grep = function()
	local command =
	"rg --smart-case '' --line-number --no-heading | fzf --delimiter : --preview 'bat --style=numbers --color=always --highlight-line {2} {1}'"
	fzf(command, ":")
end

vim.api.nvim_create_user_command('FzfGitFiles', fzf_git_files, {})
vim.api.nvim_create_user_command('FzfGrep', fzf_grep, {})

vim.keymap.set("n", "<leader>fg", ":FzfGrep<CR>")
