return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {
                numbers = function(opts)
                    return string.format("[%d] ", opts.ordinal)
                end,
                -- indicator = {
                    --     style = "icon",
                    --     icon = "",
                    -- },
                },

            })
            local map = require("core.keymaps").map

            map("n", "<leader>bd", function()
                local ok, bufferline = pcall(require, "bufferline")
                if not ok then return end
                local n = vim.v.count
                if n == 0 then
                    vim.cmd("bdelete")
                    return
                end
                local res = bufferline.get_elements()
                local elements = res and (res.elements or res) or {}
                local e = elements[n]
                if not e then
                    vim.notify("No buffer at ordinal " .. n, vim.log.levels.WARN)
                    return
                end
                local bufnr = e.id or e.bufnr or e.number
                if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
                    vim.notify("Invalid buffer for ordinal " .. n, vim.log.levels.WARN)
                    return
                end
                vim.api.nvim_buf_delete(bufnr, { force = false })
            end, "Delete buffer by number (count)")
            map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", "Delete other buffers")
            map("n", "<leader>bp", "<cmd>BufferLineCyclePrev<CR>","Previous buffer")
            map("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", "Next buffer")
            -- map("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", "Pin/Unpin buffer")
            map("n", "<leader>bg", function()
                require("bufferline").go_to(vim.v.count1, true)
            end, "Go to buffer by number (count)")
        end,
    }
