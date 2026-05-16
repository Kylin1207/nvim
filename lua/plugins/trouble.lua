return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
        modes = {
            lsp = {
                win = { position = "right" },
            },
        },
    },
    keys = {
        {
            "<leader>cd",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>cD",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "]d",
            function()
                vim.diagnostic.goto_next({ wrap = true })
            end,
            desc = "Next Diagnostic (wrap)",
        },
        {
            "[d",
            function()
                vim.diagnostic.goto_prev({ wrap = true })
            end,
            desc = "Prev Diagnostic (wrap)",
        },
    },
}
