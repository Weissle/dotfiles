vim.g.mapleader = " "
local opts = { remap = false, silent = true }

------------------------------------SPLIT--------------------------------------------------------
-- since <space> is the <leader>
vim.keymap.set("n", " ", "<NOP>", opts)
vim.keymap.set("i", "jj", "<C-[>", opts)
-- Move when insert mode
vim.keymap.set("i", "<C-h>", "<left>", opts)
vim.keymap.set("i", "<C-l>", "<right>", opts)
vim.keymap.set("i", "<C-k>", "<up>", opts)
vim.keymap.set("i", "<C-j>", "<down>", opts)
vim.keymap.set("i", "<C-a>", "<C-o>I", opts)
vim.keymap.set("i", "<C-e>", "<C-o>A", opts)

vim.keymap.set("s", "<BS>", "<Space><BS>", opts)
vim.keymap.set("n", "<F3>", "<cmd>noh<cr>", opts)
vim.keymap.set("", "J", "gJ", opts)
vim.keymap.set({ "t", "n" }, "<leader>qt", "<cmd>q<cr>", opts)
vim.keymap.set({ "t", "n" }, "<leader>qT", "<cmd>tabclose<cr>", opts)
vim.keymap.set("n", "<leader>qa", "<cmd>qa<cr>", opts)
-- copy from mini.basic
vim.keymap.set(
	"n",
	"gO",
	"<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
	{ desc = "Put empty line above" }
)
vim.keymap.set(
	"n",
	"go",
	"<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
	{ desc = "Put empty line below" }
)
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", opts)

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<leader>ml", "<cmd>mode<cr>")
------------------------------------SPLIT--------------------------------------------------------

-- lspconfig
vim.keymap.set("n", "<leader>la", "<cmd>CodeActionMenu<cr>", opts)
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
vim.keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
vim.keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", opts)
-- diagnostic
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } })
end, opts)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } })
end, opts)

vim.keymap.set("n", "<leader>lo", vim.diagnostic.open_float, opts)
-- frequently use
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions initial_mode=normal<cr>", opts)
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references initial_mode=normal<cr>", opts)

-- for terminal mode
vim.keymap.set("t", "jj", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)
vim.keymap.set("t", "gt", "<C-\\><C-n><cmd>tabn<cr>", opts)
vim.keymap.set("t", "gT", "<C-\\><C-n><cmd>tabN<cr>", opts)
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<cr><bar><cmd>terminal<cr>i", opts)
vim.keymap.set("n", "<leader>tx", "<cmd>sp<cr><bar><cmd>terminal<cr>i", opts)
vim.keymap.set("n", "<leader>tv", "<cmd>vsp<cr><bar><cmd>terminal<cr>i", opts)

vim.keymap.set("n", "gcp", "yygccp", {
	remap = true,
	silent = true,
	unique = true,
})
vim.keymap.set("n", "gcP", "yygccP", {
	remap = true,
	silent = true,
	unique = true,
})

vim.keymap.set("n", "<leader>mt", function()
	vim.ui.select({ "HardTimeToggle", "MouseMode", "NoMouseMode" }, {}, function(item, idx)
		if item == "HardTimeToggle" then
			vim.cmd("HardTimeToggle")
		elseif item == "MouseMode" then
			vim.o.mouse = "a"
		elseif item == "NoMouseMode" then
			vim.o.mouse = ""
		end
	end)
end)

vim.keymap.set("n", "<leader>mp", "<cmd>set paste<cr>", opts)
vim.keymap.set("n", "<leader>mP", "<cmd>set nopaste<cr>", opts)
