return {
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    opts = {
      filter_rules = {
        bo = {
          filetype = {
            "blink-cmp-documentation",
            "blink-cmp-menu",
            "blink-cmp-signature",
            "edgy",
            "neo-tree",
            "noice",
            "notify",
            "nvimtree",
            "smear-cursor",
            "snacks_dashboard",
            "snacks_notif",
            "snacks_terminal",
            "toggleterm",
            "trouble",
            "tutor",
          },
        },
      },
      hint = "floating-big-letter",
    },
  },
  {
    "karb94/neoscroll.nvim",
    name = "neoscroll",
    keys = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" },
    opts = { mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" }, hide_cursor = false },
  },
}
