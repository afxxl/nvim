-- tailwind-tools.lua
return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",

	ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "astro" },

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
		"neovim/nvim-lspconfig",
	},

	opts = {
		document_color = {
			enabled = true,
			kind = "inline",
			inline_symbol = "󰝤 ",
			debounce = 300,
		},
		conceal = {
			enabled = false,
		},
		server = {
			override = true,
		},
	},
}
