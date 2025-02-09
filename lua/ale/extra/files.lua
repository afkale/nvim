-- Toggle minifiles function.
local function toggle_minifiles(opts)
	if vim.bo.filetype == "minifiles" then
		-- If minifiles is already open close it.
		MiniFiles.close()
	else
		-- If not open it.
		MiniFiles.open(opts.path)
	end
end

-- User command to open minifiles in current file directory.
vim.api.nvim_create_user_command("FilesHere", function()
	toggle_minifiles({ path = vim.fn.expand("%:p") })
end, {})

-- User command to open minifiles.
vim.api.nvim_create_user_command("Files", toggle_minifiles, {})

-- Sync minifiles with CR on minifiles filetype.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "minifiles" },
	callback = function(args)
		-- Add buf keymap to synchronize with enter keymap only on minifiles buffers.
		vim.api.nvim_set_keymap(
			"n", "<CR>", ":lua MiniFiles.synchronize()<CR>", { noremap = true, silent = true }
		)
	end
})
