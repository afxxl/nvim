local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- LazyVim core
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "tokyonight",
				news = {
					lazyvim = true,
					neovim = true,
				},
			},
		},

		-- Live Server
		{
			"barrett-ruth/live-server.nvim",
			build = "pnpm add -g live-server",
			cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
			opts = {
				args = { "--port=5555" },
			},
		},

		-- ChatGPT
		{
			"jackMort/ChatGPT.nvim",
			event = "VeryLazy",
			config = function()
				require("chatgpt").setup({
					api_key_cmd = "echo $OPENAI_API_KEY",
				})
			end,
			dependencies = {
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"folke/trouble.nvim",
				"nvim-telescope/telescope.nvim",
			},
		},

		-- Emmet (OPTIMIZED: Added lazy loading)
		{
			"olrtg/nvim-emmet",
			ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
			config = function()
				vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
			end,
		},

		-- REMOVED: Duplicate render-markdown (it's already in avante.nvim dependencies)

		-- Avante (Gemini) Plugin
		{
			"yetone/avante.nvim",
			event = "VeryLazy",
			version = false,
			opts = {
				provider = "gemini",

				providers = {
					gemini = {
						model = "gemini-2.0-flash",
						timeout = 30000,
						temperature = 0,
						max_tokens = 4096,
					},
					deepseek = {
						__inherited_from = "openai",
						api_key_name = "DEEPSEEK_API_KEY",
						endpoint = "https://api.deepseek.com",
						model = "deepseek-reasoner",
						timeout = 30000,
					},
				},

				behaviour = {
					auto_suggestions = false,
					auto_set_highlight_group = true,
					auto_set_keymaps = true,
					auto_apply_diff_after_generation = false,
					support_paste_from_clipboard = false,
				},
			},

			build = "make",

			dependencies = {
				"stevearc/dressing.nvim",
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-mini/mini.pick",
				"nvim-telescope/telescope.nvim",
				"hrsh7th/nvim-cmp",
				"ibhagwan/fzf-lua",
				"nvim-tree/nvim-web-devicons",
				"zbirenbaum/copilot.lua",
				{
					"HakonHarnes/img-clip.nvim",
					event = "VeryLazy",
					opts = {
						default = {
							embed_image_as_base64 = false,
							prompt_for_file_name = false,
							drag_and_drop = {
								insert_mode = true,
							},
							use_absolute_path = true,
						},
					},
				},
				{
					"MeanderingProgrammer/render-markdown.nvim",
					opts = {
						file_types = { "markdown", "Avante" },
					},
					ft = { "markdown", "Avante" },
				},
			},
		},

		-- LazyVim extras
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.rust" },
		{ import = "lazyvim.plugins.extras.lang.tailwind" },
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		{ import = "plugins" },
	},

	defaults = {
		lazy = false,
		version = false,
	},

	install = {
		missing = true,
		colorscheme = { "tokyonight" },
	},

	dev = {
		path = "~/.ghq/github.com",
	},

	checker = {
		enabled = true,
		frequency = 3600, -- ADDED: Check once per hour instead of constantly
	},

	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},

	ui = {
		-- REMOVED: custom_keys with dd() since debug.lua is deleted
		border = "rounded",
		backdrop = 60,
	},

	debug = false,
})
