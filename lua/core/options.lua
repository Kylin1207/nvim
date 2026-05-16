vim.g.autoformat = false
vim.g.inlay_hints = true
vim.g.codelens = true
vim.g.copilot_enabled = true

vim.g.kind_icons = "lspkind"
vim.g.picker = "snacks"

vim.g.transparent = false
vim.g.bordered = false
vim.o.winborder = "rounded"
vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
}

local opt = vim.opt

function _G.custom_foldtext()
    local line = vim.fn.getline(vim.v.foldstart)
    local line_count = vim.v.foldend - vim.v.foldstart + 1

    line = line:gsub("\t", string.rep(" ", vim.bo.tabstop))
    line = line:gsub("^%s+", "")

    return ("%s ... [%d lines folded]"):format(line, line_count)
end

-- UI/General
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.cursorline = true
opt.cursorcolumn = false
opt.termguicolors = true
opt.confirm = true
opt.mouse = "a"
opt.undofile = true
opt.swapfile = false
opt.conceallevel = 1
opt.scrolloff = 8
opt.linebreak = true
opt.showtabline = 0
opt.showmode = false

-- Set tab width
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = true

opt.updatetime = 200
opt.laststatus = 3

opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldtext = "v:lua.custom_foldtext()"
opt.shiftround = true -- Round indent
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Disable line wrap
opt.undolevels = 10000
opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
opt.termguicolors = true

vim.g.python3_host_prog = "/usr/bin/python"
