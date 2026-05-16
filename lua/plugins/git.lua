return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
                change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                topdelete    = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                untracked    = {hl = 'GitSignsAdd',    text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
                changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
            },
            signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true
            },

            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',

            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            on_attach = function(bufnr)
                local map = require("core.keymaps").map

                local function buf_map(mode, lhs, rhs, desc)
                    map(mode, lhs, rhs, desc, { buffer = bufnr })
                end

                -- hunk navigation
                buf_map("n", "]g", "<cmd>Gitsigns next_hunk<CR>", "Next hunk")
                buf_map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", "Prev hunk")
                buf_map("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", "Next hunk")
                buf_map("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", "Prev hunk")

                -- stage / reset hunk
                buf_map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk")
                buf_map("v", "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
                buf_map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk")
                buf_map("v", "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset hunk")

                -- undo / buffer level
                buf_map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk")
                buf_map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", "Stage buffer")
                buf_map("n", "<leader>gU", "<cmd>Gitsigns reset_buffer_index<CR>", "Unstage buffer")
                buf_map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", "Reset buffer")

                -- preview / blame / diff
                buf_map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk")
                buf_map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle blame")
                buf_map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", "Diff this")
                buf_map(
                    "n",
                    "<leader>gD",
                    function() require("gitsigns").diffthis("~") end,
                    "Diff against HEAD~"
                )
                buf_map(
                    "n",
                    "<leader>gq",
                    function()
                        vim.cmd("windo if &diff | diffoff | endif")
                        vim.cmd("only")
                    end,
                    "Close git diff buffer"
                )
                buf_map(
                    "n",
                    "<leader>gQ",
                    "<cmd>diffoff<CR>",
                    "Close git diff"
                )
            end
        })
    end,
}
