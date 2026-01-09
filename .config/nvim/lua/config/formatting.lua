-- ~/.config/nvim/lua/config/formatting.lua

local map = vim.keymap.set

-- <leader>f = format buffer (prefer LSP; fallback to clang-format)
map("n", "<leader>f", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients > 0 then
    vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 1500 })
  else
    if vim.fn.executable("clang-format") == 1 then
      local view = vim.fn.winsaveview()
      vim.cmd("%!clang-format")
      vim.fn.winrestview(view)
    else
      vim.notify("No LSP and clang-format not found", vim.log.levels.WARN)
    end
  end
end, { desc = "[F]ormat buffer" })

-- Format on save for C/C++
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("c-family-format-on-save", { clear = true }),
  pattern = { "*.c", "*.cc", "*.cpp", "*.h", "*.hh", "*.hpp" },
  callback = function(args)
    local bufnr = args.buf
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients > 0 then
      vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 1500 })
    elseif vim.fn.executable("clang-format") == 1 then
      local view = vim.fn.winsaveview()
      vim.cmd("%!clang-format")
      vim.fn.winrestview(view)
    end
  end,
})

