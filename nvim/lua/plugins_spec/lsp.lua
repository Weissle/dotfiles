cspell_config = {
	config = {
		find_json = function(cwd)
			return "/home/weissle/.config/nvim/ext_config/cspell.json"
		end,
	},
	diagnostics_postprocess = function(diagnostic)
		diagnostic.severity = vim.diagnostic.severity["HINT"]
	end,
	filetypes = { "cpp", "markdown", "python" },
}
return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "williamboman/mason.nvim", "davidmh/cspell.nvim" },
		config = function()
			local nl = require("null-ls")
			local cspell = require("cspell")
			local builtins = nl.builtins
			nl.setup({
				sources = {
					builtins.formatting.stylua,
					builtins.formatting.beautysh,
					cspell.diagnostics.with(cspell_config),
					cspell.code_actions.with(cspell_config),
				},
				on_attach = function(client, bufnr)
					client.server_capabilities.completionProvider = false
				end,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local M = {}

			local lsp_servers = { "clangd", "pyright", "lua_ls" }
			-- if null-ls provides the format feature.
			local clients_format_disabled = { lua_ls = true }

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
				"--clang-tidy"
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
	{
		"j-hui/fidget.nvim",
		branch = "legacy",
		opts = true,
	},
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	},
}
