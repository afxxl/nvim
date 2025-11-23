return {
	"nvim-telescope/telescope.nvim",
	opts = {
		defaults = {
			file_ignore_patterns = {
				"node_modules",
				".git/",
				"dist/",
				"build/",
				"target/",
			},
		},
	},
	keys = {
		{
			"<leader><space>",
			function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.getcwd(),
				})
			end,
			desc = "Find Files (cwd)",
		},
		{
			"<leader>fF",
			function()
				local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
				if git_root and git_root ~= "" then
					require("telescope.builtin").find_files({
						cwd = git_root,
					})
				else
					vim.notify("Not in a git project", vim.log.levels.WARN)
					require("telescope.builtin").find_files({
						cwd = vim.fn.getcwd(),
					})
				end
			end,
			desc = "Find Files (root)",
		},
	},
}
