return {
  "folke/snacks.nvim",
  opts = {
    notifier = { enabled = true },

    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { "node_modules", ".git" },
        },
      },
    },
  },
}
