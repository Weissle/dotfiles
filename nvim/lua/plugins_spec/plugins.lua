return {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<C-n>", "<cmd>NvimTreeToggle<cr>" },
			{ "<leader>nm", "<cmd>NvimTreeFindFile<cr>" },
			{ "<leader>nf", "<cmd>NvimTreeFocus<cr>" },
		},
		name = "nvim-tree",
		opts = {
			git = {
				ignore = false,
			},
			--[[ view = {
				-- adaptive_size = true,
				side = "right",
			}, ]]
		},
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.2.1",
		config = function(_, opts)
			require("luasnip").setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load({
				exclude = { "all", "cpp" },
			})
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "./snippets" },
			})
		end,
		opts = {
			region_check_events = "InsertEnter",
		},
	},
	{
		"williamboman/mason.nvim",
		name = "mason",
		build = ":MasonUpdate",
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		name = "telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "nvim-telescope/telescope-frecency.nvim", dependencies = { "kkharji/sqlite.lua" } },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("live_grep_args")
			require("telescope").load_extension("frecency")
		end,
		opts = function()
			local action = require("telescope.actions")
			return {
				defaults = {
					mappings = {
						n = {
							["q"] = action.close,
						},
						i = {
							["<ESC>"] = action.close,
						},
					},
					path_display = {
						shorten = {
							len = 5,
							exclude = { 1, -1 },
						},
					},
				},
				extensions = {
					frecency = {
						show_unindexed = false,
					},
				},
			}
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
	},
	{
		"phaazon/hop.nvim",
		name = "hop",
		keys = {
			{ "<leader>hl", "<cmd>HopLineStartMW<cr>", mode = { "n", "x", "o" } },
			{ "<leader>hw", "<cmd>HopWordMW<cr>", mode = { "n", "x", "o" } },
			{ "<leader>hc", "<cmd>HopChar2MW<cr>", mode = { "n", "x", "o" } },
			{ "<leader>hf", "<cmd>HopChar1MW<cr>", mode = { "n", "x", "o" } },
			{
				"<leader>he",
				"<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, multi_windows = true })<cr>",
				mode = { "n", "x", "o" },
			},
		},
		opts = {},
	},
	{
		"echasnovski/mini.nvim",
		event = { "BufRead", "BufNewFile" },
		keys = {
			{ "<leader>bd", '<cmd>lua require("mini.bufremove").delete(0,false)<cr>' },
			{ "<leader>bD", '<cmd>lua require("mini.bufremove").delete(0,true)<cr>' },
		},
		config = function()
			vim.api.nvim_create_autocmd({ "BufLeave" }, {
				callback = function()
					require("mini.cursorword").auto_unhighlight()
				end,
			})
			vim.api.nvim_create_autocmd({ "Filetype" }, {
				pattern = "NvimTree",
				callback = function()
					vim.b.minicursorword_disable = true
				end,
			})
			require("mini.cursorword").setup({
				delay = 30,
			})
			require("mini.bufremove").setup()
			require("mini.surround").setup({
				mappings = {
					add = "<leader>as",
					delete = "ds",
					find = "",
					find_left = "",
					highlight = "",
					replace = "cs",
					update_n_lines = "",
				},
			})
		end,
	},
	{
		"kevinhwang91/promise-async",
		lazy = true,
	},
	{
		"mrjones2014/smart-splits.nvim",
		keys = { { "<leader>mr", "<cmd>SmartResizeMode<cr>" } },
		cmd = "SmartResizeMode",
		config = true,
	},
	{
		"gbprod/yanky.nvim",
		dependencies = { "telescope" },
		keys = {
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
			{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
			{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
			{ "<leader>fy", "<cmd>Telescope yank_history<cr>" },
		},
		config = function(_, opts)
			require("yanky").setup(opts)
			require("telescope").load_extension("yank_history")
		end,
		opts = {
			highlight = {
				on_put = false,
				on_yank = false,
			},
		},
	},
	{
		"Weissle/easy-action",
		keys = { { "<leader>e", "<cmd>BasicEasyAction<cr>" } },
		branch = "dev",
		dependencies = { "kevinhwang91/promise-async", "hop" },
		opts = {},
	},
	{
		"rmagatti/auto-session",
		name = "auto-session",
		cond = function()
			return vim.g.auto_session_enabled ~= false
		end,
		config = function()
			-- NOTE: folds options is exclusive. Due to ufo is not loaded at startup.
			vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/" },
				pre_save_cmds = {
					function()
						pcall(vim.cmd, "tabdo NvimTreeClose")
						pcall(vim.cmd, "tabdo SymbolsOutlineClose")
					end,
				},
			})
		end,
	},
	{
		"rmagatti/session-lens",
		keys = { { "<leader>fs", "<cmd>Telescope session-lens search_session<cr>" } },
		dependencies = { "telescope", "rmagatti/auto-session" },
		name = "session-lens",
		opts = {},
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_open_to_the_world = 1
		end,
	},
	{
		"cbochs/portal.nvim",
		keys = {
			{
				"<leader>bo",
				"<cmd>Portal jumplist backward<cr>",
			},
			{
				"<leader>bi",
				"<cmd>Portal jumplist forward<cr>",
			},
		},
		name = "portal",
		opts = {},
	},
}
