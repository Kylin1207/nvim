return {
    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        dependencies = { 
            {
                "nvim-mini/mini.icons",
                opts = {}
            },
        },
        lazy = false,
        config = function()
            local map = require("core.keymaps").map
            map(
                "n",
                "<leader>e",
                function()
                    require("oil").toggle_float()
                end,
                "File explorer"
            )

            require("oil").setup({
                default_file_explorer = true,
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },
                -- Window-local options to use for oil buffers
                win_options = {
                    signcolumn = "yes:4",
                },
                use_default_keymaps = false,
                keymaps = {
                    ["<CR>"] = {
                        "actions.select",
                        mode = "n",
                    },
                    ["<C-f>"] = {
                        "actions.select",
                        mode = "n",
                    },
                    ["<Backspace>"] = {
                        "actions.parent",
                        mode = "n",
                    },
                    ["<C-b>"] = {
                        "actions.parent",
                        mode = "n",
                    },
                    ["<C-w>v"] = { 
                        "actions.select",
                        opts = { vertical = true },
                        desc = "Open the entry in vertical view",
                    },
                    ["<C-w>s"] = { 
                        "actions.select",
                        opts = { horizontal = true },
                        desc = "Open the entry in horizontal view",
                    },
                    ["<C-t>"] = {
                        "actions.select",
                        opts = { tab = true },
                        desc = "Open the entry in new tab",
                    },
                    ["<Esc>"] = {
                        "actions.close",
                        mode = "n",
                    },
                    ["<C-a>"] = {
                        callback = function()
                            local oil = require("oil")
                            local entry = oil.get_cursor_entry()
                            if not entry then return end
                            local dir = oil.get_current_dir()
                            local path = vim.fn.fnamemodify(dir .. entry.name, ":p")
                            vim.fn.setreg("+", path)
                        end,
                        desc = "Copy absolute path",
                    },
                    ["<C-r>"] = {
                        callback = function()
                            local oil = require("oil")
                            local entry = oil.get_cursor_entry()
                            if not entry then return end
                            local dir = oil.get_current_dir()
                            local abs_path = vim.fn.fnamemodify(dir .. entry.name, ":p")
                            local rel_path = vim.fn.fnamemodify(abs_path, ":.")
                            vim.fn.setreg("+", rel_path)
                        end,
                        desc = "Copy relative path",
                    },
                },
                view_options = {
                    show_hidden = true,
                },
                -- Configuration for the floating window in oil.open_float
                float = {
                    -- Padding around the floating window
                    padding = 2,
                    -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    max_width = 0,
                    max_height = 0,
                    border = "rounded",
                    win_options = {
                        winblend = 0,
                    },
                    -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
                    get_win_title = nil,
                    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
                    preview_split = "auto",
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    override = function(conf)
                        return conf
                    end,
                },
            })
        end,
    },
}
