-- ~/.config/nvim/lua/config/neovide.lua

if vim.g.neovide then
	-- GUI Font
	local guifont = "FiraCode Nerd Font"
	local fontsize = 12
	vim.o.guifont = string.format("%s:h%d", guifont, fontsize)

	-- Font size adjustment
	function _G.AdjustFontSize(amount)
		fontsize = fontsize + amount
		if fontsize < 6 then
			fontsize = 6
		end
		vim.o.guifont = string.format("%s:h%d", guifont, fontsize)
	end

	-- Keymaps: Font size control
	vim.keymap.set("n", "<C-1>", function()
		_G.AdjustFontSize(1)
	end, { desc = "Increase font size" })
	vim.keymap.set("n", "<C-2>", function()
		_G.AdjustFontSize(-1)
	end, { desc = "Decrease font size" })
	vim.keymap.set("n", "<C-0>", function()
		fontsize = 12
		set_guifont()
	end, { desc = "Reset font size" })

	-- Dark/Light Mode Toggle
	local is_dark_mode = true
	local function toggle_dark_light_mode()
		is_dark_mode = not is_dark_mode
		if is_dark_mode then
			vim.g.neovide_background_color = "#0f1117" -- Dark background for night
			vim.g.neovide_opacity = 0.8
			vim.cmd([[colorscheme tokyonight-night]])
		else
			vim.g.neovide_background_color = "#d8d8d8" -- Soft light gray for moon
			vim.g.neovide_opacity = 0.8
			vim.cmd([[colorscheme tokyonight-moon]])
		end
		-- Ensure transparency for all modes
		vim.cmd([[
      highlight Normal guibg=none
      highlight NonText guibg=none
      highlight NormalFloat guibg=none
    ]])
	end

	-- Keymap: Toggle dark/light mode
	vim.keymap.set("n", "<leader>tm", toggle_dark_light_mode, { desc = "Toggle dark/light mode" })

	-- General Window Settings
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_remember_window_position = true
	vim.g.neovide_fullscreen = false

	-- Performance
	vim.g.neovide_refresh_rate = 75
	vim.g.neovide_refresh_rate_idle = 10
	vim.g.neovide_no_idle = false
	vim.g.neovide_confirm_quit = true

	-- Cursor Effects (Improved)
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
	vim.g.neovide_cursor_animation_length = 0.1
	vim.g.neovide_cursor_trail_size = 0.7
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
	vim.g.neovide_cursor_vfx_particle_density = 15.0
	vim.g.neovide_cursor_vfx_particle_speed = 12.0
	vim.g.neovide_cursor_vfx_particle_phase = 1.2
	vim.g.neovide_cursor_vfx_particle_curl = 0.8

	-- Opacity & Blur
	vim.g.neovide_opacity = 0.8
	vim.g.neovide_background_color = "#0f1117"
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	-- Scrolling
	vim.g.neovide_scroll_animation_length = 0.25
	vim.g.neovide_scroll_animation_far_lines = 1
	vim.g.neovide_hide_mouse_when_typing = true

	-- Undercurl for Diagnostics
	vim.g.neovide_underline_automatic_scaling = true

	-- Clipboard Integration
	vim.g.neovide_input_use_logo = true
	vim.opt.clipboard:append("unnamedplus")

	-- Touch Settings
	vim.g.neovide_touch_deadzone = 6.0
	vim.g.neovide_touch_drag_timeout = 0.17
	-- Padding
	vim.g.neovide_padding_top = 10
	vim.g.neovide_padding_bottom = 10
	vim.g.neovide_padding_left = 10
	vim.g.neovide_padding_right = 10
end

-- UI Enhancements
vim.cmd([[
  colorscheme tokyonight
  set termguicolors
  set number
  set relativenumber
  set cursorline
]])
