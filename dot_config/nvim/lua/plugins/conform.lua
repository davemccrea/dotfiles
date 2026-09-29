return {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
        { "<leader>f", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, mode = "", desc = "[F]ormat buffer" },
    },
    opts = function()
        -- `mix format` takes over a second, so run it after the write instead of blocking it.
        local format_after_write = { elixir = true, eelixir = true, heex = true }

        return {
            notify_on_error = true,
            format_on_save = function(bufnr)
                local filetype = vim.bo[bufnr].filetype
                if format_after_write[filetype] then
                    return
                end
                local disable_filetypes = { c = true, cpp = true }
                return { timeout_ms = 500, lsp_format = disable_filetypes[filetype] and "never" or "fallback" }
            end,
            format_after_save = function(bufnr)
                if format_after_write[vim.bo[bufnr].filetype] then
                    return { lsp_format = "never" }
                end
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                elixir = { "mix" },
                eelixir = { "mix" },
                heex = { "mix" },
            },
        }
    end,
}
