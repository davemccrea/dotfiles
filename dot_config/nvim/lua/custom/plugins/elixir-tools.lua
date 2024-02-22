return {
  "elixir-tools/elixir-tools.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    elixir.setup {
      nextls = {
        enable = false,          -- defaults to false
      },
      credo = {
        enable = true,                         -- defaults to true
      },
      elixirls = {
        -- specify a repository and branch
        repo = "mhanberg/elixir-ls",         -- defaults to elixir-lsp/elixir-ls
        branch = "mh/all-workspace-symbols", -- defaults to nil, just checkouts out the default branch, mutually exclusive with the `tag` option
        tag = "v0.14.6",                     -- defaults to nil, mutually exclusive with the `branch` option

        -- default settings, use the `settings` function to override settings
        settings = elixirls.settings {
          dialyzerEnabled = true,
          fetchDeps = false,
          enableTestLenses = false,
          suggestSpecs = false,
        },
        on_attach = function(client, bufnr)
        end
      }
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
