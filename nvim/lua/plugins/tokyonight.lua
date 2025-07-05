return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "storm", -- Choose 'storm', 'night', or 'day'
        transparent = true,
        terminal_colors = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },
  -- onedark theme
  -- {
  --   "navarasu/onedark.nvim",
  --   config = function()
  --     require("onedark").setup({
  --       style = "darker",   -- Or your chosen style
  --       transparent = true, -- Enable transparency
  --     })
  --     require("onedark").load()
  --   end,
  -- },
}
