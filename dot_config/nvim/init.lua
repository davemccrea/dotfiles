require("config.options")
require("config.keymaps")
require("config.autocmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    rocks = { enabled = false },
    -- write updates straight into the chezmoi source so the tracked lockfile never goes stale
    lockfile = vim.fn.expand("~/.local/share/chezmoi/dot_config/nvim/lazy-lock.json"),
})
