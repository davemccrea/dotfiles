vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "[Q]uit buffer" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite buffer" })
