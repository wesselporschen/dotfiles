
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.g.mapleader = " "
vim.opt.ignorecase = true

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
})


require "mini.pick".setup()
require "oil".setup()

vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>gl', ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '<leader>y', '"+y<CR>')
vim.keymap.set('n', '<leader>d', '"+d<CR>')


vim.lsp.enable({
	"lua_ls",
	"pyright",
	"clangd",
})

local pick = require('mini.pick')

vim.keymap.set('n', '<leader>fG', function()
  local root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  pick.builtin.files({
    tool = 'git',
    cwd = root,
  })
end)

vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>fg', ':Pick grep_live<CR>')
-- vim.keymap.set('n', '<leader>fG', '<cmd>Pick files tool=git<CR>')
vim.keymap.set('n', '<leader>tt', '<cmd>Pick files tool=git<CR>')



-- Style and Colorscheme

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
})


vim.cmd.colorscheme("vague")
