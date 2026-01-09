-- ~/.config/nvim/lua/config/highlights.lua

-- Optional: built-in colorscheme (or keep whatever you use)
-- pcall(vim.cmd.colorscheme, "habamax")

local function set_type_highlights()
  vim.api.nvim_set_hl(0, "@lsp.type.type",          { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.typeParameter", { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.class",         { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.struct",        { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.enum",          { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.typeParameter.cpp", { bold = true, italic = true })
  vim.api.nvim_set_hl(0, "@lsp.type.typeParameter.c",   { bold = true, italic = true })
end

-- >>> ADD THIS BLOCK <<<
local function set_oled_background()
  -- Make background transparent so terminal’s own bg shows through
  local groups = {
    "Normal",
    "NormalNC",
    "SignColumn",
    "LineNr",
    "FoldColumn",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "TabLineSel",
    "CursorLine",
    "CursorLineNr",
    "VertSplit",
    "NormalFloat",
    "FloatBorder",
    "Pmenu",
    "PmenuSel",
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end
-- <<< END BLOCK >>>

set_type_highlights()
set_oled_background()

-- Reapply when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("c-types-semantic-highlights", { clear = true }),
  callback = function()
    set_type_highlights()
    set_oled_background()
  end,
})

