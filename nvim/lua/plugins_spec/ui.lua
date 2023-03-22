return {
	{
		"folke/tokyonight.nvim",
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd("colorscheme tokyonight")
		end,
		opts = {
			style = "moon",
			on_highlights = function(highlights, _)
				highlights.WinSeparator = {
					fg = "#6699FF",
				}
			end,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "folke/tokyonight.nvim" },
		config = function()
			local function location_info()
				local total_line = tostring(vim.api.nvim_buf_line_count(0))
				local current_line = "         " .. tostring(vim.api.nvim_win_get_cursor(0)[1])
				return string.format("%s/%s", string.sub(current_line, #current_line - #total_line), total_line)
			end

			local config = {
				options = {
					theme = "tokyonight",
					ignore_focus = {
						"NvimTree",
						"Outline",
						"dapui_console",
						"dap-repl",
						"dapui_breakpoints",
						"dapui_stacks",
						"dapui_scopes",
						"dapui_watches",
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
		tag = "v3.1.0",
		config = function()
			vim.keymap.set("n", "<leader>bj", "<cmd>BufferLinePick<cr>")
			vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>")
			vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>")
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
				},
			})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim" },
	{
		"karb94/neoscroll.nvim",
		name = "neoscroll",
		keys = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" },
		opts = { mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" } },
	},
	{
		enabled = false,
		"rcarriga/nvim-notify",
		dependencies = { "telescope" },
		config = function(_, opts)
			require("notify").setup(opts)
			require("telescope").load_extension("notify")
			-- notify
			vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<cr>", opts)
			vim.keymap.set("n", "<leader>md", "<cmd>lua require('notify').dismiss()<cr>", opts)
		end,
		opts = { level = vim.log.levels.WARN },
	},
	{
		enabled = false,
		"folke/noice.nvim",
		name = "noice",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"jinh0/eyeliner.nvim",
		opts = {
			highlight_on_key = true,
			dim = true,
		}
	},
}
