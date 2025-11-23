local discipline = require("craftzdog.discipline")
discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- jk for esc
keymap.set("i", "jk", "<Esc>", opts)

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- Tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")
keymap.set("n", "sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Code runner
keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false, desc = "Run code" })
keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false, desc = "Run file" })
keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false, desc = "Run file in tab" })
keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false, desc = "Run project" })
keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false, desc = "Close runner" })
keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false, desc = "Runner filetype" })
keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false, desc = "Runner projects" })

-- Extras
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

-- Keep last yanked when pasting
keymap.set("v", "p", '"_dP', opts)

-- Terminal mappings
keymap.set("t", "jk", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- Live server toggle
keymap.set("n", "<leader>lt", function()
	require("live-server").toggle()
end, { desc = "Toggle live server" })

-- Replace word under cursor
keymap.set("n", "<leader>j", "*``cgn", opts)

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, { desc = "Next diagnostic" })

-- Theme picker
keymap.set("n", "<leader>th", function()
	vim.cmd("Telescope colorscheme")
end, { desc = "Choose theme (saves automatically)" })

-- Directory management
keymap.set("n", "<leader>pwd", function()
	local cwd = vim.fn.getcwd()
	vim.notify("Current directory: " .. cwd, vim.log.levels.INFO)
end, { desc = "Show current directory" })

keymap.set("n", "<leader>cf", function()
	local file_dir = vim.fn.expand("%:p:h")
	vim.cmd("cd " .. file_dir)
	vim.cmd("Neotree reveal")
	vim.notify("Changed to: " .. file_dir, vim.log.levels.INFO)
end, { desc = "CD to file directory" })

keymap.set("n", "<leader>cr", function()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
	if git_root and git_root ~= "" then
		vim.cmd("cd " .. git_root)
		vim.cmd("Neotree reveal")
		vim.notify("Changed to project root: " .. git_root, vim.log.levels.INFO)
	else
		vim.notify("Not in a git project!", vim.log.levels.WARN)
	end
end, { desc = "CD to project root" })

-- IMPORTANT: Override LazyVim's default telescope keybinds
-- This makes <leader><space> search in cwd instead of root
keymap.set("n", "<leader><space>", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.getcwd(),
		hidden = false,
	})
end, { desc = "Find Files (cwd)" })

keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.getcwd(),
		hidden = false,
	})
end, { desc = "Find Files (cwd)" })

keymap.set("n", "<leader>fR", function()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
	if git_root and git_root ~= "" then
		require("telescope.builtin").find_files({
			cwd = git_root,
		})
	else
		require("telescope.builtin").find_files({
			cwd = vim.fn.getcwd(),
		})
	end
end, { desc = "Find Files (project root)" })
