local api = vim.api -- More concise.

-- Go to last location when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
	group = 1,

	callback = function()
		local mark = api.nvim_buf_get_mark(0, '"')
		local lcount = api.nvim_buf_line_count(0)

		if mark[1] > 0 and mark[1] <= lcount then
			pcall(api.nvim_win_set_cursor, 0, mark)
		end
	end,
})