-- ~/.config/nvim/lua/config/harpoon.lua
-- Minimal Harpoon-like system, plugin-free

local harpoon = {
  files = {},
  max = 9,
}

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

function harpoon.menu()
  if #harpoon.files == 0 then
    print("No files marked")
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, harpoon.files)

  local width = 60
  local height = #harpoon.files + 2
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
    if file then
      vim.cmd("edit " .. file)
    end
    vim.api.nvim_win_close(0, true)
  end, { buffer = buf })
end

function harpoon.goto(n)
  local file = harpoon.files[n]
  if file then
    vim.cmd("edit " .. file)
  else
    print("No file in slot " .. n)
  end
end

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>H", harpoon.add,  { desc = "Harpoon add file" })
map("n", "<leader>h", harpoon.menu, { desc = "Harpoon menu" })

for i = 1, 9 do
  map("n", "<leader>" .. i, function()
    harpoon.goto(i)
  end, { desc = "Harpoon goto file " .. i })
end

return harpoon

