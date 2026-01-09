-- ~/.config/nvim/lua/config/lsp.lua
-- Native LSP: clangd only, plugin-free, semantic tokens if available

local function enable_semantic_tokens(client, bufnr)
  local caps = client.server_capabilities
  if not caps or not caps.semanticTokensProvider then
    return
  end

  -- Newer Neovim API (0.10+)
  if vim.lsp.semantic_tokens and vim.lsp.semantic_tokens.start then
    -- This is safe: if it doesn't exist, we simply don't call it
    vim.lsp.semantic_tokens.start(bufnr, client.id)
  end

  -- Older experimental APIs are ignored; we don't call anything that might be nil.
end

local function on_attach(client, bufnr)
  local function buf_map(lhs, rhs, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- Navigation / actions
  buf_map("gd", vim.lsp.buf.definition,         "Goto Definition")
  buf_map("gr", vim.lsp.buf.references,         "References")
  buf_map("gI", vim.lsp.buf.implementation,     "Goto Implementation")
  buf_map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
  buf_map("<leader>rn", vim.lsp.buf.rename,     "Rename")
  buf_map("<leader>ca", vim.lsp.buf.code_action,"Code Action", { "n", "x" })
  buf_map("gD", vim.lsp.buf.declaration,        "Goto Declaration")

  -- LSP completion
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Inlay hints (if your version supports it)
  if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
    buf_map("<leader>th", function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    end, "Toggle Inlay Hints")
  end

  -- Semantic tokens (only if Neovim + clangd support it)
  enable_semantic_tokens(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local clangd_cfg = {
  name = "clangd",
  cmd = { "clangd" },  -- change path if needed
  on_attach = on_attach,
  capabilities = capabilities,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local active = vim.lsp.get_clients({ name = "clangd", bufnr = bufnr })
    if #active == 0 then
      vim.lsp.start(clangd_cfg)
    end
  end,
})

