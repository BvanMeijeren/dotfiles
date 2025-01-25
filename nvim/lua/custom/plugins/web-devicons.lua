return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    -- Optional: You can customize the default icon settings here
    require('nvim-web-devicons').setup {
      -- default icon settings
      default = true,
    }
  end,
}
