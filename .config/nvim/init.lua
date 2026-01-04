-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true

-- Options
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Open file explorer (netrw)" })
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- LSP
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")
-- Ctrl-Space to trigger LSP completion (built-in omnifunc)
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { desc = "Trigger completion" })

-- ===== Native LSP: clangd (no lspconfig) =====
local on_attach = function(_, bufnr)
  local map = function(lhs, rhs, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  -- LSP nav/actions
  map("gd", vim.lsp.buf.definition,         "Goto Definition")
  map("gr", vim.lsp.buf.references,         "References")
  map("gI", vim.lsp.buf.implementation,     "Goto Implementation")
  map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
  map("<leader>rn", vim.lsp.buf.rename,     "Rename")
  map("<leader>ca", vim.lsp.buf.code_action,"Code Action", { "n", "x" })
  map("gD", vim.lsp.buf.declaration,        "Goto Declaration")

  -- enables built-in LSP completion
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
    map("<leader>th", function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    end, "Toggle Inlay Hints")
  end
end

local clangd_cfg = {
  name = "clangd",
  cmd = { "clangd" },  -- change to "/usr/bin/clangd-18" if needed
  on_attach = on_attach,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  -- optional flags:
  -- cmd = { "clangd", "--background-index", "--pch-storage=memory" },
}

-- start clangd automatically for C/C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if #vim.lsp.get_clients({ name = "clangd", bufnr = bufnr }) == 0 then
      vim.lsp.start(clangd_cfg)
    end
  end,
})


-- Basic keymaps (plugin-free)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "move focus left" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "move focus right" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "move focus down" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "move focus up" })

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { desc = "next tab" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { desc = "prev tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "close tab" })
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "open new tab" })

-- Indent with Tab / Shift-Tab (normal + visual)
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Tab>", ">>_", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", "<<_", { noremap = true, silent = true })

-- Move selected lines (visual)
vim.api.nvim_set_keymap("v", "<S-J>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-K>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight when yanking",
  group = vim.api.nvim_create_augroup("minimal-highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

----------------------------------------------------------------------
-- =================== Native LSP: clangd only =======================
----------------------------------------------------------------------

local on_attach = function(_, bufnr)
  local map = function(lhs, rhs, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  map("gd", vim.lsp.buf.definition,         "Goto Definition")
  map("gr", vim.lsp.buf.references,         "References")
  map("gI", vim.lsp.buf.implementation,     "Goto Implementation")
  map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
  map("<leader>rn", vim.lsp.buf.rename,     "Rename")
  map("<leader>ca", vim.lsp.buf.code_action,"Code Action", { "n", "x" })
  map("gD", vim.lsp.buf.declaration,        "Goto Declaration")
  if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
    map("<leader>th", function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    end, "Toggle Inlay Hints")
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Plain config table (compatible with 0.10/0.11)
local clangd_cfg = {
  name = "clangd",
  cmd = { "clangd" },  -- change to "/usr/bin/clangd-18" if needed
  on_attach = on_attach,
  capabilities = capabilities,
  -- you may add flags:
  -- cmd = { "clangd", "--background-index", "--pch-storage=memory" },
}

-- Start clangd when editing C/C++ buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    -- Don't start twice
    local bufnr = vim.api.nvim_get_current_buf()
    local active = vim.lsp.get_clients({ name = "clangd", bufnr = bufnr })
    if #active == 0 then
      vim.lsp.start(clangd_cfg)
    end
  end,
})

----------------------------------------------------------------------
-- =================== Formatting (LSP/clang-format) =================
----------------------------------------------------------------------

-- <leader>f = format buffer (prefer LSP; fallback to clang-format)
vim.keymap.set("n", "<leader>f", function()
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

-- Theme
-- ===== GitHub Dark Theme =====
pcall(function()
  require("github-theme").setup({
    options = {
      transparent = false, -- set to true if you want terminal background to show through
      styles = {
        comments = "italic",
        keywords = "bold",
        functions = "italic,bold",
        variables = "NONE",
      },
    },
    groups = {
      all = {
        NormalFloat = { bg = "bg2" },
        Pmenu = { bg = "bg2" },
      },
    },
  })
  vim.cmd("colorscheme github_dark_high_contrast") -- or github_dark / github_dimmed / github_light
end)

-- Tmux Nav
vim.g.tmux_navigator_no_mappings = 1

local opts = { silent = true, noremap = true }

-- Normal mode
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", opts)
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", opts)
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", opts)
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", opts)
vim.keymap.set("n", "<C-\\>", "<Cmd>TmuxNavigatePrevious<CR>", opts)

-- ============ Minimal Harpoon-like system ============
local harpoon = { files = {}, max = 9 }

-- Add current file to the list
function harpoon.add()
  local file = vim.fn.expand("%:p")
  if file == "" then
    print("No file open")
    return
  end
  for _, f in ipairs(harpoon.files) do
    if f == file then
      print("Already in list")
      return
    end
  end
  if #harpoon.files < harpoon.max then
    table.insert(harpoon.files, file)
    print("Added: " .. file)
  else
    print("List full (max " .. harpoon.max .. ")")
  end
end

-- Show list in a simple floating window
function harpoon.menu()
  if #harpoon.files == 0 then
    print("No files marked")
    return
  end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, harpoon.files)
  local width, height = 60, #harpoon.files + 2
  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = 2,
    col = math.floor((vim.o.columns - width) / 2),
    border = "rounded",
  }
  vim.api.nvim_open_win(buf, true, opts)
  vim.keymap.set("n", "<CR>", function()
    local line = vim.fn.line(".")
    local file = harpoon.files[line]
    if file then vim.cmd("edit " .. file) end
    vim.api.nvim_win_close(0, true)
  end, { buffer = buf })
end

-- Jump directly to a file slot (1–9)
function harpoon.goto(n)
  local file = harpoon.files[n]
  if file then vim.cmd("edit " .. file) else print("No file in slot " .. n) end
end

-- Keymaps
vim.keymap.set("n", "<leader>H", harpoon.add, { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>h", harpoon.menu, { desc = "Harpoon menu" })

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, function() harpoon.goto(i) end,
    { desc = "Harpoon goto file " .. i })
end

