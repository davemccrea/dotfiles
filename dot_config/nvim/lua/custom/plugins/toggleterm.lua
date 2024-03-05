return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        direction = 'float',
      }

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }

      function Lazygit_toggle()
        lazygit:toggle()
      end

      vim.keymap.set('n', '<leader>g', '<cmd>lua Lazygit_toggle()<CR>', { desc = 'Open Lazy[G]it in a floating terminal', noremap = true, silent = true })
    end,
  },
}
