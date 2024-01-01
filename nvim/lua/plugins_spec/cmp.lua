return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local compare = require("cmp").config.compare

			local cmp_source_abb = {
				["nvim_lsp"] = "[LSP]",
				["luasnip"] = "[Snip]",
				["path"] = "[Path]",
				["buffer"] = "[Buf]",
				["cmdline"] = "[Cmd]",
			}

			local cmp_item_kind = require("cmp.types").lsp.CompletionItemKind
			local cmp_buffer_source = {
				name = "buffer",
				option = {
					-- PERF: It may slows down you paste and delete motion.
					get_bufnrs = function()
						local ret = {}
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							local max_filesize = 100 * 1024
							local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
							if ok and stats and stats.size > max_filesize then
								-- ignore big file
							else
								table.insert(ret, buf)
							end
						end
						return ret
					end,
				},
				priority = 1,
			}
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					format = function(entry, item)
						item.menu = cmp_source_abb[entry.source.name]
						return item
					end,
				},
				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-\\>"] = cmp.mapping(cmp.mapping.abort(), { "i", "s" }),
				},
				sources = {
					{
						name = "nvim_lsp",
						entry_filter = function(entry, ctx)
							local entry_label_length = #entry["completion_item"]["label"]
							local length_max = 80
							if entry_label_length > length_max then
								return false
							end
							local cmp_kind = cmp_item_kind[entry:get_kind()]
							return cmp_kind ~= "Snippet" and cmp_kind ~= "Text"
						end,
						priority = 1,
						max_item_count = 15,
					},
					{ name = "luasnip", priority = 1.5 },
					{ name = "path", priority = 1 },
					cmp_buffer_source,
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						compare.exact,
						compare.score,
						compare.offset,
						-- -- compare.scopes,
						compare.recently_used,
						-- compare.locality,
						compare.kind,
						-- compare.sort_text,
						compare.length,
						-- compare.order,
					},
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
					cmp_buffer_source,
					{ name = "path" },
				}),
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					cmp_buffer_source,
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {},
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		name = "refactoring",
		-- enabled = false,
		keys = {
			-- -- Remaps for the refactoring operations currently offered by the plugin
			{ "<leader>re", "<cmd>Refactor extract <cr>", mode = { "x" } },
			-- { "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], "v" },
			{ "<leader>rv", "<cmd>Refactor extract_var <cr>", mode = { "x" } },
			{ "<leader>ri", "<cmd>Refactor inline_var <cr>", mode = { "x", "n" } },

			-- Extract block doesn't need visual mode
			{ "<leader>rb", "<cmd>Refactor extract_block <cr>", mode = { "n" } },
			{
				"<leader>rr",
				function()
					require("refactoring").select_refactor()
				end,
				mode = { "x", "n" },
			},
			-- { "<leader>rbf", "<cmd>Refactor extract_b", "n" },
		},
		opts = {},
	},
}
