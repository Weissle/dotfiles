return {
  {
    "folke/snacks.nvim",
    enabled = true,
    opts = {
      dashboard = { enabled = false },
      bigfile = { enabled = false },
      image = { enabled = false },
      words = { enabled = true, debounce = 50 },
      scroll = { enabled = false },
      win = {
        list = {
          keys = {
            ["<C-c>"] = "close",
          },
        },
        input = {
          keys = {
            ["<C-c>"] = "close",
          },
        },
        preview = {
          keys = {
            ["<C-c>"] = "close",
          },
        },
      },
      picker = {
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
