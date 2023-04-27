------------------------------------SPLIT--------------------------------------------------------
local opt = vim.o
opt.relativenumber = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.cursorline = true
opt.termguicolors = true
opt.smartcase = true
opt.ignorecase = true
opt.guicursor = "n-v-c-sm:blinkon01,i-ci-ve:ver25-blinkon01,r-cr-o:hor20"
opt.jumpoptions = "stack"
opt.splitright = true
opt.splitbelow = true
opt.incsearch = false
opt.fixeol = false
opt.expandtab = true
opt.ff = "unix"
opt.mouse = ""
opt.signcolumn = "yes"
------------------------------------SPLIT--------------------------------------------------------
local global = vim.g
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1
global.loaded_node_provider = 0
global.loaded_perl_provider = 0
global.loaded_ruby_provider = 0
global.loaded_python3_provider = 0
-- global.auto_session_enabled = false

------------------------------------SPLIT--------------------------------------------------------
vim.cmd(
	[[autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
)
vim.cmd([[autocmd FileType * set formatoptions-=cro]])

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "TextChangedP" }, {
	callback = function()
		vim.b._changed = true
	end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		if vim.b._changed then
			pcall(vim.cmd, "write")
			vim.b._changed = false
		end
	end,
})

vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])

vim.defer_fn(function()
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function()
			local file_name = vim.api.nvim_buf_get_name(0)
			if string.find(file_name, "^term") then
				vim.cmd("startinsert")
			end
		end,
	})
	vim.cmd([[set clipboard+=unnamedplus]])
end, 500)

vim.cmd("autocmd Filetype markdown setlocal spell")
vim.cmd("autocmd Filetype qf nnoremap <buffer> q <cmd>q<cr>")
