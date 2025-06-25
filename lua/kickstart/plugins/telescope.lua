return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- file browser config instance
		local fb_action = require("telescope").extensions.file_browser.actions
		-- -- Uncomment to handle winborder setting

		-- vim.api.nvim_create_autocmd("User", {
		-- 	pattern = "TelescopeFindPre",
		-- 	callback = function()
		-- 		vim.opt_local.winborder = "none"
		-- 		vim.api.nvim_create_autocmd("WinLeave", {
		-- 			once = true,
		-- 			callback = function()
		-- 				vim.opt_local.winborder = "rounded"
		-- 			end,
		-- 		})
		-- 	end,
		-- })

		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use Telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of `help_tags` options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			defaults = {
				layout_config = {
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
				mappings = {
					n = {
						["q"] = require("telescope.actions").close,
						["l"] = require("telescope.actions").select_default,
						["J"] = require("telescope.actions").toggle_selection
							+ require("telescope.actions").move_selection_next,
						["K"] = require("telescope.actions").toggle_selection
							+ require("telescope.actions").move_selection_previous,
						["i"] = function(prompt_bufnr)
							-- First, clear all text in the prompt buffer
							vim.api.nvim_buf_set_lines(prompt_bufnr, 0, -1, false, { "" })
							-- Then, enter insert mode
							vim.cmd.startinsert()
						end,
					},
					i = {
						["<C-j>"] = require("telescope.actions").toggle_selection
							+ require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").toggle_selection
							+ require("telescope.actions").move_selection_previous,
					},
				},
			},
			pickers = {
				help_tags = {
					mappings = {
						i = {
							["<CR>"] = require("telescope.actions").select_vertical,
						},
					},
				},
			},
			extensions = {
				file_browser = {
					display_stat = { date = true, size = true },
					hide_parent_dir = true,
					grouped = true,
					auto_depth = 50,
					mappings = {
						["n"] = {
							["h"] = fb_action.goto_parent_dir,
							["H"] = fb_action.toggle_hidden,
						},
						["i"] = {
							["C-h"] = fb_action.goto_parent_dir,
							["C-H"] = fb_action.toggle_hidden,
						},
					},
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "file_browser")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set(
			"n",
			"<leader><leader>",
			require("telescope").extensions.file_browser.file_browser,
			{ desc = "[S]earch [F]iles" }
		)
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

		-- Slightly advanced example of overriding default behavior and theme
		-- vim.keymap.set("n", "<leader>/", function()
		-- 	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
		-- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		-- 		winblend = 10,
		-- 		previewer = false,
		-- 	}))
		-- end, { desc = "[/] Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			require("telescope").extensions.file_browser.file_browser({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
