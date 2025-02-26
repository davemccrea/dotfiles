-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "david.plugins.core", enabled = true },
		{ import = "david.plugins.elixir-tools", enabled = true },
		{ import = "david.plugins.trouble", enabled = true },
		{ import = "david.plugins.lazygit", enabled = true },
		{ import = "david.plugins.bufferbrowser", enabled = true },
	},
})
