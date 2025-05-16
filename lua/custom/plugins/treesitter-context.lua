return {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = {
		"echasnovski/mini.nvim",
	},
	config = function()
		vim.keymap.set("n", "gc", function()
			require("treesitter-context").go_to_context(vim.v.count1)
		end, { silent = true, desc = "[G]o to [C]ontext" })
	end,
}
