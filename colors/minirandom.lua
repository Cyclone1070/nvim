-- this file is just for calling definitions in colorscheme.lua
if _G.load_random_hues then
	_G.load_random_hues()
else
	print("Error, function _G.load_random_hues from lua/kickstart/plugins/colorscheme.lua not found")
end
