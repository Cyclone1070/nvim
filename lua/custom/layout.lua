-- use tab indent and set tab width to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
-- set line wrap and break line at word end
vim.opt.wrap = true
vim.opt.linebreak = true

local myGlobalFormatOptionsGroup = vim.api.nvim_create_augroup("MyGlobalFormatOptions", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = myGlobalFormatOptionsGroup,
	pattern = "*",
	callback = function(args)
		if not args or not args.buf then
			return
		end

		local current_fo = vim.bo[args.buf].formatoptions

		if type(current_fo) ~= "string" then
			current_fo = ""
		end

		current_fo = string.gsub(current_fo, "r", "")
		current_fo = string.gsub(current_fo, "o", "")

		vim.bo[args.buf].formatoptions = current_fo
	end,
	desc = "Globally disable auto-continuation of comments on new lines for all filetypes",
})
