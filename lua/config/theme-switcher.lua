-- Auto-save colorscheme selection
local M = {}

-- File to store the selected theme
local theme_file = vim.fn.stdpath("config") .. "/last_colorscheme.txt"

-- Save current colorscheme
function M.save_colorscheme()
	local current = vim.g.colors_name
	if current then
		local file = io.open(theme_file, "w")
		if file then
			file:write(current)
			file:close()
			vim.notify("Theme saved: " .. current, vim.log.levels.INFO)
		end
	end
end

-- Load saved colorscheme
function M.load_colorscheme()
	local file = io.open(theme_file, "r")
	if file then
		local theme = file:read("*all")
		file:close()
		if theme and theme ~= "" then
			pcall(vim.cmd.colorscheme, theme)
		end
	end
end

return M
