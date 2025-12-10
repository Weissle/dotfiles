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
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<C-n>",
        function()
          require("neo-tree.command").execute({
            action = "focus",
            reveal = true,
            dir = vim.uv.cwd(),
          })
        end,
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            reveal = true,
            dir = vim.uv.cwd(),
          })
        end,
      },
    },
    opts = {
      window = {
        auto_expand_width = true,
        mappings = {
          ["<C-s>"] = "split_with_window_picker",
          ["<C-t>"] = "open_tabnew",
          ["<C-v>"] = "vsplit_with_window_picker",
          ["<cr>"] = "open_with_window_picker",
          ["o"] = "open_with_window_picker",
          ["z"] = "none",
          ["Z"] = "close_all_nodes",
          ["s"] = "none",
          ["c"] = "copy_to_clipboard",
          ["/"] = "none",
          ["D"] = {
            function(state)
              local path = state.tree:get_node():get_id()
              path = vim.fn.fnamemodify(path, ":.")
              local cmd = string.format("DiffviewFileHistory %s", path)
              vim.cmd(cmd)
            end,
          },
          ["y"] = {
            function(state)
              local node = state.tree:get_node()
              vim.fn.setreg("+", node.name, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["Y"] = {
            function(state)
              local path = state.tree:get_node():get_id()
              path = vim.fn.fnamemodify(path, ":.")
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          visible = true,
        },
      },
    },
  },
}
