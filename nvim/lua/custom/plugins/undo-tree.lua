return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle', -- Load the plugin only when the command is called
  keys = {
    { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Toggle UndoTree' }, -- Add a keybinding for convenience
  },
  config = function()
    -- Optional: Custom configuration can go here
    vim.g.undotree_SetFocusWhenToggle = 1 -- Focus on the undotree window when toggled
  end,
}
