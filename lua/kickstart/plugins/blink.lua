return { -- Autocompletion
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		-- Snippet Engine
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				-- {
				--   'rafamadriz/friendly-snippets',
				--   config = function()
				--     require('luasnip.loaders.from_vscode').lazy_load()
				--   end,
				-- },
			},
			opts = {},
		},
		"folke/lazydev.nvim",
	},
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			-- Override <C-k> with <C-r> to enable cursor navigation in insert mode
			["<C-r>"] = { "show_signature", "hide_signature", "fallback" },
			-- Tab to select next items, selected item is auto inserted
			preset = "none",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-h>"] = { "cancel", "fallback" },
			["<C-l>"] = { "accept", "fallback" },
			["<Tab>"] = {
				function(cmp)
					if not cmp.is_visible() then
						return
					end

					local keyword = require("blink.cmp.completion.list").context.get_keyword()
					local accept_index = nil

					for index, item in ipairs(cmp.get_items()) do
						if item.client_name == "emmet_ls" or item.source_id == "snippets" then
							print("accepted")
							accept_index = index
							break
						end
					end

					if accept_index then
						cmp.accept({ index = accept_index })
					else
						cmp.accept({ index = 1 })
					end
				end,
				"fallback",
			},
			["<Down>"] = {},
			["<Up>"] = {},
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		completion = {
			-- By default, you may press `<c-space>` to show the documentation.
			-- Optionally, set `auto_show = true` to show the documentation after a delay.
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			list = {
				selection = { preselect = false, auto_insert = true },
			},
			menu = {
				border = "rounded",
			},
			ghost_text = { enabled = true },
		},

		sources = {
			default = { "lsp", "path", "snippets", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
			},
		},

		snippets = { preset = "luasnip" },

		-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
		-- which automatically downloads a prebuilt binary when enabled.
		--
		-- By default, we use the Lua implementation instead, but you may enable
		-- the rust implementation via `'prefer_rust_with_warning'`
		--
		-- See :h blink-cmp-config-fuzzy for more information
		fuzzy = { implementation = "lua" },

		-- Shows a signature help window while you type arguments for a function
		-- signature = { enabled = true },
		-- cmdline
		cmdline = {
			completion = {
				menu = {
					auto_show = true,
				},
				list = {
					selection = { preselect = false, auto_insert = true },
				},
			},
			keymap = {
				preset = "super-tab",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Down>"] = {},
				["<Up>"] = {},
			},
		},
	},
}
