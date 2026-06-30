vim.keymap.set('n', '<leader>R', function()
  for k in pairs(package.loaded) do
    if k:match '^kickstart' or k:match '^custom' then
      package.loaded[k] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify 'Config reloaded'
end, { desc = '[R]eload config' })
