local provider = "copilot"
local strategies = {}
if provider == "deepseek" then
  strategies = {
    chat = {
      adapter = "deepseek",
    },
    inline = {
      adapter = "deepseek",
    },
  }
elseif provider == "copilot" then
  strategies = {}
end

local codecompanion = {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, noremap = true, silent = true },
      { "<leader>aa", "<cmd>CodeCompanionAction<cr>", mode = { "n", "v" }, noremap = true, silent = true },
      { "<leader>aC", "<cmd>CodeCompanionChat Add<cr>", mode = { "v" }, noremap = true, silent = true },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      strategies = strategies,
    },
  },
}

local sidekick = {
  {
    "folke/sidekick.nvim",
    keys = {
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
    },
    opts = {
      nes = { enabled = false },
      mux = {
        backend = "tmux",
        enable = true,
      },
    },
  },
}

return sidekick
