-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Assign a new way to escape INSERT mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

-- Global diagnostics toggle (disabled by default)
local diagnostics_enabled = false

-- Make sure diagnostics are actually off on startup
vim.defer_fn(function()
  vim.diagnostic.disable()
end, 100)

vim.keymap.set("n", "<leader>ul", function()
  diagnostics_enabled = not diagnostics_enabled
  if diagnostics_enabled then
    vim.diagnostic.enable()
    vim.notify("✅ Diagnostics enabled", vim.log.levels.INFO)
  else
    vim.diagnostic.disable()
    vim.notify("🚫 Diagnostics disabled", vim.log.levels.WARN)
  end
end, { desc = "Toggle diagnostics (linting)" })
