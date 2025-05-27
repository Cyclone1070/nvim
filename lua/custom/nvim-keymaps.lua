local map = vim.keymap.set
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
	vim.keymap.set("n", "<D-v>", '"+p') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+p') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>"+pli') -- Paste insert mode
	-- Macos option key for meta
	vim.g.neovide_input_macos_option_key_is_meta = "only_left"
	-- Map move lines
	map("n", "<M-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
	map("n", "<M-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
	map("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
	map("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
	map("v", "<M-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
	map("v", "<M-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
end
-- aditional keymaps here

-- enter command mode with ;
map("n", ";", ":", opts)
map("v", ";", ":", opts)
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
-- move current window around
vim.keymap.set("n", "<C-w>h", "<C-w>H", { desc = "Move window left" })
vim.keymap.set("n", "<C-w>j", "<C-w>J", { desc = "Move window down" })
vim.keymap.set("n", "<C-w>k", "<C-w>K", { desc = "Move window up" })
vim.keymap.set("n", "<C-w>l", "<C-w>L", { desc = "Move window right" })
vim.keymap.set("n", "<C-w><CR>", "<C-w>_<C-w>|", { desc = "Maximize window" })
-- Remap to moving based on visual lines
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
-- Quick move cursors
map("n", "J", "5gj", opts)
map("n", "K", "5gk", opts)
map("v", "J", "5gj", opts)
map("v", "K", "5gk", opts)
-- C-J and C-K to merge lines
map("n", "<C-j>", "J", opts)
map("n", "<C-k>", "K", opts)
-- Keep Visual mode active after indent/unindent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- Map line moves
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
