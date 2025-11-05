return {
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
