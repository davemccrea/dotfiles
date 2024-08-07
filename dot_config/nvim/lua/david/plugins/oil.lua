return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},
		})

		-- Open parent directory in floating window
		vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Open Oil in floating window" })
	end,
}
