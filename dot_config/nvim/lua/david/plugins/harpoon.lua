return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<m-a>", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<m-h>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<m-j>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<m-k>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<m-l>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<m-p>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<m-n>", function()
			harpoon:list():next()
		end)
	end,
}
