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
					{
						name = "buffer",
						option = {
							-- PERF: It may slows down you paste and delete motion.
							get_bufnrs = function()
								local ret = {}
								for _, buf in ipairs(vim.api.nvim_list_bufs()) do
									if vim.api.nvim_buf_line_count(buf) <= 5000 then
										table.insert(ret, buf)
									end
								end
								return ret
							end,
						},
						priority = 1,
					},
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
					-- { name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=], keyword_length = 1 },
					{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
			config = function(_, opts)
				require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done)
			end,
		},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		enabled = false,
		keys = {
			-- -- Remaps for the refactoring operations currently offered by the plugin
			{ "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], "v" },
			-- { "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], "v" },
			{ "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], "v" },
			{ "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], { "v", "n" } },

			-- Extract block doesn't need visual mode
			{ "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], "n" },
			{ "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], "n" },
		},
	},
}
