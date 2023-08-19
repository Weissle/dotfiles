return {
	{
		enabled = false,
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "moon",
			on_highlights = function(highlights, _)
				highlights.WinSeparator = {
					fg = "#6699FF",
				}
			end,
		},
	},
	{
		"sainnhe/gruvbox-material",
		lazy = true,
		opts = {},
	},
}
