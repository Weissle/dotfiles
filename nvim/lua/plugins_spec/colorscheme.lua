return {
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "moon",
			on_highlights = function(highlights, _)
				highlights.WinSeparator = {
					fg = "#6699FF",
				}
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"sainnhe/gruvbox-material",
        enabled = false,
		opts = {},
		config = function(_, opts)
			vim.cmd("colorscheme gruvbox-material")
		end,
	},
}
