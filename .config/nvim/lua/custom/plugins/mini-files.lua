vim.pack.add { 'https://github.com/echasnovski/mini.files' }

require('mini.files').setup()

vim.keymap.set('n', '<leader>e', function()
  local buf_path = vim.api.nvim_buf_get_name(0)
  local path = buf_path ~= '' and buf_path or vim.uv.cwd()
  require('mini.files').open(path)
end, { desc = 'mini.files: [E]xplorer' })
