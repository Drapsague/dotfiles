-- ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set

-- Netrw file explorer
map("n", "<leader>e", "<cmd>Ex<CR>", { desc = "Open file explorer (netrw)" })

-- Trigger built-in omnifunc completion (used by clangd)
map("i", "<C-Space>", "<C-x><C-o>", { desc = "Trigger completion" })

-- Basic keymaps (plugin-free)
map("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear search highlight
map("n", "<leader>q", vim.diagnostic.setloclist,
  { desc = "open diagnostic [q]uickfix list" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "move focus left" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "move focus right" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "move focus down" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "move focus up" })

-- Tabs
map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "next tab" })
map("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "prev tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "close tab" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "open new tab" })

-- Indent with Tab / Shift-Tab (normal + visual)
map("v", "<Tab>", ">gv", { noremap = true, silent = true, desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true, desc = "Unindent selection" })
map("n", "<Tab>", ">>_", { noremap = true, silent = true, desc = "Indent line" })
map("n", "<S-Tab>", "<<_", { noremap = true, silent = true, desc = "Unindent line" })

-- Move selected lines (visual)
map("v", "<S-J>", ":m '>+1<CR>gv=gv",
  { noremap = true, silent = true, desc = "Move selection down" })
map("v", "<S-K>", ":m '<-2<CR>gv=gv",
  { noremap = true, silent = true, desc = "Move selection up" })

