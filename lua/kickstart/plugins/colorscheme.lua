return {
	{
		"echasnovski/mini.hues",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
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
			hues.setup(base_colors)
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
