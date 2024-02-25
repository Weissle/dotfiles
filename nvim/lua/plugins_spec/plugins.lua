return {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		keys = {
			{ "<C-n>", "<cmd>NvimTreeToggle<cr>" },
			{ "<leader>nm", "<cmd>NvimTreeFindFile<cr>" },
			{ "<leader>nf", "<cmd>NvimTreeFocus<cr>" },
		},
		opts = {
			git = {
				ignore = false,
			},
			view = {
				adaptive_size = true,
				side = "right",
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				api.config.mappings.default_on_attach(bufnr)
				vim.keymap.del("n", "<C-e>", { buffer = bufnr })
			end,
		},
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v2.*",
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
			{ "<leader>fo", "<cmd>Telescope oldfiles only_cwd=true<cr>" },
			{ "<leader>fO", "<cmd>Telescope oldfiles <cr>" },
			{ "<leader>fG", "<cmd>Telescope git_status<cr>" },
			{ "<leader>fr", "<cmd>Telescope resume<cr>" },
			{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
			{ "<leader>fm", "<cmd>Telescope marks<cr>" },
			{ "<leader>fj", "<cmd>Telescope jumplist<cr>" },
			{ "gi", "<cmd>Telescope lsp_implementations<cr>" },
			{ "gd", "<cmd>Telescope lsp_definitions initial_mode=normal<cr>" },
			{ "gr", "<cmd>Telescope lsp_references initial_mode=normal<cr>" },
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
			{ "nvim-lua/plenary.nvim" },
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("live_grep_args")
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
			{ "s", "<cmd>HopWordMW<cr>", mode = { "n", "x", "o" } },
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
		"RRethy/vim-illuminate",
		opts = {
			delay = 50,
			filetypes_denylist = {
				"NvimTree",
			},
			providers = {
				"regex",
			},
			should_enable = function(buf)
				local max_filesize = 100 * 1024
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return false
				end
				return true
			end,
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
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
					function IsDroppedBuf(buf_id)
						local file_name = vim.api.nvim_buf_get_name(buf_id)
						for _, fname in ipairs({ "NvimTree_", "OUTLINE", "diffview", "health://" }) do
							if string.find(file_name, fname) or #file_name == 0 then
								return true
							end
						end
						return false
					end

					vim.tbl_map(function(win_id)
						local buf_id = vim.api.nvim_win_get_buf(win_id)
						if IsDroppedBuf(buf_id) then
							vim.api.nvim_win_close(win_id, true)
						end
					end, vim.api.nvim_list_wins())
					vim.tbl_map(function(buf_id)
						if IsDroppedBuf(buf_id) then
							vim.api.nvim_buf_delete(buf_id, { force = true })
						end
					end, vim.api.nvim_list_bufs())
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
				map("n", "<leader>gb", function()
					require("gitsigns").blame_line({ full = true })
				end)
				map("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>")
				map("n", "<leader>gl", gs.toggle_current_line_blame)
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
		"tpope/vim-sleuth",
	},
	{
		"skywind3000/asyncrun.vim",
		init = function()
			vim.g.asyncrun_open = 15
		end,
	},
	{ "kevinhwang91/nvim-bqf", enabled = true },
}
