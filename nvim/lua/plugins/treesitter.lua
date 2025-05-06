return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
					-- "ruby",
					"html",
					"css",
					"scss",
					-- "javascript",
					-- "typescript",
					"json",
					"lua",
				},
				highlight = { enable = true },
				indent = { enable = false },
			})
		end,
	},
}
