-- :help options
local options = {
  autochdir = true,
  autoindent = true,
  background = "dark",
  backup = false,
  clipboard = "unnamedplus",
  cursorline = true,
  expandtab = true,		        -- convert tabs to spaces
  fileencoding = "utf-8",
  ignorecase = true,
  mouse = "a",
  number = true,
  scrolloff = 8,
  shiftwidth = 2,			-- default: 8, num of spaces used for (auto)indent
  sidescrolloff = 8,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  showtabline = 2,
  syntax = "on",
  termguicolors = true,
  undofile = true,
  wrap = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
