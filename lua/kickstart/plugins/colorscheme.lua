return {
	{
		"echasnovski/mini.hues",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			function _G.load_random_hues()
				local hues = require("mini.hues")

				-- Use os.time() for broader compatibility during early startup
				math.randomseed(os.time())

				-- Define the custom function to generate hues, avoiding pinks and reds
				local function generate_allowed_hue()
					-- Define the hue range to ALLOW (inclusive)
					-- This excludes reds (0-15) and pinks/pink-reds (310-359)
					local min_allowed_hue = 16 -- Start after red, in orange territory
					local max_allowed_hue = 309 -- Stop before pink/magenta territory

					-- Directly generate a random hue within the allowed range
					local hue = math.random(min_allowed_hue, max_allowed_hue)

					-- Return the allowed hue
					return hue
				end

				-- Generate the base colors using our custom hue generator
				local base_colors = hues.gen_random_base_colors({
					gen_hue = generate_allowed_hue,
				})

				-- Setup mini.hues with the generated colors.
				hues.setup({
					background = base_colors.background,
					foreground = base_colors.foreground,
				})
				-- Set additional highlights
				-- constructing line number highlight style by combining fg with bg of cursorline
				local line_nr_bg = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false }).bg
				-- constructing tabline colors to keep their default and only append bg
				local tabline_current = vim.api.nvim_get_hl(0, { name = "MiniTablineCurrent", link = false })
				tabline_current.bg = vim.api.nvim_get_hl(0, { name = "Visual", link = false }).bg
				local tabline_hidden = vim.api.nvim_get_hl(0, { name = "MiniTablineHidden", link = false })
				tabline_hidden.bg = line_nr_bg
				local tabline_trunc = vim.api.nvim_get_hl(0, { name = "MiniTablineTrunc", link = false })
				tabline_trunc.bg = line_nr_bg

				-- Set the entire left column to new style
				vim.api.nvim_set_hl(0, "LineNr", { fg = "#788a8a", bg = line_nr_bg })
				vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#bbbbbb", bg = line_nr_bg })
				vim.api.nvim_set_hl(0, "SignColumn", { fg = "#788a8a", bg = line_nr_bg })
				vim.api.nvim_set_hl(0, "CursorLineSign", { fg = "#788a8a", bg = line_nr_bg })
				-- Set minitabline color
				vim.api.nvim_set_hl(0, "MiniTablineCurrent", tabline_current)
				vim.api.nvim_set_hl(0, "MiniTablineVisible", { link = "MiniTablineHidden" })
				vim.api.nvim_set_hl(0, "MiniTablineHidden", tabline_hidden)
				vim.api.nvim_set_hl(0, "MiniTablineTrunc", tabline_trunc)
				-- Keywords highlight
				vim.api.nvim_set_hl(0, "Statement", { fg = "#E1914C" })
			end
			_G.load_random_hues()
		end,
	},
}
-- return {
-- 	{ -- You can easily change to a different colorscheme.
-- 		-- Change the name of the colorscheme plugin below, and then
-- 		-- change the command in the config to whatever the name of that colorscheme is.
-- 		--
-- 		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
-- 		"echasnovski/mini.hues",
-- 		priority = 1000, -- Make sure to load this before all the other start plugins.
-- 		config = function()
-- 			-- ---@diagnostic disable-next-line: missing-fields
-- 			-- require("mini.hues").setup({ background = "#2c2101", foreground = "#c9c6c0" }) -- yellow
-- 			--
-- 			-- Load the colorscheme here.
-- 			-- Like many other themes, this one has different styles, and you could load
-- 			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
-- 			vim.cmd.colorscheme("randomhue")
-- 		end,
-- 	},
-- }
