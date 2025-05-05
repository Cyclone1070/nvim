local map = vim.keymap.set
local unmap = vim.keymap.del
local opts = { noremap = true }
-- [[ Kickstart Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- Neovide keymaps
if vim.g.neovide then
	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", "<C-R>+") -- Paste insert mode
end
-- aditional keymaps here

-- enter command mode with ;
map("n", ";", ":", opts)
-- remap escape to jk or kj
map("i", "jk", "<ESC>", opts)
map("i", "kj", "<ESC>", opts)
map("i", "JK", "<ESC>", opts)
map("i", "KJ", "<ESC>", opts)
-- remap v to exit visual mode
map("v", "v", "<ESC>")
-- only paste from yank register
map("n", "p", '"0p', opts)
map("n", "P", '"0P', opts)
-- diagnostics shortcut
map("n", "<leader>i", function()
	vim.diagnostic.open_float()
end, { desc = "Show diagnostic under cursor" })
-- noice.vim dismiss notification
map("n", "<leader>n", function()
	require("noice").cmd("dismiss")
end, { desc = "Dismiss All Notifications" })
-- remap go to end of line
map({ "n", "o" }, "E", "$", opts)
map("v", "E", "$", opts)
-- remap go to start of line
map({ "n", "o" }, "B", "^", opts)
map("v", "B", "^", opts)
-- Move cursor in insert mode
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
-- Remap to moving based on visual lines
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
-- Quick move cursors
map("n", "J", "5gj", opts)
map("n", "K", "5gk", opts)
map("v", "J", "5gj", opts)
map("v", "K", "5gk", opts)
-- Keep Visual mode active after indent/unindent
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
