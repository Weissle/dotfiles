return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ lsp_fallback = true })
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				python = { "black" },
				lua = { "stylua" },
				sh = { "beautysh" },
				json = { "jq" },
				cmake = { "cmake_format" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		name = "lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "cspell" },
				cpp = { "cspell" },
				c = { "cspell" },
				python = { "cspell" },
				sh = { "cspell" },
				lua = { "cspell" },
			}
			local cspell = lint.linters.cspell
			table.insert(cspell.args, "-c")
			table.insert(cspell.args, "~/.config/dotfiles/nvim/ext_config/cspell.json")
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufNewFile" },
		config = function()
			local M = {}

			local lsp_servers = { "clangd", "pyright", "lua_ls", "rust_analyzer" }

			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local default_capabilities = cmp_nvim_lsp.default_capabilities()

			local default_lsp_config = {
				capabilities = default_capabilities,
			}

			M.clangd_config = vim.deepcopy(default_lsp_config)
			M.clangd_config.cmd = {
				"clangd",
				"--header-insertion=never",
				"--clang-tidy",
			}

			local lspconfig = require("lspconfig")
			for _, lsp in pairs(lsp_servers) do
				if M[lsp .. "_config"] == nil then
					lspconfig[lsp].setup(default_lsp_config)
				else
					lspconfig[lsp].setup(M[lsp .. "_config"])
				end
			end
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		keys = {
			{ "<leader>lS", "<cmd>SymbolsOutline<cr>" },
		},
		opts = {},
	},
	{
		"aznhe21/actions-preview.nvim",
		keys = {
			{ "<leader>la", "<cmd>lua require('actions-preview').code_actions()<cr>" },
		},
		opts = {},
	},
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			hint_prefix = "",
		},
	},
}
