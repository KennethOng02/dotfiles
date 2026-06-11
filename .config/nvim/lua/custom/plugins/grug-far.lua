vim.pack.add { 'https://github.com/MagicDuck/grug-far.nvim' }
require('grug-far').setup {}

vim.keymap.set('n', '<leader>sG', function()
  require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } }
end, { desc = '[S]earch [G]rep with filters (grug-far)' })

vim.keymap.set('v', '<leader>sG', function()
  require('grug-far').with_visual_selection {}
end, { desc = '[S]earch [G]rep selection (grug-far)' })
