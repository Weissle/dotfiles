return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local nl = require("null-ls")
			local builtins = nl.builtins
			nl.setup({
				sources = {
					builtins.formatting.clang_format,
					builtins.formatting.stylua,
					builtins.formatting.beautysh,
				},
				on_attach = function(client, bufnr)
					client.server_capabilities.completionProvider = false
				end,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local M = {}

			local lsp_servers = { "clangd", "pyright", "lua_ls", "bashls" }
			local clients_format_disabled = { clangd = true, lua_ls = true }

			-- if null-ls provides the format feature.

			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local default_capabilities = cmp_nvim_lsp.default_capabilities()

			local default_lsp_config = {
				capabilities = default_capabilities,
				on_attach = function(client, bufnr)
					if clients_format_disabled[client.name] then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end
				end,
			}

			M.lua_ls_config = vim.deepcopy(default_lsp_config)
			M.lua_ls_config.settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
						disable = { "param-type-mismatch" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
					completion = {
						autoRequire = false,
						keywordSnippet = "Disable",
						callSnippet = "Replace",
					},
				},
			}
			M.clangd_config = vim.deepcopy(default_lsp_config)
			M.clangd_config.cmd = {
				"clangd",
				"--header-insertion=never",
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
		"jayp0521/mason-null-ls.nvim",
		dependencies = { "jose-elias-alvarez/null-ls.nvim" },
		name = "mason-null-ls",
		opts = { automatic_installation = true },
	},
	{
		"simrat39/symbols-outline.nvim",
		keys = {
			{ "<leader>lS", "<cmd>SymbolsOutline<cr>" },
		},
		name = "symbols-outline",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			automatic_installation = true,
		},
	},
}
