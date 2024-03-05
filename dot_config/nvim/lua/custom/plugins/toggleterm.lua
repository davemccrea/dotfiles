return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				shell = vim.o.shell,
				direction = "float",
			})
		end,
	},
}
