return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	key = {
		{ "s", mode = { "n", "c" }, "<Nop>" },
	},
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- delete useless s mapping for surround usage
		-- vim.keymap.set({ "n", "x" }, "s", "<Nop>")
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- tabline
		require("mini.tabline").setup()
		vim.keymap.set("n", "H", "<CMD>bNext<CR>")
		vim.keymap.set("n", "L", "<CMD>bnext<CR>")
		vim.keymap.set("n", "<leader>w", "<CMD>bd<CR>")
		if vim.g.neovide then
			vim.keymap.set("n", "<D-w>", "<CMD>bd<CR>")
		end

		-- comments
		require("mini.comment").setup({
			mappings = {
				-- Toggle comment (like `gcip` - comment inner paragraph) for both
				-- Normal and Visual modes
				comment = "",

				-- Toggle comment on current line
				comment_line = "<leader>c",

				-- Toggle comment on visual selection
				comment_visual = "<leader>c",

				-- Define 'comment' textobject (like `dgc` - delete whole comment block)
				-- Works also in Visual mode if mapping differs from `comment_visual`
				textobject = "<leader>c",
			},
		})
		-- Disable default 'gc' mapping for normal and visual modes
		vim.keymap.del({ "n", "x" }, "gc")
		vim.keymap.del("n", "gcc")
		vim.keymap.del("o", "gc")

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
