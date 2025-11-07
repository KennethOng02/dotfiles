-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "jk", "<Esc>", opts)

keymap.set("n", "<leader>y", function()
  local filepath = vim.fn.expand("%:p")
  local root = vim.fn.getcwd() -- fallback if root detection fails

  -- Try Git root
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error == 0 and git_root ~= "" then
    root = git_root
  end

  -- Compute relative path
  local relpath = vim.fn.fnamemodify(filepath, ":." .. root)
  vim.fn.setreg("+", relpath)
end, opts)
