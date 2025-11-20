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
--clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")
keymap.set("n", "sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Lua config (e.g. in init.lua)
keymap.set("n", "<leader>yf", ":yaf<CR>", { silent = true })

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- code runner
keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false })
keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false })
keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false })
keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })

--Extras
-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

-- Keep last yanked when pasting
keymap.set("v", "p", '"_dP', opts)
-- Terminal Mappings
keymap.set("t", "jk", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

keymap.set("n", "<leader>lt", function()
	require("live-server").toggle()
end)
-- Replace word under cursor
keymap.set("n", "<leader>j", "*``cgn", opts)
-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

-- Theme picker command
keymap.set("n", "<leader>th", function()
	vim.cmd("Telescope colorscheme")
end, { desc = "Choose theme (saves automatically)" })
