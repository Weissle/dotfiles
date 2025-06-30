-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { remap = false, silent = true, unique = true }

vim.keymap.set("i", "<C-h>", "<left>", opts)
vim.keymap.set("i", "<C-j>", "<down>", opts)
vim.keymap.set("i", "<C-l>", "<right>", opts)
vim.keymap.set("i", "<C-k>", "<up>", opts)
vim.keymap.set("i", "<C-a>", "<C-o>I", opts)
vim.keymap.set("i", "<C-e>", "<C-o>A", opts)
vim.keymap.set("i", "jj", "<C-[>", opts)

vim.keymap.set("n", "<leader>qT", "<cmd>tabclose<cr>", opts)
vim.keymap.set("n", "<leader>qt", "<cmd>q<cr>", opts)

vim.keymap.set("n", "<F3>", "<cmd>noh<cr>", opts)
vim.keymap.set("s", "<BS>", "<Space><BS>", opts)

-- copy from mini.basic
vim.keymap.set(
  "n",
  "gO",
  "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
  { desc = "Put empty line above" }
)
vim.keymap.set(
  "n",
  "go",
  "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
  { desc = "Put empty line below" }
)
