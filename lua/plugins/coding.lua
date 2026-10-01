return {
	-- Create annotations with one keybind
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},

	--jupytext.vim

	{
		"goerz/jupytext.vim",
		config = function()
			-- Tells Jupytext to format the file as a Python script with # %% cell markers
			vim.g.jupytext_fmt = "py:percent"
		end,
	},
	-- porper render
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			-- This ensures it draws nice background boxes around code cells
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
			heading = {
				sign = false,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
		},
	},
	{
		"nvim-mini/mini.hipatterns", -- Updated repository name
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- This turns "# %%" into a prominent visual divider line
					cell_separator = {
						pattern = "^# %%%%.-$",
						group = "DiffAdd", -- Try "DiffAdd", "CursorLine", or "Error" for different background colors
					},
				},
			})
		end,
	},

	--notebookNavigator
	{
		"GCBallesteros/NotebookNavigator.nvim",
		keys = {
			{
				"]h",
				function()
					require("notebook-navigator").move_cell("d")
				end,
				desc = "Next cell",
			},
			{
				"[h",
				function()
					require("notebook-navigator").move_cell("u")
				end,
				desc = "Previous cell",
			},
			-- CHANGED: Use <leader>mc (Molten Cell) and <leader>mn (Molten Next)
			{ "<leader>mc", "<cmd>lua require('notebook-navigator').run_cell()<cr>", desc = "Run cell" },
			{
				"<leader>mn",
				"<cmd>lua require('notebook-navigator').run_and_move()<cr>",
				desc = "Run cell and move down",
			},
		},
		dependencies = {
			"nvim-mini/mini.comment",
			"hkupty/iron.nvim", -- fallback dependency
			"akinsho/toggleterm.nvim", -- fallback dependency
		},
		config = function()
			local nn = require("notebook-navigator")
			nn.setup({
				activate_extmark_fallback = true,
				repl_provider = "molten", -- Tells NotebookNavigator to route execution through Molten
			})
		end,
	},
	-- eslint
	{
		"esmuellert/nvim-eslint",
		config = function()
			require("nvim-eslint").setup({})
		end,
	},

	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- Code runner (now lazy loaded)
	{
		"CRAG666/code_runner.nvim",
		cmd = { "RunCode", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects" },
		config = true,
	},

	-- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

	-- Go forward/backward with square brackets
	{
		"nvim-mini/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

	-- Windsurf with custom keybindings
	{
		"Exafunction/windsurf.vim",
		event = "InsertEnter",
		config = function()
			-- Enable Windsurf/Codeium
			vim.g.codeium_enabled = true
			vim.g.codeium_disable_bindings = 0

			-- Custom keybindings using Codeium functions
			vim.keymap.set("i", "<Tab>", function()
				if vim.fn["codeium#Accept"]() ~= "" then
					return vim.fn["codeium#Accept"]()
				else
					return "<Tab>"
				end
			end, { expr = true, silent = true, desc = "Accept Windsurf suggestion or Tab" })

			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true, desc = "Accept Windsurf suggestion" })

			vim.keymap.set("i", "<C-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true, desc = "Next suggestion" })

			vim.keymap.set("i", "<C-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true, desc = "Previous suggestion" })

			vim.keymap.set("i", "<C-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true, desc = "Clear suggestion" })
		end,
	},

	-- Better increase/decrease
	{
		"monaqa/dial.nvim",
		-- stylua: ignore
		keys = {
			{ "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
			{ "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

	-- Symbols outline
	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		cmd = "SymbolsOutline",
		opts = {
			position = "right",
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true, -- Use treesitter
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
			},
		},
	},
	--testing
	{
		"rest-nvim/rest.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "http")
			end,
		},
	},
}
