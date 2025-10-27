return {
  {
    "mechatroner/rainbow_csv",
    ft = { "csv" },
    config = function()
      vim.g.rbql_with_headers = 1
    end,
  },
  {
    "Pocco81/HighStr.nvim",
    keys = {
      { "<leader>h0", ":<C-u>HSHighlight 0<cr>", mode = { "v" }, noremap = true },
      { "<leader>h1", ":<C-u>HSHighlight 1<cr>", mode = { "v" }, noremap = true },
      { "<leader>h2", ":<C-u>HSHighlight 2<cr>", mode = { "v" }, noremap = true },
      { "<leader>h3", ":<C-u>HSHighlight 3<cr>", mode = { "v" }, noremap = true },
      { "<leader>h4", ":<C-u>HSHighlight 4<cr>", mode = { "v" }, noremap = true },
      { "<leader>h5", ":<C-u>HSHighlight 5<cr>", mode = { "v" }, noremap = true },
      { "<leader>h6", ":<C-u>HSHighlight 6<cr>", mode = { "v" }, noremap = true },
      { "<leader>h7", ":<C-u>HSHighlight 7<cr>", mode = { "v" }, noremap = true },
      { "<leader>h8", ":<C-u>HSHighlight 8<cr>", mode = { "v" }, noremap = true },
      { "<leader>h9", ":<C-u>HSHighlight 9<cr>", mode = { "v" }, noremap = true },
      { "<leader>hl", ":<C-u>HSHighlight 1<cr>", mode = { "v" }, noremap = true },
      { "<leader>hc", ":<C-u>HSRmHighlight<cr>", mode = { "v" }, noremap = true },
    },
    opts = true,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>" },
      { "<leader>gD", "<cmd>DiffviewFileHistory %<cr>" },
    },
  },
  {
    "jake-stewart/multicursor.nvim",
    enabled = true,
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<up>", function()
        mc.lineAddCursor(-1)
      end)
      set({ "n", "x" }, "<down>", function()
        mc.lineAddCursor(1)
      end)
      set({ "n", "x" }, "<leader><up>", function()
        mc.lineSkipCursor(-1)
      end)
      set({ "n", "x" }, "<leader><down>", function()
        mc.lineSkipCursor(1)
      end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "cn", function()
        mc.matchAddCursor(1)
      end)
      set({ "n", "x" }, "cs", function()
        mc.matchSkipCursor(1)
      end)
      set({ "n", "x" }, "cN", function()
        mc.matchAddCursor(-1)
      end)
      set({ "n", "x" }, "cS", function()
        mc.matchSkipCursor(-1)
      end)

      -- Split visual selections by regex.
      set("x", "cs", mc.splitCursors)

      -- match new cursors within visual selections by regex.
      set("x", "cm", mc.matchCursors)

      set("x", "I", mc.insertVisual)
      set("x", "A", mc.appendVisual)
      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
}
