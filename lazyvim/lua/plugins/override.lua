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
    keys = {
      {
        "<leader>tn",
        function()
          require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
        end,
      },
      {
        "<leader>tp",
        function()
          require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
        end,
      },
    },
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
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "<c-k>", false, mode = { "i" } },
          },
        },
        clangd = {
          filetypes = { "c", "cpp" },
        },
      },
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
    "folke/persistence.nvim",
    lazy = false,
    enabled = function()
      return vim.fn.argc() == 0
    end,
    config = function(_, opts)
      require("persistence").setup(opts)
      if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
        require("persistence").load()
      end
    end,
  },
}
