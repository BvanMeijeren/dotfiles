return {
	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		lazy = true,
		ft = { "sql", "mysql", "plsql" },
		cmd = {
			"DBUI",
			"DBUIAddConnection",
			"DBUIFindBuffer",
			"DBUIRenameBuffer",
		},
		keys = {
			{ "<leader>Du", ":DBUI<CR>", desc = "Open Database UI" },
		},
		config = function()
			vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
		end,
	},

	-- Optional: nvim-cmp integration for SQL completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"kristijanhusak/vim-dadbod-completion",
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.sources = cmp.config.sources(vim.tbl_extend("force", opts.sources or {}, {
				{ name = "vim-dadbod-completion" },
			}))
			return opts
		end,
	},
}
