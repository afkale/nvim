local function toggle_minifiles(opts)
	opts = opts or {}
	if vim.bo.filetype == "minifiles" then
		MiniFiles.close()
	else
		MiniFiles.open(opts.path)
	end
end

vim.api.nvim_create_user_command("FilesHere", function()
	toggle_minifiles({ path = vim.fn.expand("%:p") })
end, {})

vim.api.nvim_create_user_command("Files", function()
	toggle_minifiles()
end, {})

-- Sync MiniFiles with CR
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "minifiles" },
	callback = function(args)
		vim.api.nvim_buf_set_keymap(args.buf, "n", "<CR>", ":lua MiniFiles.synchronize()<CR>",
			{ noremap = true, silent = true })
	end
})
