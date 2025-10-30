-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Assign a new way to escape INSERT mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
