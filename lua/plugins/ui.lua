return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			-- Skip unnecessary notifications
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})

			-- Skip search count messages for performance
			table.insert(opts.routes, {
				filter = { event = "msg_show", kind = "search_count" },
				opts = { skip = true },
			})

			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			-- PERFORMANCE: Simplified presets
			opts.presets = {
				bottom_search = false,
				command_palette = false,
				lsp_doc_border = true,
				long_message_to_split = true,
			}
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 3000,
			background_colour = "#000000",
			max_width = 60,
			max_height = 10,
			render = "compact",
			stages = "fade",
			-- ADDED: Performance boost
			fps = 30, -- Lower FPS for smoother on low-end
			top_down = false, -- Notifications appear from bottom
		},
	},

	-- PERFORMANCE: Animations disabled
	{
		"nvim-mini/mini.animate",
		enabled = false,
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				show_buffer_close_icons = false,
				show_close_icon = false,
				separator_style = "thin",
				always_show_bufferline = false,
				-- ADDED: Performance improvements
				indicator = {
					style = "none", -- Simpler indicator
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "center",
					},
				},
			},
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "folke/tokyonight.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = "#6d829f", guifg = "#ffffff" },
						InclineNormalNC = { guifg = "#8798b3", guibg = "none" },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end
					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			opts.options = {
				theme = "tokyonight",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			}
			opts.sections.lualine_c[4] = {
				LazyVim.lualine.pretty_path({
					length = 0,
					relative = "cwd",
					modified_hl = "MatchParen",
					directory_hl = "",
					filename_hl = "Bold",
					modified_sign = "",
					readonly_icon = " 󰌾 ",
				}),
			}
		end,
	},

	-- colorscheme
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		style = "night",
	-- 		transparent = true,
	-- 		terminal_colors = true,
	-- 		styles = {
	-- 			sidebars = "transparent",
	-- 			floats = "transparent",
	-- 			comments = { italic = true },
	-- 			keywords = { italic = true },
	-- 			functions = { bold = true },
	-- 		},
	-- 		on_colors = function(colors)
	-- 			colors.bg = "#0f1117"
	-- 			colors.hint = "#1abc9c"
	-- 			colors.info = "#0db9d7"
	-- 		end,
	-- 		on_highlights = function(hl, c)
	-- 			-- Make backgrounds more subtle
	-- 			hl.CursorLine = { bg = c.bg_highlight }
	-- 			hl.Visual = { bg = "#264f78" }
	-- 		end,
	-- 		cache = true,
	-- 		dim_inactive = false,
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("tokyonight").setup(opts)
	-- 		vim.cmd([[colorscheme tokyonight]])
	-- 	end,
	-- },

	-- Kanagawa Theme
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = { bold = true },
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = true,
			dimInactive = false,
			terminalColors = true,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			theme = "dragon", -- Load "wave" theme or "dragon" or "lotus"
		},
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd([[colorscheme kanagawa]])
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				width = 120,
				options = {
					number = false,
					relativenumber = false,
					signcolumn = "no",
				},
			},
			plugins = {
				gitsigns = { enabled = true },
				tmux = { enabled = true },
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					header = [[
 _     _____ _____  _ ____    ____  ____  ____  _____
/ \   /  __//__ __\|// ___\  /   _\/  _ \/  _ \/  __/
| |   |  \    / \    |    \  |  /  | / \|| | \||  \  
| |_/\|  /_   | |    \___ |  |  \__| \_/|| |_/||  /_ 
\____/\____\  \_/    \____/  \____/\____/\____/\____\
          ]],
				},
			},
			animate = {
				enabled = false,
			},
		},
	},
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		opts = {
			-- Smooth scrolling mappings
			mappings = {
				"<C-u>",
				"<C-d>",
				"<C-b>",
				"<C-f>",
				"<C-y>",
				"<C-e>",
				"zt",
				"zz",
				"zb",
			},
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,

			-- SMOOTHER EASING FUNCTION
			easing_function = "sine", -- Changed from "quadratic"

			-- PERFORMANCE MODE
			performance_mode = false, -- Keep animations

			-- FASTER, SMOOTHER DURATION (key change!)
			duration_multiplier = 0.5, -- Lower = faster = less stutter
		},
		config = function(_, opts)
			require("neoscroll").setup(opts)

			-- Custom smooth scroll speeds for each command
			local neoscroll = require("neoscroll")
			local keymap = {
				-- Half page scrolling (smooth)
				["<C-u>"] = function()
					neoscroll.ctrl_u({ duration = 150 })
				end,
				["<C-d>"] = function()
					neoscroll.ctrl_d({ duration = 150 })
				end,

				-- Full page scrolling (faster)
				["<C-b>"] = function()
					neoscroll.ctrl_b({ duration = 200 })
				end,
				["<C-f>"] = function()
					neoscroll.ctrl_f({ duration = 200 })
				end,

				-- Line scrolling (very smooth)
				["<C-y>"] = function()
					neoscroll.scroll(-0.1, { move_cursor = false, duration = 50 })
				end,
				["<C-e>"] = function()
					neoscroll.scroll(0.1, { move_cursor = false, duration = 50 })
				end,

				-- Centering commands (instant)
				["zt"] = function()
					neoscroll.zt({ half_win_duration = 100 })
				end,
				["zz"] = function()
					neoscroll.zz({ half_win_duration = 100 })
				end,
				["zb"] = function()
					neoscroll.zb({ half_win_duration = 100 })
				end,
			}

			local modes = { "n", "v", "x" }
			for key, func in pairs(keymap) do
				vim.keymap.set(modes, key, func)
			end
		end,
	},
}
