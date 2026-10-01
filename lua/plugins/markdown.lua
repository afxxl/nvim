return {
	-- 1. Paste screenshots directly into Neovim with <leader>pi (Paste Image)
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			default = {
				dir_path = "assets",
				prompt_for_file_name = false,
				use_absolute_path = false, -- ADD THIS: Forces relative paths for GitHub!
			},
		},
		keys = {
			{ "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
		},
	},

	-- 2. Live Browser Preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
