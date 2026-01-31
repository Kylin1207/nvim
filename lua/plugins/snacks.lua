return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        picker = {
            enabled = true,
            win = {
                input = {
                    keys = {
                        ["<CR>"] = { "confirm", mode = { "n", "i" } },
                        ["<C-f>"] = { "confirm", mode = { "n", "i" } },
                        ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
                        ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
                        ["<C-j>"] = { "list_down", mode = { "i", "n" } },
                        ["<C-k>"] = { "list_up", mode = { "i", "n" } },
                        ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                        ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                        ["?"] = "toggle_help_input",
                        ["G"] = "list_bottom",
                        ["gg"] = "list_top",
                        ["j"] = "list_down",
                        ["k"] = "list_up",
                    },
                },
            },
        },
    },
    keys = {
        { "<leader>ff", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    },
}
