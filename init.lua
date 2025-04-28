if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

-- Load Neovide GUI settings if Neovide is being used
if vim.g.neovide then
	require("config.neovide")
end
