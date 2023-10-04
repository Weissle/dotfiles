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
		},
		opts = {
			git = {
				ignore = false,
			},
			view = {
				-- adaptive_size = true,
				side = "right",
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "2.*",
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
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		name = "telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
			{ "<leader>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>" },
			{ "<leader>fc", "<cmd>Telescope commands<cr>" },
			{ "<leader>ft", "<cmd>Telescope <cr>" },
			{ "<leader>fa", "<cmd>Telescope find_files no_ignore=true hidden=true<cr>" },
			{ "<leader>f*", "<cmd>Telescope grep_string<cr>" },
			{ "<leader>fo", "<cmd>Telescope frecency workspace=CWD<cr>" },
			{ "<leader>fO", "<cmd>Telescope frecency<cr>" },
			{ "<leader>fG", "<cmd>Telescope git_status<cr>" },
			{ "<leader>fr", "<cmd>Telescope resume<cr>" },
			{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
			{ "<leader>fm", "<cmd>Telescope marks<cr>" },
			{ "<leader>fj", "<cmd>Telescope jumplist<cr>" },
			{
				"<leader>fk",
				"<cmd>lua require('telescope.builtin').keymaps{ modes = {'n','i','c','x','v','o'}}<cr>",
			},
		},
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{
				"nvim-telescope/telescope-frecency.nvim",
			},
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
			local lga = require("telescope-live-grep-args.actions")
			return {
				defaults = {
					mappings = {
						n = {
							["<C-c>"] = action.close,
						},
						i = {
							["<Esc>"] = action.close,
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
						use_sqlite = false,
						auto_validate = false,
					},
					live_grep_args = {
						auto_quoting = true,
						mappings = {
							i = {
								["<C-k>"] = lga.quote_prompt(),
								["<C-t>"] = lga.quote_prompt({ postfix = " -t" }),
							},
						},
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
		"smoka7/hop.nvim",
		version = "*",
		name = "hop",
		keys = {
			{ "L", "<cmd>HopLineStartMW<cr>", mode = { "n", "x", "o" } },
			{ "<enter>", "<cmd>HopWordMW<cr>", mode = { "n", "x", "o" } },
			{ "<leader>h/", "<cmd>HopPattern<cr>", mode = { "n" } },
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
					add = "S",
					delete = "ds",
					find = "",
					find_left = "",
					highlight = "",
					replace = "cs",
					update_n_lines = "",
				},
			})
			require("mini.move").setup({})
			require("mini.align").setup({})
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		keys = { { "<leader>mr", "<cmd>SmartResizeMode<cr>" } },
		opts = {
			resize_mode = {
				silent = true,
			},
		},
	},
	{
		"gbprod/yanky.nvim",
		dependencies = { "telescope" },
		keys = {
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n" } },
			{ "p", '"_d<Plug>(YankyPutBefore)', mode = { "x" } },
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
		opts = {
			jump_provider_config = {
				hop = {
					action_select = {
						line = {
							cmd = "HopLineStartMW",
						},
					},
				},
			},
		},
	},
	{
		"rmagatti/auto-session",
		name = "auto-session",
		cond = function()
			return vim.g.auto_session_enabled ~= false
		end,
		opts = {
			log_level = "error",
			auto_session_suppress_dirs = { "~/" },
			pre_save_cmds = {
				function()
					pcall(vim.cmd, "tabdo NvimTreeClose")
					pcall(vim.cmd, "tabdo SymbolsOutlineClose")
					pcall(vim.cmd, "tabdo DiffviewClose")
				end,
			},
			auto_session_use_git_branch = true,
		},
		config = function(_, opts)
			-- NOTE: folds options is exclusive. Due to ufo is not loaded at startup.
			vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
			require("auto-session").setup(opts)
		end,
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
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Stage
				map("n", "<leader>gs", gs.stage_hunk)
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>gS", gs.stage_buffer)
				-- Unstage
				map("n", "<leader>gu", gs.undo_stage_hunk)

				-- Intend to let the reset operation have a double check
				map("n", "<leader>gr", function()
					vim.ui.select({ "Hunk Reset", "Buffer Reset" }, {}, function(item, idx)
						if item == "Hunk Reset" then
							gs.reset_hunk()
						elseif item == "Buffer Reset" then
							gs.reset_buffer()
						end
					end)
				end)
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				map("n", "<leader>gp", gs.preview_hunk)
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>gl", gs.toggle_current_line_blame)
				-- map("n", "<leader>gd", gs.diffthis)
				-- map("n", "<leader>gD", function()
				-- 	gs.diffthis("~")
				-- end)
				map("n", "<leader>gc", gs.toggle_deleted)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},
	{
		"sindrets/diffview.nvim",
		opts = {},
		config = function(_, opts)
			vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
			vim.keymap.set("n", "<leader>gD", function()
				vim.ui.select({ "CurrentFileHistory" }, {}, function(item, idx)
					if item == "CurrentFileHistory" then
						vim.cmd("DiffviewFileHistory %")
					end
				end)
			end)
		end,
	},
	{
		"takac/vim-hardtime",
		enabled = false,
		init = function()
			vim.g.hardtime_ignore_quickfix = 1
			vim.g.hardtime_motion_with_count_resets = 1
			vim.g.hardtime_allow_different_key = 1
			vim.g.hardtime_default_on = 1
			vim.g.hardtime_showmsg = 1
			vim.g.hardtime_maxcount = 2
			vim.g.hardtime_motion_with_count_resets = 1
		end,
	},
	{
		"tpope/vim-sleuth",
	},
}
