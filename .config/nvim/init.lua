-- [[ options ]] --

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.updatetime = 50
vim.opt.scrolloff = 8
vim.g.have_nerd_font = true

vim.g.mapleader = " "

-- highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank({
            timeout = 20,
        })
    end,
})

-- [[ general keymaps ]] --

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic message' })

-- [[ plugins ]] --

vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/theprimeagen/harpoon" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/vague2k/vague.nvim" },
})


-- [[ style and colorscheme ]] --

vim.cmd.colorscheme("vague")

vim.api.nvim_set_hl(0, "Search", {
    fg = "#000000",
    bg = "#ffcc00",
})

vim.api.nvim_set_hl(0, "IncSearch", {
    fg = "#000000",
    bg = "#ff8800",
})

-- undotree

vim.keymap.set('n', '<leader>U', ':UndotreeToggle<CR>')

-- lsp and completion

vim.lsp.enable({
    "lua_ls",
    "pyright",
    "clangd",
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }

        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
    end,
})


-- harpoon

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>a', function()
    mark.add_file()
    vim.notify('File added to harpoon')
end)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end)
vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end)
vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end)
vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end)


-- oil

require "oil".setup()

vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>gl', ':lua vim.diagnostic.open_float()<CR>')


-- mini.pick

require "mini.pick".setup()

vim.keymap.set('n', '<leader>fh', ':Pick help<CR>')
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>fg', ':Pick grep_live<CR>')
-- vim.keymap.set('n', '<leader>tt', '<cmd>Pick files tool=git<CR>')

local pick = require('mini.pick')
vim.keymap.set('n', '<leader>fG', function()
    local root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    pick.builtin.files({
        tool = 'git',
        cwd = root,
    })
end)
