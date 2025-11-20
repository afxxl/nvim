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

	-- Windsurf (optimized)
	{
		"Exafunction/windsurf.vim",
		event = "VeryLazy",
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
}
