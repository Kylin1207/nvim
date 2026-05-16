return {
    "folke/sidekick.nvim",
    dependencies = {
        "folke/snacks.nvim",
    },
    opts = {
        cli = {
            picker = "snacks",
        },
    },
    keys = {
        {
            "<leader>aa",
            function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local cli = vim.w[win].sidekick_cli
                    local name = type(cli) == "table" and cli.name or cli
                    if name == "copilot" then
                        require("sidekick.cli").hide({ name = "copilot" })
                        return
                    end
                end
                require("sidekick.cli").show({ name = "copilot", focus = true })
            end,
            desc = "Sidekick Toggle Copilot CLI",
        },
        {
            "<leader>as",
            function()
                require("sidekick.cli").select()
            end,
            desc = "Sidekick Select CLI",
        },
        {
            "<leader>ap",
            function()
                require("sidekick.cli").prompt()
            end,
            mode = { "n", "x" },
            desc = "Sidekick Prompt",
        },
        {
            "<leader>af",
            function()
                require("sidekick.cli").send({ msg = "{file}" })
            end,
            desc = "Sidekick Send File",
        },
        {
            "<leader>at",
            function()
                require("sidekick.cli").send({ msg = "{this}" })
            end,
            mode = { "n", "x" },
            desc = "Sidekick Send This",
        },
    },
}
