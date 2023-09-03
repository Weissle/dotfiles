local dap_plugins_spec = {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>dt", "<cmd>lua require('dap').run_to_cursor()<cr>" },
			{ "<leader>dp", "<cmd>lua require('dap').pause()<cr>" },
			{ "<leader>dT", "<cmd>lua require('dap').terminate(); require('dapui').close()<cr>" },
			{ "<F4>", "<cmd>lua require'dap'.terminate()<cr>" },
			{ "<F5>", "<cmd>lua require'dap'.continue()<cr>" },
			{ "<F6>", "<cmd>lua require'dap'.step_into()<cr>" },
			{ "<F7>", "<cmd>lua require'dap'.step_over()<cr>" },
			{ "<F8>", "<cmd>lua require'dap'.step_out()<cr>" },
			{ "<F9>", "<cmd>lua require'dap'.run_last()<cr>" },
		},
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local dap_breakpoint_highlight = {
				DapBreakpoint = { ctermbg = 0, fg = "#993939" },
				DapLogPoint = { ctermbg = 0, fg = "#61afef" },
				DapStopped = { ctermbg = 0, fg = "#98c379" },
			}

			for k, v in pairs(dap_breakpoint_highlight) do
				vim.api.nvim_set_hl(0, k, v)
			end

			local dap_breakpoint_style = {
				DapBreakpoint = { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" },
				DapBreakpointCondition = {
					text = "ﳁ",
					texthl = "DapBreakpoint",
					linehl = "",
					numhl = "",
				},
				DapBreakpointRejected = {
					text = "",
					texthl = "DapBreakpoint",
					linehl = "",
					numhl = "",
				},
				DapLogPoint = { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" },
				DapStopped = { text = "", texthl = "DapStopped", linehl = "", numhl = "" },
			}

			for k, v in pairs(dap_breakpoint_style) do
				vim.fn.sign_define(k, v)
			end

			require("dap.ext.vscode").load_launchjs(nil)

			vim.api.nvim_create_augroup("dap_reload_launchjson", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "launch.json" },
				group = "dap_reload_launchjson",
				callback = function()
					require("dap").configurations = {}
					require("dap.ext.vscode").load_launchjs(nil)
				end,
			})

			require("dap").adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = "OpenDebugAD7",
			}

			require("dap").adapters.python = {
				type = "executable",
				command = "python",
				args = { "-m", "debugpy.adapter" },
			}
		end,
	},
	{
		"Weissle/persistent-breakpoints.nvim",
		keys = {
			{ "<leader>da", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>" },
			{ "<leader>dA", "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>" },
			{ "<leader>dC", "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>" },
		},
		dependencies = { "mfussenegger/nvim-dap" },
		opts = { load_breakpoints_event = { "BufReadPost" } },
		lazy = false,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			"<leader>dr",
			{ "<leader>du", "<cmd>lua require('dapui').toggle()<cr>" },
			{ "<leader>de", "<cmd>lua require('dapui').eval()<cr>" },
		},
		config = function()
			require("dapui").setup()
			require("dap").listeners.after.event_initialized["dapui_config"] = require("dapui").open
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		keys = {
			{ "<leader>dr", "<cmd>Telescope dap configurations<cr>" },
			{ "<leader>dc", "<cmd>Telescope dap commands<cr>" },
			{ "<leader>dv", "<cmd>Telescope dap variables<cr>" },
			{ "<leader>db", "<cmd>Telescope dap list_breakpoints<cr>" },
			{ "<leader>df", "<cmd>Telescope dap frames<cr>" },
		},
		dependencies = { "mfussenegger/nvim-dap", "telescope" },
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		keys = { "<leader>d" },
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {},
	},
}

-- return dap_plugins_spec
return {}
