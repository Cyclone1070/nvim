return {
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
	config = function(_, opts)
		require("luasnip").setup(opts)

		local s = require("luasnip").snippet
		local t = require("luasnip").text_node
		local i = require("luasnip").insert_node
		local f = require("luasnip").function_node

		local function get_component_name()
			local filename = vim.fn.expand("%:t:r")
			-- For index.js/ts, use the parent directory name
			if filename == "index" then
				filename = vim.fn.expand("%:p:h:t")
			end
			-- Convert kebab-case and snake_case to PascalCase
			filename = filename:gsub("[-_](%w)", string.upper)
			return filename:gsub("^%l", string.upper)
		end

		require("luasnip").add_snippets("typescriptreact", {
			s("fc", {
				t({ "interface Props {", "\t" }),
				t({"classsName?: string;"}),
				i(1),
				t({ "", "}", "", "export function " }),
				f(get_component_name, {}),
				t({ "({ ...props }: Props) {", "\treturn (", "\t\t" }),
				i(0),
				t({ "", "\t);", "}" }),
			}),
		})
		require("luasnip").add_snippets("javascriptreact", {
			s("fc", {
				t("export function "),
				f(get_component_name, {}),
				t({ "({ ...props }) {", "\treturn (", "\t\t" }),
				i(0),
				t({ "", "\t);", "}" }),
			}),
		})
	end,
}
