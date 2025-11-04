return {
  {
    "folke/snacks.nvim",
    enabled = true,
    keys = {
      {
        "<C-n>",
        function()
          require("snacks.explorer").open()
        end,
      },
      {
        "<leader>n",
        function()
          require("snacks.explorer").open({ follow_file = true })
        end,
      },
      {
        "<leader>N",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
    },
    opts = {
      dashboard = { enabled = false },
      bigfile = { enabled = false },
      image = { enabled = false },
      words = { enabled = true, debounce = 50 },
      picker = {
        enabled = false,
        sources = {
          explorer = {
            follow_file = false,
            ignored = true,
            hidden = true,
            win = {
              list = {
                keys = {
                  ["<C-n>"] = "close",
                  ["<C-t>"] = "tab",
                  ["y"] = "copy_file_name",
                  ["Y"] = "copy_file_path",
                  ["D"] = "diffview",
                  ["<CR>"] = { { "pick_win", "confirm" }, mode = { "i", "n" } },
                  ["o"] = { { "pick_win", "confirm" }, mode = { "i", "n" } },
                },
              },
            },
            actions = {
              copy_file_name = function(_, item)
                vim.fn.setreg("+", vim.fn.fnamemodify(item.file, ":t"), "c")
              end,
              copy_file_path = function(_, item)
                vim.fn.setreg("+", vim.fn.fnamemodify(item.file, ":."), "c")
              end,
              diffview = function(_, item)
                local path = vim.fn.fnamemodify(item.file, ":.")
                vim.cmd(string.format("DiffviewFileHistory %s", path))
              end,
            },
          },
        },
      },
    },
  },
}
