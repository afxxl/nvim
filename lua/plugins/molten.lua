return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		lazy = false,
		build = ":UpdateRemotePlugins",
		init = function()
			-- 1. Force the Python sandbox path
			vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim-ds/bin/python")

			-- 2. FORCE the engine to load, bypassing the distro's speed hacks
			vim.cmd("source $VIMRUNTIME/plugin/rplugin.vim")

			-- 3. Standard config
			vim.g.molten_image_provider = "none"
			vim.g.molten_output_win_max_height = 20
		end,

		config = function()
			vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
			vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", { desc = "Evaluate Line", silent = true })
			vim.keymap.set(
				"v",
				"<leader>mv",
				":<C-u>MoltenEvaluateVisual<CR>v",
				{ desc = "Evaluate Visual", silent = true }
			)
			vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Delete Output", silent = true })
		end,
	},
}
