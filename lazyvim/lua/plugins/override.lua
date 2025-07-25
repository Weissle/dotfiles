return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<Tab>"] = {
          require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
          LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
          "fallback",
        },
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
            dir = vim.uv.cwd(),
          })
        end,
      },
      {
        "<leader>n",
        function()
          require("neo-tree.command").execute({
            action = "focus",
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
          enabled = false,
        },
        filtered_items = {
          visible = true,
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
    opts = function(_, opts)
      local config = require("fzf-lua.config")
      local actions = require("fzf-lua.actions")
      config.defaults.actions.files["ctrl-t"] = actions.file_tabedit
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<c-k>", false, mode = { "i" } }
    end,
  },
  {

    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          filetypes = { "c", "cpp" },
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>n", mode = { "n" }, false },
      {
        "<leader>N",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    opts = {
      delay = 50,
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ["*"] = { "typos" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        proto = { "clang_format" },
        xml = { "xmllint" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bj", "<cmd>BufferLinePick<cr>" },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        delete = "ds",
        replace = "cs",
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    opts = {
      modes = { command = false },
    },
  },
}
