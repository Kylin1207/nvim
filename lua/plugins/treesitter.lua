return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',
    opts = {
        auto_install = true,
        ensure_installed = { "c", "cpp", "python", "bash", "yaml", "json" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    },
    opts_extend = { "ensure_installed" },
}
