return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
	},

	-- Add this config section for better integration
	config = function()
		-- Floating window settings
		vim.g.lazygit_floating_window_winblend = 0 -- No transparency for better readability
		vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 90% of screen size
		vim.g.lazygit_floating_window_use_plenary = 1 -- Use plenary for better window management

		-- Border style (rounded corners)
		vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

		-- Use neovim remote for editing files from lazygit
		vim.g.lazygit_use_neovim_remote = 1
	end,
}
