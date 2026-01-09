-- ~/.config/nvim/lua/config/autocmds.lua

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight when yanking",
  group = vim.api.nvim_create_augroup("minimal-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

