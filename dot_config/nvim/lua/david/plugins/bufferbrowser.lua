return {
	"https://git.sr.ht/~marcc/BufferBrowser",
	config = function()
		require("buffer_browser").setup()

		vim.keymap.set("n", "<M-k>", require("buffer_browser").next, { desc = "Next [B]uffer []]" })
		vim.keymap.set("n", "<M-j>", require("buffer_browser").prev, { desc = "Previous [B]uffer [[]" })
	end,
}
