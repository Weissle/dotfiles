return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local keymap = opts.keymap
      keymap["preset"] = "super-tab"
      keymap["<Tab>"] = {
        require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
        LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
        "fallback",
      }
      for i = 1, 5, 1 do
        keymap["<A-" .. i .. ">"] = {
          function(cmp)
            cmp.accept({ index = i + 1 })
          end,
        }
      end
    end,
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
          enabled = true,
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
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        delete = "ds",
        replace = "cs",
      },
    },
  },
  {
    "nvim-mini/mini.pairs",
    opts = {
      modes = { command = false },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    opts = {
      region_check_events = "InsertEnter",
      store_selection_keys = "<Tab>",
    },
  },
  {
    "snacks.nvim",
    opts = { dashboard = { enabled = false } },
  },
  {
    "folke/persistence.nvim",
    lazy = false,
    config = function(_, opts)
      require("persistence").setup(opts)
      if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
        require("persistence").load()
      end
    end,
  },
}
