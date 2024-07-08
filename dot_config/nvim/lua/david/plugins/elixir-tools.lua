return {
	"elixir-tools/elixir-tools.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local elixir = require("elixir")

		elixir.setup({
			nextls = {
				enable = true,
				init_options = {
					experimental = {
						completions = {
							enable = false,
						},
					},
				},
				on_attach = function(client, bufnr)
					-- custom keybinds
				end,
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
