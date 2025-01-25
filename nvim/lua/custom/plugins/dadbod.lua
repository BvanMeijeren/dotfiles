return {
  -- Plugin for database connections
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui", -- UI for managing database interactions
      "kristijanhusak/vim-dadbod-completion", -- Autocompletion for database queries
    },
    config = function()
      -- Configure vim-dadbod-ui save location
      vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
    end,
    cmd = {
      "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer",
    },
    keys = {
      { "<leader>Du", ":DBUI<CR>", desc = "Open Database UI" },
    },
  },
}

