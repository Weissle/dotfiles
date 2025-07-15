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
      sources = {
        providers = {
          snippets = {
            opts = {
              filter_snippets = function(ft, file)
                return not (string.match(file, "friendly.snippets") and string.match(file, "framework"))
              end,
            },
          },
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
          ["y"] = {
            function(state)
              local node = state.tree:get_node()
              vim.fn.setreg("+", node.name, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
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
    keys = {
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sW", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
      { "<leader>sw", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
      { "<leader>sW", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sw", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
    },
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
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bj", "<cmd>BufferLinePick<cr>" },
    },
  },
}
