-- Leader key (must be set before lazy.nvim)
vim.g.mapleader = " "

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true -- ADDED: Better for navigation

-- UI
vim.opt.title = true
vim.opt.showcmd = true
vim.opt.cmdheight = 0 -- CHANGED: Hide command line when not in use
vim.opt.laststatus = 3 -- Global statusline
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes" -- ADDED: Always show sign column

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true -- ADDED: Incremental search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- Scrolling
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8 -- ADDED: Horizontal scroll offset

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"

-- Line wrapping
vim.opt.wrap = true
vim.opt.linebreak = true -- ADDED: Wrap at word boundaries

-- Backup and undo
vim.opt.backup = false
vim.opt.writebackup = false -- ADDED: Disable backup before overwrite
vim.opt.undofile = true -- ADDED: Persistent undo
vim.opt.swapfile = false -- ADDED: Disable swap files

-- Shell
vim.opt.shell = "fish"

-- Files and paths
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.inccommand = "split"

-- Editing
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.mouse = "" -- Disable mouse

-- Folding
vim.opt.foldmethod = "manual"
vim.opt.foldlevel = 99 -- ADDED: Don't fold by default
vim.opt.foldcolumn = "1"
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Performance
vim.opt.updatetime = 250 -- ADDED: Faster completion
vim.opt.timeoutlen = 300 -- ADDED: Faster which-key popup

-- Undercurl support
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Format options
vim.opt.formatoptions:append({ "r" })

-- Filetype detection
vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

-- REMOVED: Conditional cmdheight (already set to 0 above)
