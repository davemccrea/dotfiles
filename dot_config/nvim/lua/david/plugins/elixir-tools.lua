return {
	"elixir-tools/elixir-tools.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local elixir = require("elixir")

		elixir.setup({
			elixirls = {
				enable = true,
			},
			nextls = {
				enable = false,
				init_options = {
					experimental = {
						completions = {
							enable = false,
						},
					},
				},
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
