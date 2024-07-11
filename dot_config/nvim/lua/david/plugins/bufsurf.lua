return {
	"ton/vim-bufsurf",
	config = function()
		-- Disable warning messages
		vim.g.BufSurfMessages = 0

		vim.keymap.set("n", "<C-k>", "<Plug>(buf-surf-forward)", { desc = "Buffer surf forward" })
		vim.keymap.set("n", "<C-j>", "<Plug>(buf-surf-back)", { desc = "Buffer surf back" })
	end,
}
