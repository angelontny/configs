-- ==============================================================================
-- Neovim Options
-- ==============================================================================

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation (2 spaces default)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI & Appearance
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showmode = false -- Don't show mode (lualine handles this)
opt.pumheight = 10   -- Popup menu height
opt.cmdheight = 1

-- Window Splitting (natural splits)
opt.splitbelow = true
opt.splitright = true

-- Clipboard (sync with system clipboard)
opt.clipboard = "unnamedplus"

-- Undo & Backup files
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Performance & responsiveness
opt.updatetime = 250
opt.timeoutlen = 300

-- Behavior & formatting
opt.completeopt = "menu,menuone,noselect"
opt.mouse = "a"
opt.fileencoding = "utf-8"
opt.backspace = "indent,eol,start"
opt.conceallevel = 0 -- See markdown text as-is
opt.iskeyword:append("-")
