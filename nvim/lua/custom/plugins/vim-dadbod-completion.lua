return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "kristijanhusak/vim-dadbod-completion", -- Database completion
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
}

