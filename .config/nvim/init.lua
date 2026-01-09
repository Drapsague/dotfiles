-- ~/.config/nvim/init.lua
-- Set leaders *before* anything that uses <leader>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core config
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")
require("config.formatting")
require("config.highlights")
require("config.harpoon")

