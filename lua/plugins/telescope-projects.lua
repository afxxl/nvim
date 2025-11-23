return {
	"ahmedkhalf/project.nvim",
	event = "VeryLazy",
	config = function()
		require("project_nvim").setup({
			detection_methods = { "pattern" },
			patterns = { ".git", "package.json", "Cargo.toml", "go.mod" },
			show_hidden = false,
			silent_chdir = false,
		})
		require("telescope").load_extension("projects")

		-- REMOVED: This was causing the crash!
		-- vim.api.nvim_create_autocmd("DirChanged", {
		-- 	callback = function()
		-- 		vim.cmd("Neotree reveal")
		-- 	end,
		-- })
	end,
	keys = {
		{
			"<leader>fp",
			function()
				require("telescope").extensions.projects.projects({})
			end,
			desc = "Open Project",
		},
	},
}
