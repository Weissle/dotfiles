Util = {}
Util.is_big_file = function(buf)
	local max_filesize = 1024 * 1024 -- 1 MB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats then
		return stats.size > max_filesize
	end
	return false
end
