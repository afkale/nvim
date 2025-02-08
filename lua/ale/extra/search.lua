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
				vim.cmd("copen")
			end
		end
	end)
end

vim.api.nvim_create_user_command("RgSearch", rg_search, {
	desc = "Search for a pattern in files using ripgrep (rg)."
})
