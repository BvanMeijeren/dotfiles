-- Kickstart basic configuration
return {
    {
        "linux-cultist/venv-selector.nvim",
        branch = "regexp", -- New branch for the rewritten 2024 version
        dependencies = {
            "neovim/nvim-lspconfig", -- Required for LSP integration
            "nvim-telescope/telescope.nvim", -- Optional: Enables Telescope support
        },
        config = function()
            require("venv-selector").setup({
                -- Updated configuration options
                search = { patterns = { "venv", ".venv", "env", ".env", "envs" } }, -- Define venv search patterns
                auto_activate = true, -- Automatically activate found venv
                enable_managed_mode = true, -- New mode for managing venvs
                enable_dap = true, -- Enable integration with Debug Adapter Protocol
                show_hidden = false, -- Don't show hidden directories
            })
        end,
    },
}
