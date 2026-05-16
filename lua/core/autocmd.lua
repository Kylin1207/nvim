-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 200,
        })
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
            buffer = true,
            desc = "Exit terminal insert mode",
        })
    end,
})
