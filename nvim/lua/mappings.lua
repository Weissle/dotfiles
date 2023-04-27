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
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>lo", vim.diagnostic.open_float, opts)
-- frequently use
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions initial_mode=normal<cr>", opts)
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references initial_mode=normal<cr>", opts)

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", opts)
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", opts)
vim.keymap.set("n", "<leader>ft", "<cmd>Telescope <cr>", opts)
vim.keymap.set("n", "<leader>fa", "<cmd>Telescope find_files no_ignore=true hidden=true<cr>", opts)
vim.keymap.set("n", "<leader>f*", "<cmd>Telescope grep_string<cr>", opts)
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope frecency workspace=CWD<cr>", opts)
vim.keymap.set("n", "<leader>fO", "<cmd>Telescope frecency<cr>", opts)
vim.keymap.set("n", "<leader>fG", "<cmd>Telescope git_status<cr>", opts)
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", opts)
vim.keymap.set("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", opts)
vim.keymap.set(
	"n",
	"<leader>fk",
	"<cmd>lua require('telescope.builtin').keymaps{ modes = {'n','i','c','x','v','o'}}<cr>",
	opts
)

-- dap
vim.keymap.set("n", "<leader>dt", "<cmd>lua require('dap').run_to_cursor()<cr>", opts)
vim.keymap.set("n", "<leader>dp", "<cmd>lua require('dap').pause()<cr>", opts)
vim.keymap.set("n", "<leader>dT", "<cmd>lua require('dap').terminate(); require('dapui').close()<cr>", opts)
vim.keymap.set("n", "<F4>", "<cmd>lua require'dap'.terminate()<cr>", opts)
vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
vim.keymap.set("n", "<F6>", "<cmd>lua require'dap'.step_into()<cr>", opts)
vim.keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_over()<cr>", opts)
vim.keymap.set("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", opts)
vim.keymap.set("n", "<F9>", "<cmd>lua require'dap'.run_last()<cr>", opts)
vim.keymap.set("n", "<leader>da", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", opts)
vim.keymap.set(
	"n",
	"<leader>dA",
	"<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>",
	opts
)
vim.keymap.set("n", "<leader>dC", "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>", opts)

-- dapui
vim.keymap.set("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", opts)
vim.keymap.set({ "n", "x" }, "<leader>de", "<cmd>lua require('dapui').eval()<cr>", opts)

-- for terminal mode
vim.keymap.set("t", "jj", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>j", opts)
vim.keymap.set("t", "<A-h>", "<C-\\><C-n><C-w>h", opts)
vim.keymap.set("t", "<A-k>", "<C-\\><C-n><C-w>k", opts)
vim.keymap.set("t", "<A-l>", "<C-\\><C-n><C-w>l", opts)
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
	vim.ui.select({ "HardTimeToggle", "NumberToggle" }, {}, function(item, idx)
		if item == "HardTimeToggle" then
			vim.cmd("HardTimeToggle")
		elseif item == "NumberToggle" then
			if vim.o.number then
				vim.o.number = false
				vim.o.relativenumber = false
			else
				vim.o.number = true
				vim.o.relativenumber = true
			end
		end
	end)
end)

vim.keymap.set("n", "<leader>ms", function()
	vim.ui.select({ "Spectre-Global", "Spectre-Cur", "Spectre-Global-Word" }, {}, function(item, idx)
        -- Want Spectre-Cur-Word
		local spec = require("spectre")
		if item == "Spectre-Global" then
			spec.open()
		elseif item == "Spectre-Cur" then
			spec.open_file_search()
		elseif item == "Spectre-Global-Word" then
			spec.open_visual({ select_word = true })
		end
	end)
end)
