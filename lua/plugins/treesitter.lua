return {
	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },

		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"astro",
				"cmake",
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
				"embedded_template",
			},
			sync_install = false,
			auto_install = true,

			-- FEATURE 1: Syntax Highlighting
			highlight = {
				enable = true,
				-- Performance: Disable for large files
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},

			-- FEATURE 2: Smart Indentation
			indent = {
				enable = true,
				disable = { "python" },
			},

			-- FEATURE 3: Incremental Selection
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			-- FEATURE 4: Text Objects (Enhanced)
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- Functions
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						-- Classes
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						-- Parameters (ADDED)
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						-- Conditionals (ADDED)
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						-- Loops (ADDED)
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
					},
				},

				-- FEATURE 5: Smart Movement (Enhanced)
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner", -- ADDED: Next parameter
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.inner", -- ADDED: Next parameter end
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner", -- ADDED: Previous parameter
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner", -- ADDED: Previous parameter end
					},
				},

				-- FEATURE 6: Swap Parameters (ADDED - Super Useful!)
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},

				-- FEATURE 7: LSP Interop (ADDED - Better with LSP)
				lsp_interop = {
					enable = true,
					border = "rounded",
					floating_preview_opts = {},
					peek_definition_code = {
						["<leader>df"] = "@function.outer",
						["<leader>dF"] = "@class.outer",
					},
				},
			},
		},

		config = function(_, opts)
			-- Let LazyVim handle it automatically via opts

			-- Register custom file types
			vim.filetype.add({
				extension = {
					mdx = "mdx",
					ejs = "ejs",
				},
			})

			vim.treesitter.language.register("markdown", "mdx")
			vim.treesitter.language.register("html", "ejs")
			vim.treesitter.language.register("typescript", "tsx")

			-- FEATURE 8: Treesitter-based Folding (ADDED)
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true
		end,
	},
}
