return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		close_if_last_window = true,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,

		filesystem = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
			hijack_netrw_behavior = "open_current",
			use_libuv_file_watcher = true,
			bind_to_cwd = true,

			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_by_name = {
					"node_modules",
					".git",
					".DS_Store",
				},
			},
		},

		window = {
			position = "left",
			width = 35,
		},
	},
	keys = {
		{
			"<leader>e",
			"<cmd>Neotree toggle reveal_force_cwd<cr>",
			desc = "Toggle Neo-tree (cwd)",
		},
		{
			"<leader>E",
			"<cmd>Neotree toggle<cr>",
			desc = "Toggle Neo-tree (root)",
		},
	},
}
