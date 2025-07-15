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
    "mechatroner/rainbow_csv",
    ft = { "csv" },
    setup = function()
      vim.g.rbql_with_headers = 1
    end,
  },
  {
    "Pocco81/HighStr.nvim",
    keys = {
      { "<leader>h0", ":<C-u>HSHighlight 0<cr>", mode = { "v" }, noremap = true },
      { "<leader>h1", ":<C-u>HSHighlight 1<cr>", mode = { "v" }, noremap = true },
      { "<leader>h2", ":<C-u>HSHighlight 2<cr>", mode = { "v" }, noremap = true },
      { "<leader>h3", ":<C-u>HSHighlight 3<cr>", mode = { "v" }, noremap = true },
      { "<leader>h4", ":<C-u>HSHighlight 4<cr>", mode = { "v" }, noremap = true },
      { "<leader>h5", ":<C-u>HSHighlight 5<cr>", mode = { "v" }, noremap = true },
      { "<leader>h6", ":<C-u>HSHighlight 6<cr>", mode = { "v" }, noremap = true },
      { "<leader>h7", ":<C-u>HSHighlight 7<cr>", mode = { "v" }, noremap = true },
      { "<leader>h8", ":<C-u>HSHighlight 8<cr>", mode = { "v" }, noremap = true },
      { "<leader>h9", ":<C-u>HSHighlight 9<cr>", mode = { "v" }, noremap = true },
      { "<leader>hl", ":<C-u>HSHighlight 1<cr>", mode = { "v" }, noremap = true },
      { "<leader>hc", ":<C-u>HSRmHighlight<cr>", mode = { "v" }, noremap = true },
    },
    opts = true,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>" },
      { "<leader>gD", "<cmd>DiffviewFileHistory %<cr>" },
    },
  },
}
