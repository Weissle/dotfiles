return {
	{
		"folke/tokyonight.nvim",
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd("colorscheme tokyonight")
		end,
		opts = {
			style = "moon",
			on_highlights = function(highlights, _)
				highlights.WinSeparator = {
					fg = "#6699FF",
				}
			end,
		},
	},
}
