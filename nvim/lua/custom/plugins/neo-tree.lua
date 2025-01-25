-- Kickstart basic configuration
return {
{
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- Optional, for file icons
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                -- Neo-tree options
                close_if_last_window = true, -- Close Neo-tree if it's the last window
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                default_component_configs = {
                    indent = {
                        with_markers = true, -- Add markers + and - for folders
                        indent_size = 2,
                        padding = 1,
                    },
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "",
                        default = "*",
                    },
                },
                window = {
                    position = "left",
                    width = 30,
                    mappings = {
                        ["<space>"] = "toggle_node",
                        ["<CR>"] = "open",
                        ["l"] = "open",
                        ["h"] = "close_node",
                    },
                },
                filesystem = {
                    filtered_items = {
                        visible = false, -- Toggle with "H"
                        hide_dotfiles = true,
                        hide_gitignored = true,
                    },
                    follow_current_file = { 
                    	enabled = true 
                    	},
                    hijack_netrw_behavior = "open_default",
                },
            })
        end,
    },
}
