local highstr_keys = {}

for i = 1, 10 do
	highstr_keys[#highstr_keys + 1] = {
		"<leader>h" .. tostring(i),
		":<C-u>HSHighlight " .. tostring(i) .. "<cr>",
		mode = { "v" },
		noremap = true,
		silent = true,
	}
end

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
		tag = "v3.7.0",
		config = function()
			vim.keymap.set("n", "<leader>bj", "<cmd>BufferLinePick<cr>")
			vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
			vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
			vim.keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<cr><C-L>")
			vim.keymap.set("n", "<leader>bcr", "<cmd>BufferLineCloseRight<cr><C-L>")
			vim.keymap.set("n", "<leader>bco", "<cmd>BufferLineCloseRight<cr><bar><cmd>BufferLineCloseLeft<cr><C-L>")
			require("bufferline").setup({
				options = {
					groups = {
						items = {
							require("bufferline.groups").builtin.ungrouped,
							{
								name = "Bash",
								auto_close = false,
								matcher = function(buf)
									return buf.buftype == "terminal"
								end,
							},
						},
					},
					indicator = {
						style = "underline",
					},
				},
			})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim", event = { "BufRead", "BufNewFile" } },
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
			unpack(highstr_keys),
			{ "<leader>hl", ":<C-u>HSHighlight 1<cr>", mode = { "v" }, noremap = true },
			{ "<leader>hc", ":<C-u>HSRmHighlight<cr>", mode = { "n" }, noremap = true },
		},
		opts = true,
	},
}
