return {
	"echasnovski/mini.comment",
	config = function()
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
	end,
}
