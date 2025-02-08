return {
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.g.lazygit_floating_window_use_plenary = 1 -- Use plenary for floating window
      vim.g.lazygit_floating_window_winblend = 10 -- Transparency
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- Size of floating window

      -- Keybinding to open LazyGit
      vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', { noremap = true, silent = true })
    end,
  },
}
