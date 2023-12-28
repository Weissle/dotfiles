return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local function location_info()
				local total_line = tostring(vim.api.nvim_buf_line_count(0))
				local current_line = "         " .. tostring(vim.api.nvim_win_get_cursor(0)[1])
				return string.format("%s/%s", string.sub(current_line, #current_line - #total_line), total_line)
			end

			local config = {
				options = {
					ignore_focus = {
						"NvimTree",
						"Outline",
					},
					theme = "dracula",
				},
				sections = {
					lualine_c = { "filename" },
					lualine_z = { location_info },
				},
			}

			require("lualine").setup(config)
		end,
	},
	{
		"akinsho/bufferline.nvim",
		tag = "v4.4.1",
		config = function()
			vim.keymap.set("n", "<leader>bj", "<cmd>BufferLinePick<cr>")
			vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>")
			vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>")
			vim.keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<cr><C-L>")
			vim.keymap.set("n", "<leader>bcr", "<cmd>BufferLineCloseRight<cr><C-L>")
			vim.keymap.set("n", "<leader>bco", "<cmd>BufferLineCloseRight<cr><bar><cmd>BufferLineCloseLeft<cr><C-L>")
			require("bufferline").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = { scope = { enabled = false } },
		event = { "BufRead", "BufNewFile" },
	},
	{
		"karb94/neoscroll.nvim",
		name = "neoscroll",
		keys = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" },
		opts = { mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" } },
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"Pocco81/HighStr.nvim",
		keys = {
			{ "<leader>h0", ":<C-u>HSHighlight 0<cr>", mode = { "v" }, noremap = true },
			{ "<leader>h1", ":<C-u>HSHighlight 1<cr>", mode = { "v" }, noremap = true },
			{ "<leader>h2", ":<C-u>HSHighlight 2<cr>", mode = { "v" }, noremap = true },
			{ "<leader>h3", ":<C-u>HSHighlight 3<cr>", mode = { "v" }, noremap = true },
			{ "<leader>h4", ":<C-u>HSHighlight 4<cr>", mode = { "v" }, noremap = true },
			{ "<leader>h5", ":<C-u>HSHighlight 5<cr>", mode = { "v" }, noremap = true },
			{ "<leader>h6", ":<C-u>HSHighlight 6<cr>", mode = { "v" }, noremap = true },
			{ "<leader>h7", ":<C-u>HSHighlight 7<cr>", mode = { "v" }, noremap = true },
			{ "<leader>h8", ":<C-u>HSHighlight 8<cr>", mode = { "v" }, noremap = true },
			{ "<leader>h9", ":<C-u>HSHighlight 9<cr>", mode = { "v" }, noremap = true },
			{ "<leader>hl", ":<C-u>HSHighlight 1<cr>", mode = { "v" }, noremap = true },
			{ "<leader>hc", ":<C-u>HSRmHighlight<cr>", mode = { "v" }, noremap = true },
		},
		opts = true,
	},
}
