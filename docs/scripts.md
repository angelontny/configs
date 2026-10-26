# Scripts Documentation

This document describes the helper scripts included in the `scripts/` directory to manage and deploy configuration files.

---

## 📄 `scripts/link.sh`

`link.sh` is an idempotent symlink installer that connects dotfile configurations in this repository to standard XDG config destinations in `$HOME/.config`.

### Location & Execution

```bash
# From repository root:
./scripts/link.sh

# Or directly:
bash scripts/link.sh
```

### Key Behaviors & Safety Guarantees

1. **Idempotence**: Running `link.sh` multiple times is completely safe. Existing valid symlinks are refreshed (`ln -sf`) without disruption.
2. **Non-Destructive Backups**: If a real file or directory exists at the destination path (not a symlink), it is **not overwritten**. Instead, it is renamed with a timestamped suffix:
   ```text
   ~/.config/tmux/tmux.conf.bak.YYYYMMDDHHMMSS
   ```
3. **Automatic Directory Creation**: Missing parent directories (e.g. `~/.config/tmux`) are automatically created (`mkdir -p`) before symlink generation.
4. **Environment Variable Support**: Respects `$XDG_CONFIG_HOME` if set; defaults cleanly to `$HOME/.config`.
5. **Strict Bash Error Handling**: Configured with `set -euo pipefail` to halt immediately if an unexpected error or unbound variable is encountered.

---

### Monitored Dotfile Targets

| Source Path (Repo) | Destination Path | Description |
|---|---|---|
| `tmux/tmux.conf` | `~/.config/tmux/tmux.conf` | Modern XDG location for Tmux configuration |
| `nvim/` | `~/.config/nvim/` | Entire Lua-based Neovim configuration directory |

---

### Internal Function: `link_item`

The core routine of `link.sh` handles individual items using the following logic:

```bash
link_item() {
    local src="$1"
    local dest="$2"

    if [ -L "${dest}" ]; then
        # If destination is already a symlink, overwrite it cleanly
        echo "Updating symlink: ${dest} -> ${src}"
        ln -sf "${src}" "${dest}"
    elif [ -e "${dest}" ]; then
        # If destination is an actual file/directory, back it up first
        local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
        echo "Backing up existing: ${dest} -> ${backup}"
        mv "${dest}" "${backup}"
        echo "Creating symlink: ${dest} -> ${src}"
        ln -s "${src}" "${dest}"
    else
        # If destination does not exist, create parent dir and symlink
        echo "Creating symlink: ${dest} -> ${src}"
        mkdir -p "$(dirname "${dest}")"
        ln -s "${src}" "${dest}"
    fi
}
```

---

### How to Add a New Tool Target

When adding a new configuration directory (for example, `alacritty` or `fish`):

1. Create the repository directory (e.g., `alacritty/alacritty.toml`).
2. Add a new block in `scripts/link.sh`:
   ```bash
   # Example: alacritty
   if [ -d "${DOTFILES_DIR}/alacritty" ]; then
       mkdir -p "${CONFIG_DIR}/alacritty"
       link_item "${DOTFILES_DIR}/alacritty" "${CONFIG_DIR}/alacritty"
   fi
   ```
3. Test by running `./scripts/link.sh`.
