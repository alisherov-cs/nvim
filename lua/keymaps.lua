vim.g.mapleader = ' '

vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>s', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':wq<CR>')
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { silent = true })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
