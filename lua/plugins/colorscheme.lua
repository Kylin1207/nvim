return {
    {
        "Mofiqul/dracula.nvim",
        priority = 1000,
        -- init = function()
        --     vim.cmd.colorscheme("dracula")
        -- end,
    },
    {
        "blazkowolf/gruber-darker.nvim",
        priority = 1000,
        opts = {
            bold = false,
            italic = {
                strings = false,
            },
        },
        -- init = function()
        --     vim.cmd.colorscheme("gruber-darker")
        -- end,
    },
    {
        "slugbyte/lackluster.nvim",
        lazy = false,
        priority = 1000,
        -- init = function()
        --     -- vim.cmd.colorscheme("lackluster")
        --     -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
        --     vim.cmd.colorscheme("lackluster-mint")
        -- end,
    },
}
