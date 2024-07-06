require("util")
require("settings")
require("mappings")
require("plugins")

local grpid = vim.api.nvim_create_augroup("custom_highlights_gruvbox_material", {})
vim.api.nvim_create_autocmd("ColorScheme", {
	group = grpid,
	pattern = "gruvbox-material",
	callback = function()
		local config = vim.fn["gruvbox_material#get_configuration"]()
		local palette =
			vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
		local set_hl = vim.fn["gruvbox_material#highlight"]

		set_hl("HopNextKey", palette.purple, palette.none)
		set_hl("HopNextKey1", palette.red, palette.none)
		set_hl("HopNextKey2", palette.orange, palette.none)
	end,
})

vim.cmd("colorscheme gruvbox-material")
