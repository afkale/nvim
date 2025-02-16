require("ale.extra.utils")
--- Executes a command in a floating window and handles the result.
---@param opts table Options for configuring the floating window command.
--- - `command` (string) : The shell command to execute.
--- - `capture_output` (boolean) : If true, saves the command output in a temporary file.
--- - `on_enter` (function) : A callback function to run when the floating window is created.
--- - `on_result` (function) : A callback function that receives the command output.
local function floating_window_command(opts)
	opts = opts or {}
	opts.capture_output = opts.capture_output ~= nil and opts.capture_output

	local float = create_floating_window({})
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
			end
		end
	end)
end

vim.api.nvim_create_user_command("RgSearch", rg_search, {
	desc = "Search for a pattern in files using ripgrep (rg)."
})


-- local fzf_aux_command =
-- "rg --column --line-number --no-heading --color=always --smart-case '' | fzf --ansi -i --delimiter : --preview 'bat --style=numbers --color=always --highlight-line {2} {1}'"

local fzf_search = function()
	local opts = {
		command = "git ls-files | fzf --preview 'bat --color=always --style=numbers --theme=Catppuccin\\ Mocha {}'",
		capture_output = true,
		on_enter = function()
			vim.cmd("startinsert")
		end,
		on_result = function(result)
			local filename = result[1]
			if vim.fn.filereadable(filename) == 1 then
				vim.cmd('edit ' .. vim.fn.fnameescape(filename))
			end
		end
	}
	floating_window_command(opts)
end

-- local function git_commit_browser()
-- 	floating_window_command({
-- 		command = "git log --oneline | fzf", -- Show commit history in fzf
-- 		capture_output = true,         -- Capture selected commit
-- 		on_enter = function()
-- 			vim.cmd("startinsert")
-- 		end,
-- 		on_result = function(result)
-- 			if result and #result > 0 then
-- 				local commit_hash = result[1]:match("^(%S+)") -- Extract commit hash
-- 				if commit_hash then
-- 					vim.cmd("tabnew")             -- Open a new tab
-- 					vim.cmd("read !git show " .. commit_hash) -- Load commit details
--
-- 					local buf = vim.api.nvim_get_current_buf()
-- 					vim.api.nvim_set_option_value("filetype", "git", { buf = buf })
-- 					vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
-- 					vim.api.nvim_set_option_value("readonly", true, { buf = buf })
-- 				end
-- 			end
-- 		end
-- 	})
-- end
--
-- local function open_multiple_files()
-- 	floating_window_command({
-- 		command = "git ls-files | fzf --multi",
-- 		capture_output = true,
-- 		on_enter = function(buf, win)
-- 			vim.bo[buf].modifiable = false
-- 		end,
-- 		on_result = function(result)
-- 			if result and #result > 0 then
-- 				for _, file in ipairs(result) do
-- 					vim.cmd("edit " .. vim.fn.fnameescape(file))
-- 				end
-- 			end
-- 		end
-- 	})
-- end

-- open_multiple_files()

vim.api.nvim_create_user_command('Fzf', fzf_search, {})

vim.keymap.set("n", "<leader>ff", ":Fzf<CR>")
