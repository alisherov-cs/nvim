vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true

vim.g['prettier#autoformat'] = 1
vim.g['prettier#autoformat_require_pragma'] = 0
vim.g['prettier#autoformat_config_files'] = {
  '**/*.js', '**/*.ts', '**/*.jsx', '**/*.tsx',
  '**/*.css', '**/*.scss', '**/*.json', '**/*.graphql',
  '**/*.md', '**/*.vue', '**/*.yaml', '**/*.lua', '**/*.svelte'
}

vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
vim.g.closetag_filetypes = 'html,xhtml,phtml,jsx,tsx,javascriptreact,typescriptreact'
vim.g.closetag_xhtml_filetypes = 'xhtml,jsx,tsx'

local function enable()
    vim.cmd("CloseTagEnableBuffer")
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = enable
})
