return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = function(_, opts)
      local gruvbox = require("gruvbox")
      local palette = gruvbox.palette
      opts.overrides = opts.overrides or {}
      opts.overrides["IlluminatedWordText"] = { fg = palette.bright_yellow, bold = false, bg = palette.dark1 }
      opts.overrides["IlluminatedWordRead"] = { fg = palette.bright_yellow, bold = false, bg = palette.dark1 }
      opts.overrides["IlluminatedWordWrite"] = { fg = palette.bright_orange, bold = false, bg = palette.dark1 }
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
