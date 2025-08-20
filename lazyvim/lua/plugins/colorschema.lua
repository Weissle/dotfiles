return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = function(_, opts)
      local gruvbox = require("gruvbox")
      local palette = gruvbox.palette
      local bg = palette.dark1
      opts.overrides = opts.overrides or {}
      opts.overrides["IlluminatedWordText"] = { bold = false, bg = bg }
      opts.overrides["IlluminatedWordRead"] = { bold = false, bg = bg }
      opts.overrides["IlluminatedWordWrite"] = { bold = false, bg = bg }
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
