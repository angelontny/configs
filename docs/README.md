# Configuration Documentation

Welcome to the configuration documentation for this dotfiles repository. Here you will find in-depth guides, keybinding cheatsheets, and architecture notes for all managed tools and automation scripts.

## 📚 Table of Contents

- [Tmux Configuration (`docs/tmux.md`)](./tmux.md): Comprehensive guide to the tmux setup, keybindings, true-color terminal overrides, Tokyo Night styling, and Neovim integration.
- [Scripts & Automation (`docs/scripts.md`)](./scripts.md): Documentation of helper scripts (e.g., `scripts/link.sh`), safe symlinking behavior, backup mechanisms, and XDG standards.
- [Neovim Configuration (`docs/nvim.md`)](./nvim.md): Modular Lua Neovim configuration guide, plugin management with `lazy.nvim`, keybindings, and LSP/Treesitter features.

## 🎯 Design Principles

1. **XDG Compliance**: All tool configurations target `~/.config/<tool>` in accordance with the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
2. **Safety First**: Symlinking scripts never silently overwrite non-symlink files; automatic timestamped backups (`.bak.<timestamp>`) are created.
3. **Ergonomics & Cohesion**: Cohesive visual theme (Tokyo Night palette) and shared navigation conventions (Vim-style navigation) across tmux and Neovim.
