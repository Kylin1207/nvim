return {
    {
        "Mofiqul/dracula.nvim",
        priority = 1000,
        init = function()
            vim.cmd.colorscheme("dracula")
        end,
    },
    { 
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            highlight_overrides = {
                mocha = function(mocha)
                    return {
                        UfoFoldLineCount = {
                            bg = mocha.green,
                            fg = mocha.base,
                            style = { "bold" },
                        },
                        UfoFoldLineCountEdge = {
                            bg = mocha.base,
                            fg = mocha.green,
                        },
                    }
                end,
            },
        },
        -- config = function(_, opts)
        --     require("catppuccin").setup(opts)
        --     vim.cmd.colorscheme("catppuccin-mocha")
        -- end,
    },
}
