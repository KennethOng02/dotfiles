vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

require('render-markdown').setup()

vim.keymap.set('n', '<leader>mt', function()
  require('render-markdown').toggle()
end, { desc = '[m]arkdown [t]oggle' })

