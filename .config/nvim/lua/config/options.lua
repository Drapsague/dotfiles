-- ~/.config/nvim/lua/config/options.lua

local o = vim.opt

-- UI
o.termguicolors = true
o.number = true
o.relativenumber = true
o.mouse = "a"
o.showmode = false
o.cursorline = true
o.scrolloff = 10
o.signcolumn = "yes"

-- Editing
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
o.breakindent = true
o.undofile = true

-- Searching
o.ignorecase = true
o.smartcase = true

-- Splits
o.splitright = true
o.splitbelow = true

-- List chars
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Commands
o.inccommand = "split"

-- Timings
o.updatetime = 250
o.timeoutlen = 300

-- LSP completion behaviour
o.completeopt = { "menu", "menuone", "noselect" }
o.shortmess:append("c")

