return { -- You can easily change to a different colorscheme.
	-- Change the name of the colorscheme plugin below, and then
	-- change the command in the config to whatever the name of that colorscheme is.
	--
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	"echasnovski/mini.base16",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("mini.base16").setup({
			palette = require("mini.base16").mini_palette("#0A2A2A", "#D0D0D0", 50),
		})

		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme("minicyan")
	end,
}
