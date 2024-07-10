return {
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
		},
		config = function()
			require("auto-session").setup({
				auto_session_suppress_dirs = { "~/", "~/Projects", "/" },
				config = function()
					vim.o.sessionoptions =
						"blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
				end,
			})
		end,
	},
}
