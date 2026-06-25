local ensure_installed = { "bash", "c", "diff", "eex", "elixir", "heex", "html", "lua", "luadoc", "markdown", "markdown_inline", "vim", "vimdoc" }

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter.install").prefer_git = true
        require("nvim-treesitter").setup()
        require("nvim-treesitter").install(ensure_installed)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                if vim.bo[args.buf].filetype == "ruby" then
                    return
                end

                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
