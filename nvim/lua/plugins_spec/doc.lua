return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			require("nvim-treesitter.install").prefer_git = true
		end,
		opts = {
			ensure_installed = { "cpp", "c", "lua", "python", "json", "markdown", "bash", "vim" },
			sync_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>sn"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>sp"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
					},
				},
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		-- enabled = false,
		dependencies = {
			"kevinhwang91/promise-async",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function(_, opts)
			-- NOTE: change foldcolumn = 1 after the relative PR is merged.
			vim.o.foldcolumn = "0"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.keymap.set("n", "zR", "<cmd>lua require('ufo').openAllFolds()<cr>")
			vim.keymap.set("n", "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>")
			require("ufo").setup(opts)
		end,
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		},
	},
	{
		"windwp/nvim-spectre",
		keys = {
			{
				"<leader>ms",
				function()
					vim.ui.select(
						{ "Spectre-Global", "Spectre-Current", "Spectre-Global-Word" },
						{},
						function(item, idx)
							-- Want Spectre-Cur-Word
							local spec = require("spectre")
							if item == "Spectre-Global" then
								spec.open()
							elseif item == "Spectre-Current" then
								spec.open_file_search()
							elseif item == "Spectre-Global-Word" then
								spec.open_visual({ select_word = true })
							end
						end
					)
				end,
			},
		},
		name = "spectre",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		keys = { { "<leader>fT", "<cmd>TodoTelescope <cr>" } },
		event = { "BufReadPost" },
		name = "todo-comments",
		dependencies = { "telescope" },
		opts = {},
	},
	{
		"danymat/neogen",
		keys = {
			{ "<leader>Df", "<cmd>Neogen func<cr>" },
			{ "<leader>DF", "<cmd>Neogen file<cr>" },
			{ "<leader>Dc", "<cmd>Neogen class<cr>" },
			{ "<leader>Dt", "<cmd>Neogen type<cr>" },
		},
		dependencies = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
		opts = {
			snippet_engine = "luasnip",
		},
	},
	{
		"numToStr/Comment.nvim",
		keys = { { "gc", mode = { "x", "n", "v" } }, { "gb", mode = { "x", "n", "v" } } },
		name = "Comment",
		opts = {},
	},
	{
		"crusj/bookmarks.nvim",
		name = "bookmarks",
		opts = {
			keymap = {
				toggle = "<leader>bm",
				add = "<leader>ba",
				order = "<leader>bS",
				delete_on_virt = "<leader>bA",
				show_desc = "<leader>bs",
			},
		},
	},
	{
		"mechatroner/rainbow_csv",
		ft = { "csv" },
	},
}
