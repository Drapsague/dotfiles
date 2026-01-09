-- Minimal GitHub Dark colorscheme for Neovim (plugin-free)
-- Save this file to ~/.config/nvim/colors/github_dark_minimal.lua

local colors = {
  bg       = "#0d1117",
  fg       = "#c9d1d9",
  red      = "#ff7b72",
  orange   = "#ffa657",
  yellow   = "#d29922",
  green    = "#3fb950",
  cyan     = "#39c5cf",
  blue     = "#58a6ff",
  purple   = "#bc8cff",
  comment  = "#8b949e",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Clear existing highlighting
vim.cmd('highlight clear')
vim.cmd('syntax reset')
vim.o.background = "dark"

-- Core groups
hi('Normal',    { fg = colors.fg, bg = colors.bg })
hi('LineNr',    { fg = colors.comment, bg = colors.bg })
hi('CursorLineNr', { fg = colors.yellow, bold = true })
hi('Comment',   { fg = colors.comment, italic = true })
hi('Constant',  { fg = colors.orange })
hi('String',    { fg = colors.green })
hi('Identifier',{ fg = colors.blue })
hi('Function',  { fg = colors.blue, bold = true })
hi('Statement', { fg = colors.purple })
hi('Type',      { fg = colors.yellow })
hi('Special',   { fg = colors.cyan })
hi('Underlined',{ fg = colors.cyan, underline = true })
hi('Todo',      { fg = colors.red, bold = true })

-- UI
hi('StatusLine',    { fg = colors.fg, bg = colors.bg })
hi('VertSplit',     { fg = colors.comment, bg = colors.bg })
hi('Visual',        { bg = "#21262d" })
hi('Search',        { bg = colors.yellow, fg = colors.bg, bold = true })
hi('Pmenu',         { fg = colors.fg, bg = "#161b22" })
hi('PmenuSel',      { fg = colors.bg, bg = colors.blue })
hi('CursorLine',    { bg = "#161b22" })
hi('ColorColumn',   { bg = "#21262d" })

-- Diffs
hi('DiffAdd',       { bg = "#163d25" })
hi('DiffChange',    { bg = "#122f4a" })
hi('DiffDelete',    { bg = "#331e1e" })
hi('DiffText',      { bg = "#163d25", bold = true })

-- Diagnostics (minimal)
hi('Error',    { fg = colors.red, bold = true })
hi('Warning',  { fg = colors.yellow, bold = true })
hi('Info',     { fg = colors.blue })
hi('Hint',     { fg = colors.cyan })

-- End
