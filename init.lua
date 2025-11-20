if vim.loader then
	vim.loader.enable()
end

vim.o.swapfile = false

require("config.lazy")

if vim.g.neovide then
	require("config.neovide")
end

-- Load saved theme
local theme_switcher = require("config.theme-switcher")
vim.defer_fn(function()
	theme_switcher.load_colorscheme()
end, 100)

-- Auto-save theme when changed
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		theme_switcher.save_colorscheme()
	end,
})
