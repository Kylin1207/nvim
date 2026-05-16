vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("basedpyright")
vim.lsp.enable("copilot")
-- vim.lsp.enable("ty")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("SetupLSP", {}),
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

        -- [inlay hint] default ON, toggle with <leader>ch
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            -- default enable
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

            vim.keymap.set('n', '<leader>ch', function()
                local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
            end, { buffer = event.buf, desc = 'LSP: Toggle Inlay Hints' })
        end

        -- [code action]
        vim.keymap.set({ "n", "v" }, "<leader>ca", function()
            vim.lsp.buf.code_action({
                apply = true,
                context = { only = { "quickfix" } },
            })
        end, { buffer = event.buf, desc = "LSP: Code Action (Quickfix)" })

        -- [rename]
        vim.keymap.set("n", "<leader>cr", function()
            vim.lsp.buf.rename()
        end, { buffer = event.buf, desc = "LSP: Rename" })

        -- [keymaps]
        vim.keymap.set("n", "gd", function()
            local params = vim.lsp.util.make_position_params(0, "utf-8")
            vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, _, _)
                if not result or vim.tbl_isempty(result) then
                    vim.notify("No definition found", vim.log.levels.INFO)
                else
                    require("snacks").picker.lsp_definitions()
                end
            end)
        end, { buffer = event.buf, desc = "LSP: Goto Definition" })

        vim.keymap.set("n", "gD", function()
            local win = vim.api.nvim_get_current_win()
            local width = vim.api.nvim_win_get_width(win)
            local height = vim.api.nvim_win_get_height(win)
            -- Mimic tmux formula: 8 * width - 20 * height
            local value = 8 * width - 20 * height
            if value < 0 then
                vim.cmd("split")  -- vertical space is more: horizontal split
            else
                vim.cmd("vsplit") -- horizontal space is more: vertical split
            end
            vim.lsp.buf.definition()
        end, { buffer = event.buf, desc = "LSP: Goto Definition (split)" })

        vim.keymap.set("n", "gi", function()
            vim.lsp.buf.implementation()
        end, { buffer = event.buf, desc = "LSP: Goto Implementation" })

        vim.keymap.set("n", "gI", function()
            local win = vim.api.nvim_get_current_win()
            local width = vim.api.nvim_win_get_width(win)
            local height = vim.api.nvim_win_get_height(win)
            -- Mimic tmux formula: 8 * width - 20 * height
            local value = 8 * width - 20 * height
            if value < 0 then
                vim.cmd("split")  -- vertical space is more: horizontal split
            else
                vim.cmd("vsplit") -- horizontal space is more: vertical split
            end
            vim.lsp.buf.implementation()
        end, { buffer = event.buf, desc = "LSP: Goto Implementation (split)" })
    end,
})
