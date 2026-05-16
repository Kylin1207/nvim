return {
    {
        "fnune/recall.nvim",
        version = "*",
        lazy = false,
        dependencies = {
            "folke/snacks.nvim",
        },
        config = function()
            local map = require("core.keymaps").map
            local recall = require("recall")
            local recall_utils = require("recall.utils")

            recall.setup({})

            local function current_mark_index(marks)
                local bufnr = vim.api.nvim_get_current_buf()
                local row = vim.api.nvim_win_get_cursor(0)[1]

                for index, mark in ipairs(marks) do
                    local pos = mark.info.pos
                    if pos[1] == bufnr and pos[2] == row then
                        return index
                    end
                end

                return nil
            end

            local function jump_to_mark(mark)
                local file = mark.info.file
                if not file or file == "" then
                    vim.notify("Mark has no file path", vim.log.levels.WARN)
                    return
                end

                vim.cmd.edit(vim.fn.fnameescape(file))
                vim.api.nvim_win_set_cursor(0, { mark.info.pos[2], mark.info.pos[3] })
            end

            local function jump_mark(direction)
                local marks = recall_utils.sorted_global_marks()
                if #marks == 0 then
                    vim.notify("No global marks set", vim.log.levels.INFO)
                    return
                end

                local index = current_mark_index(marks)
                if index then
                    if direction == "next" then
                        index = (index % #marks) + 1
                    else
                        index = ((index - 2 + #marks) % #marks) + 1
                    end
                else
                    index = direction == "next" and 1 or #marks
                end

                jump_to_mark(marks[index])
            end

            local function map_mark_jumps(bufnr)
                vim.keymap.set("n", "]m", function() jump_mark("next") end, {
                    buffer = bufnr,
                    desc = "Mark: Next",
                    noremap = true,
                    silent = true,
                })
                vim.keymap.set("n", "[m", function() jump_mark("prev") end, {
                    buffer = bufnr,
                    desc = "Mark: Previous",
                    noremap = true,
                    silent = true,
                })
            end

            map("n", "<leader>mm", recall.toggle, "Mark: Toggle")
            map("n", "<leader>mc", recall.clear, "Mark: Clear all")
            map("n", "<leader>ml", require("recall.snacks").pick, "Mark: List")

            map_mark_jumps(0)
            vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
                group = vim.api.nvim_create_augroup("RecallMarkJumps", { clear = true }),
                callback = function(event)
                    if vim.bo[event.buf].buftype == "" then
                        map_mark_jumps(event.buf)
                    end
                end,
            })
        end,
    },
}
