return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			sync_install = false,
			auto_install = true,
			ensure_installed = {
				"astro",
				"cmake",
				"html",
				"cpp",
				"css",
				"fish",
				"gitignore",
				"go",
				"graphql",
				"http",
				"java",
				"php",
				"rust",
				"scss",
				"sql",
				"svelte",
				"javascript",
				"embedded_template",
			},

			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},

			playground = {
				enable = true,
				updatetime = 25,
				persist_queries = true,
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			-- MDX Support
			vim.filetype.add({
				extension = { mdx = "mdx" },
			})
			vim.treesitter.language.register("markdown", "mdx")

			-- EJS Support
			vim.filetype.add({
				extension = { ejs = "ejs" },
			})
			vim.treesitter.language.register("html", "ejs")
			vim.treesitter.language.register("javascript", "ejs")
			vim.treesitter.language.register("embedded_template", "ejs")
		end,
	},
}
