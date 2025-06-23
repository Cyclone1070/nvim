return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		cmd = "Copilot",
		opts = {
			suggestion = {
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<C-c>",
					accept_word = false, -- Disable accepting word suggestions
					accept_line = false, -- Disable accepting line suggestions
				},
			},
			panel = {
				auto_refresh = true,
			},
			filetypes = {
				["*"] = true, -- Enable Copilot for all file types
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		cmd = "CopilotChat",
		keys = {
			{
				"<leader>i",
				function()
					require("CopilotChat").toggle({
						model = "claude-3.7-sonnet-thought",
						context = { "files", "buffer:*" },
					})
				end,
				desc = "Toggle CopilotChat",
			},
		},
		opts = function()
			local user = vim.env.USER or "User"
			user = user:sub(1, 1):upper() .. user:sub(2)
			return {
				mappings = {
					submit_prompt = {
						insert = "<C-CR>",
						normal = "<CR>",
					},

					reset = {
						normal = "<C-i>",
						insert = "<C-i>",
					},
				},
				auto_insert_mode = true,
				question_header = "  " .. user .. " ",
				answer_header = "  Copilot ",
				window = {
					width = 0.4,
				},
			}
		end,
		config = function(_, opts)
			local chat = require("CopilotChat")

			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-chat",
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
				end,
			})

			chat.setup(opts)
		end,
	},
}
