return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<C-n>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = LazyVim.root(),
          })
        end,
      },
      {
        "<C-m>",
        function()
          require("neo-tree.command").execute({
            action = "focus",
            reveal = true,
          })
        end,
      },
    },
    opts = {
      window = {
        mappings = {
          ["<C-s>"] = "split_with_window_picker",
          ["<C-v>"] = "vsplit_with_window_picker",
          ["<cr>"] = "open_with_window_picker",
          ["o"] = {
            command = "open_with_window_picker",
            nowait = true,
          },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = false,
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sn"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>sp"] = "@parameter.inner",
          },
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    },
    opts = function(_, opts)
      local config = require("fzf-lua.config")
      local actions = require("fzf-lua.actions")
      config.defaults.actions.files["ctrl-t"] = actions.file_tabedit
    end,
  },
}
