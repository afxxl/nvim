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
		vim.o.guifont = string.format("%s:h%d", guifont, fontsize)
	end, { desc = "Reset font size" })

	-- Dark/Light Mode Toggle
	local is_dark_mode = true
	local function toggle_dark_light_mode()
		is_dark_mode = not is_dark_mode
		if is_dark_mode then
			vim.g.neovide_background_color = "#0f1117"
			vim.g.neovide_transparency = 0.85
			vim.cmd([[colorscheme tokyonight-night]])
		else
			vim.g.neovide_background_color = "#d8d8d8"
			vim.g.neovide_transparency = 0.85
			vim.cmd([[colorscheme tokyonight-moon]])
		end
		-- Ensure transparency
		vim.cmd([[
      highlight Normal guibg=none
      highlight NonText guibg=none
      highlight NormalFloat guibg=none
    ]])
	end

	vim.keymap.set("n", "<leader>tm", toggle_dark_light_mode, { desc = "Toggle dark/light mode" })

	-- ═══════════════════════════════════════════════════════════
	-- PERFORMANCE OPTIMIZATIONS FOR LOW-END DEVICES
	-- ═══════════════════════════════════════════════════════════

	-- General Window Settings
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_remember_window_position = true
	vim.g.neovide_fullscreen = false

	-- Performance: Lower refresh rates save CPU/GPU
	vim.g.neovide_refresh_rate = 60 -- Lower from 75 for better performance
	vim.g.neovide_refresh_rate_idle = 5 -- Minimal refresh when idle
	vim.g.neovide_no_idle = false -- Allow idle mode for performance
	vim.g.neovide_confirm_quit = true

	-- ═══════════════════════════════════════════════════════════
	-- OPTIMIZED CURSOR EFFECTS (Looks good but performant)
	-- ═══════════════════════════════════════════════════════════

	-- Use simpler cursor effect - "railgun" is fast and looks clean
	vim.g.neovide_cursor_vfx_mode = "railgun" -- Changed from "pixiedust" (heavy)

	-- Faster, snappier animations
	vim.g.neovide_cursor_animation_length = 0.06 -- Reduced from 0.1
	vim.g.neovide_cursor_trail_size = 0.5 -- Reduced from 0.7
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true

	-- Reduced particle count for better performance
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2 -- Reduced from 1.5
	vim.g.neovide_cursor_vfx_particle_density = 7.0 -- Halved from 15.0
	vim.g.neovide_cursor_vfx_particle_speed = 10.0 -- Reduced from 12.0
	vim.g.neovide_cursor_vfx_particle_phase = 1.5
	vim.g.neovide_cursor_vfx_particle_curl = 1.0

	-- ═══════════════════════════════════════════════════════════
	-- TRANSPARENCY & BLUR (Optimized)
	-- ═══════════════════════════════════════════════════════════

	vim.g.neovide_transparency = 0.85 -- Slightly less transparent = better readability
	vim.g.neovide_background_color = "#0f1117"

	-- Reduced blur for performance
	vim.g.neovide_floating_blur_amount_x = 1.0 -- Halved from 2.0
	vim.g.neovide_floating_blur_amount_y = 1.0 -- Halved from 2.0

	-- ═══════════════════════════════════════════════════════════
	-- OPTIMIZED SCROLLING (Faster animations)
	-- ═══════════════════════════════════════════════════════════

	vim.g.neovide_scroll_animation_length = 0.15 -- Reduced from 0.25
	vim.g.neovide_scroll_animation_far_lines = 1
	vim.g.neovide_hide_mouse_when_typing = true

	-- Position animation (window movements)
	vim.g.neovide_position_animation_length = 0.10 -- Faster window positioning

	-- ═══════════════════════════════════════════════════════════
	-- OTHER OPTIMIZATIONS
	-- ═══════════════════════════════════════════════════════════

	-- Undercurl for Diagnostics
	vim.g.neovide_underline_automatic_scaling = false -- Disable for performance

	-- Clipboard Integration
	vim.g.neovide_input_use_logo = true
	vim.opt.clipboard:append("unnamedplus")

	-- Touch Settings (if using touchscreen)
	vim.g.neovide_touch_deadzone = 6.0
	vim.g.neovide_touch_drag_timeout = 0.17

	-- Reduced padding for more screen space
	vim.g.neovide_padding_top = 5
	vim.g.neovide_padding_bottom = 5
	vim.g.neovide_padding_left = 5
	vim.g.neovide_padding_right = 5

	-- ═══════════════════════════════════════════════════════════
	-- VSYNC & FRAME PACING
	-- ═══════════════════════════════════════════════════════════

	-- Force vsync for smoother frame pacing
	vim.g.neovide_vsync = true
end

-- UI Enhancements
vim.cmd([[
  colorscheme tokyonight
  set termguicolors
  set number
  set relativenumber
  set cursorline
]])
