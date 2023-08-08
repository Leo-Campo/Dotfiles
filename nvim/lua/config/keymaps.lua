-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump half page [U]p" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump half page [D]own" })
vim.keymap.set("n", "<C-a>", "gg<C-v>G", { desc = "Select [A]ll" })
