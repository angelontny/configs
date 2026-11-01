#!/usr/bin/env bash
#
# Helper script to symlink dotfiles into ~/.config
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

echo "==> Dotfiles directory: ${DOTFILES_DIR}"
echo "==> Target config directory: ${CONFIG_DIR}"

mkdir -p "${CONFIG_DIR}"

link_item() {
    local src="$1"
    local dest="$2"

    if [ -L "${dest}" ]; then
        echo "Updating symlink: ${dest} -> ${src}"
        ln -sf "${src}" "${dest}"
    elif [ -e "${dest}" ]; then
        local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
        echo "Backing up existing: ${dest} -> ${backup}"
        mv "${dest}" "${backup}"
        echo "Creating symlink: ${dest} -> ${src}"
        ln -s "${src}" "${dest}"
    else
        echo "Creating symlink: ${dest} -> ${src}"
        mkdir -p "$(dirname "${dest}")"
        ln -s "${src}" "${dest}"
    fi
}

# 1. tmux
if [ -d "${DOTFILES_DIR}/tmux" ]; then
    mkdir -p "${CONFIG_DIR}/tmux"
    link_item "${DOTFILES_DIR}/tmux/tmux.conf" "${CONFIG_DIR}/tmux/tmux.conf"
fi

# 2. nvim (when created)
if [ -d "${DOTFILES_DIR}/nvim" ]; then
    link_item "${DOTFILES_DIR}/nvim" "${CONFIG_DIR}/nvim"
fi

# 3. mpv
if [ -d "${DOTFILES_DIR}/mpv" ]; then
    link_item "${DOTFILES_DIR}/mpv" "${CONFIG_DIR}/mpv"
fi

# 4. user scripts
if [ -f "${DOTFILES_DIR}/scripts/mpv-move-file.sh" ]; then
    link_item "${DOTFILES_DIR}/scripts/mpv-move-file.sh" "${HOME}/.local/bin/mpv-move-file.sh"
fi

echo "==> Symlinking complete!"
