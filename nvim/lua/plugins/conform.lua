return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format file",
    },
  },
  opts = {
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 1000,
    },
    formatters_by_ft = {
      python = { "black" },
      sql = { "sql_formatter" },
    },
    formatters = {
      black = {
        command = "black",
        args = { "-" },
        stdin = true,
      },
      sqlfluff = {
        command = "sql_fomatter",
        args = { "fix", "--stdin", "--dialect", "postgres", "-" },
        stdin = true,
      },
    },
  },
}
