return {
	"echasnovski/mini.notify",
	config = function()
		require("mini.notify").setup()
		vim.keymap.set("n", "<leader>n", require("mini.notify").clear, { desc = "Clear [N]otification" })
	end,
}
