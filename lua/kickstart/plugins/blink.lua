return { -- Autocompletion
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		"L3MON4D3/LuaSnip",
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
			["<C-l>"] = { "select_and_accept", "fallback" },
			["<Tab>"] = {
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = {
				"snippet_backward",
				"fallback",
			},
			["<Down>"] = {},
			["<Up>"] = {},
			["<C-c>"] = {
				function(cmp)
					if require("copilot.suggestion").is_visible() then
						require("copilot.suggestion").accept()
						return true
					end
					if not cmp.is_visible() then
						return
					end

					local accept_index = nil
					local selected_item = cmp.get_selected_item()

					for index, item in ipairs(cmp.get_items()) do
						if item.client_name == "emmet_ls" or item.source_id == "snippets" then
							accept_index = index
							break
						end
					end

					if selected_item then
						cmp.accept()
					elseif accept_index then
						cmp.accept({ index = accept_index })
					else
						cmp.accept({ index = 1 })
					end
					return true
				end,
			},
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
			ghost_text = {
				enabled = true,
				show_with_menu = true,
				show_without_selection = true,
				show_with_selection = false,
			},
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
		fuzzy = {
			implementation = "lua",
			sorts = {
				function(a, b)
					if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
						return
					end
					return b.client_name == "emmet_ls"
				end,
				-- default sorts
				"score",
				"sort_text",
			},
		},

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
