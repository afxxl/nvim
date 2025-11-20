return {
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = { "ToggleTerm", "ToggleTermSetName", "TermSelect" },
		keys = {
			{
				"<leader>Tf",
				function()
					local count = vim.v.count1
					require("toggleterm").toggle(count, 0, LazyVim.root.get(), "float")
				end,
				desc = "ToggleTerm (float root_dir)",
			},
			{
				"<leader>Th",
				function()
					local count = vim.v.count1
					require("toggleterm").toggle(count, 15, LazyVim.root.get(), "horizontal")
				end,
				desc = "ToggleTerm (horizontal root_dir)",
			},
			{
				"<leader>Tv",
				function()
					local count = vim.v.count1
					require("toggleterm").toggle(count, vim.o.columns * 0.4, LazyVim.root.get(), "vertical")
				end,
				desc = "ToggleTerm (vertical root_dir)",
			},
			{
				"<leader>Tn",
				"<cmd>ToggleTermSetName<cr>",
				desc = "Set term name",
			},
			{
				"<leader>Ts",
				"<cmd>TermSelect<cr>",
				desc = "Select term",
			},
			{
				"<leader>Tt",
				function()
					require("toggleterm").toggle(1, 100, LazyVim.root.get(), "tab")
				end,
				desc = "ToggleTerm (tab root_dir)",
			},
			{
				"<leader>TT",
				function()
					require("toggleterm").toggle(1, 100, vim.loop.cwd(), "tab")
				end,
				desc = "ToggleTerm (tab cwd_dir)",
			},
		},
		opts = {
			-- Size configuration
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,

			-- Quick toggle keybinding
			open_mapping = [[<c-\>]],

			-- Performance: Hide line numbers in terminal
			hide_numbers = true,

			-- Visual settings
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2, -- Defined shading factor for consistency

			-- Behavior
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true, -- Persist insert mode when switching buffers

			-- Direction (default)
			direction = "float",

			-- Close on exit
			close_on_exit = true,

			-- Use current shell
			shell = vim.o.shell,

			-- Auto scroll to bottom on output
			auto_scroll = true,

			-- Optimized float settings
			float_opts = {
				border = "curved",
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
				winblend = 3,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		},
	},
}
