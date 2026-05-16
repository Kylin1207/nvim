local function project_root()
    local root = vim.fs.root(0, { ".git" })
    if root and type(root) == "string" then
        return root
    end
    local cwd = vim.fn.getcwd()
    if cwd and type(cwd) == "string" then
        return cwd
    end
    return vim.env.HOME or "/tmp"
end

local TERMS = {}

local function valid_term(term)
    return term ~= nil and type(term) == "table"
end

local function term_hide(term)
    if not valid_term(term) then return false end
    if type(term.hide) == "function" then term:hide(); return true end
    if type(term.close) == "function" then term:close(); return true end
    if type(term.toggle) == "function" then term:toggle(); return true end
    return false
end

local function term_show(term)
    if not valid_term(term) then return false end
    if type(term.show) == "function" then term:show(); return true end
    if type(term.open) == "function" then term:open(); return true end
    if type(term.toggle) == "function" then term:toggle(); return true end
    return false
end

local function open_new_terminal()
    local cwd = project_root()
    if not cwd or type(cwd) ~= "string" or cwd == "" then
        cwd = vim.env.HOME or "/tmp"
    end

    local term = Snacks.terminal.open(nil, { cwd = cwd })

    if valid_term(term) then
        table.insert(TERMS, term)
        vim.notify(("Terminal %d created"):format(#TERMS), vim.log.levels.INFO)
    else
        vim.notify("Snacks.terminal.open did not return a terminal object; cannot track numbering reliably.", vim.log.levels.WARN)
    end
end

local function hide_nth_terminal(n)
    local term = TERMS[n]
    if term and term_hide(term) then
        return
    end
    vim.notify(("Terminal %d not found"):format(n), vim.log.levels.WARN)
end

local function hide_all_terminals()
    local any = false
    for i = 1, #TERMS do
        local term = TERMS[i]
        if term and term_hide(term) then
            any = true
        end
    end
    if not any then
        vim.notify("No terminals to hide", vim.log.levels.INFO)
    end
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
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
        indent = {
            priority = 1,
            enabled = true,
            char = "│",
            only_scope = false,
            only_current = false,
            hl = "SnacksIndent",
        },
        scope = {
            enabled = true,
            priority = 200,
            char = "│",
            underline = false,
            only_current = false,
            hl = "SnacksIndentScope",
        },
        lazygit = { enabled = true },
        terminal = { enabled = true },
    },

    keys = {
        {
            "<leader>ff",
            function()
                Snacks.picker.smart({ cwd = project_root() })
            end,
            desc = "Smart Find Files (project)",
        },
        {
            "<leader>fc",
            function()
                Snacks.picker.grep({ cwd = project_root() })
            end,
            desc = "Grep (project)",
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>gu",
            function()
                Snacks.lazygit.open()
            end,
            desc = "LazyGit",
        },

        -- {
        --     "<leader>to",
        --     function()
        --         open_new_terminal()
        --     end,
        --     desc = "Terminal: Open (new, numbered)",
        -- },
        --
        -- {
        --     "<leader>th",
        --     function()
        --         local n = vim.v.count
        --         if not n or n == 0 then
        --             n = 1
        --         end
        --         hide_nth_terminal(n)
        --     end,
        --     desc = "Terminal: Hide (1st or Nth with count)",
        -- },
        --
        -- {
        --     "<leader>tH",
        --     function()
        --         hide_all_terminals()
        --     end,
        --     desc = "Terminal: Hide all",
        -- },
    },
}
