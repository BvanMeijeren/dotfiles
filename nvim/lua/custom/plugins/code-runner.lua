-- Kickstart basic configuration
return {
    {
        "CRAG666/code_runner.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("code_runner").setup({
                filetype = {
                    python = "python3 -u",
                    javascript = "node",
                    java = "javac % && java %<",
                },
                mode = "toggleterm",
                term = {
                    position = "belowright",
                    size = 15,
                },
            })
        end,
    },

    -- ToggleTerm plugin for terminal integration
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup()
        end,
    }
}
