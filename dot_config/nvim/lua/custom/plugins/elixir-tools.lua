return {
  'elixir-tools/elixir-tools.nvim',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('elixir').setup {
      nextls = {
        enable = true,
        init_options = {
          experimental = {
            completions = {
              enable = true,
            },
          },
        },
      },
      credo = { enable = false },
      elixirls = { enable = false },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
