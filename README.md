# Configs & Dotfiles

Personal configuration files organized for modularity and symlinking into `~/.config/`.

---

## 📁 Repository Structure

Each tool lives in its own dedicated directory matching the standard XDG directory layout:

```text
configs/
├── README.md              # Setup guide and overview
├── docs/                  # Detailed documentation for all components
│   ├── README.md          # Documentation index & design principles
│   ├── tmux.md            # Tmux cheatsheet, keybindings, and aesthetics
│   ├── scripts.md         # Backup behavior and symlinking guide
│   └── nvim.md            # Neovim architecture, keybindings, and LSP guide
├── scripts/
│   └── link.sh            # Safe symlinking helper script (creates timestamped backups)
├── tmux/
│   └── tmux.conf          # Symlinked to ~/.config/tmux/tmux.conf
└── nvim/                  # Symlinked to ~/.config/nvim/
    ├── init.lua           # Entrypoint: sets mapleader and loads core config
    └── lua/
        ├── config/        # options, keymaps, autocmds, and lazy bootstrap
        └── plugins/       # Modular plugin specs (Catppuccin, LSP, Telescope, etc.)
```

---

## 🔗 Symlinking Strategy

Modern tools (including **tmux 3.1+** and **Neovim**) adhere to the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html), reading from `~/.config/<tool>/`.

### Option 1: Automatic Symlinking (Recommended)

Run the included helper script to safely create symlinks in `~/.config/` (safely creates timestamped backups of any pre-existing non-symlink configurations):

```bash
./scripts/link.sh
```

### Option 2: Manual Symlinks

If you prefer to link individual components manually:

```bash
# Ensure ~/.config exists
mkdir -p ~/.config

# tmux (~/.config/tmux/tmux.conf)
mkdir -p ~/.config/tmux
ln -sf "$(pwd)/tmux/tmux.conf" ~/.config/tmux/tmux.conf

# neovim (~/.config/nvim)
ln -sf "$(pwd)/nvim" ~/.config/nvim
```

---

## 🛠️ Components

| Component | Status | Target Path | Documentation | Notes |
|---|---|---|---|---|
| **tmux** | Ready | `~/.config/tmux/tmux.conf` | [Tmux Guide](docs/tmux.md) | Modern keybinds, true-color, Tokyo Night, nvim integration |
| **neovim** | Ready | `~/.config/nvim/` | [Neovim Guide](docs/nvim.md) | Modular Lua config, lazy.nvim, LSP, Treesitter, Telescope |
| **scripts** | Ready | `scripts/` | [Scripts Guide](docs/scripts.md) | Safe, non-destructive symlink automation |
