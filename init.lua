require("options")
require("keymaps")
require("plugins")

local undodir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

-- Enable persistent undo
vim.opt.undofile = true
vim.opt.undodir = undodir

vim.opt.undolevels = 1000       -- max undo steps
vim.opt.undoreload = 10000      -- max lines to save for undo
