-- map some useful common commands from other editors
vim.keymap.set({ "i", "n", "v" }, "<C-s>", "<esc>:w<CR>", { desc = "Save File" })
vim.keymap.set({ "i", "n", "v" }, "<C-f>", "<esc>/", { desc = "Find in file" })
vim.keymap.set({ "i", "n", "v" }, "<C-r>", "<esc>:%s//gc<LEFT><LEFT><LEFT>", { desc = "Replace in file" })
vim.keymap.set({ "i", "n" }, "<C-q>", "<esc>:wq<CR>", { desc = "Save & exit" })
vim.keymap.set("i", "<C-z>", "<esc>:u<CR>i", { desc = "Undo" })
vim.keymap.set("n", "<C-z>", "<esc>:u<CR>", { desc = "Undo" })
vim.keymap.set("v", "<C-z>", "<esc>", { desc = "Undo" })

-- tabs
vim.keymap.set("n", "[b", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]b", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b1", "<Cmd>BufferGoto 1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b2", "<Cmd>BufferGoto 2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b3", "<Cmd>BufferGoto 3<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b4", "<Cmd>BufferGoto 4<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { noremap = true, silent = true })

-- Move around splits
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Down window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Up window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Right window" })

-- Reload configuration without restarting nvim
-- vim.keymap.set("n", "<leader>r", ":so %<CR>", { desc = "Reload source file" })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy file" })
vim.keymap.set("n", "<leader>fd", function()
	require("telescope.builtin").find_files({
		hidden = true,
		no_ignore = false,
		file_ignore_patterns = { ".git/", "^node_modules/" },
	})
end, { desc = "Fuzzy dotfiles" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Fuzzy grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy buffer" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Fuzzy help" })

-- NvimTree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", {}) -- open/close
vim.keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", {}) -- refresh
vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", {}) -- search file

-- Terminal
vim.keymap.set("n", "<leader>tt", ":NeotermToggle<CR>", {})
