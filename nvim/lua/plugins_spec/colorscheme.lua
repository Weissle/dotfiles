return {
	{
		-- enabled = false,
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
		init = function()
			vim.g.gruvbox_material_enable_italic = 0
			vim.g.gruvbox_material_disable_italic_comment = 1
		end,
	},
}
