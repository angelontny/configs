-- ==============================================================================
-- Neovim Configuration Entrypoint (~/.config/nvim/init.lua)
-- ==============================================================================

-- Set leader keys before lazy.nvim or any plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configurations (options, keymaps, autocmds, and package manager)
require("config")
