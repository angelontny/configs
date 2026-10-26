# Tmux Configuration

Documentation for the tmux configuration located at [`tmux/tmux.conf`](../tmux/tmux.conf) and symlinked to `~/.config/tmux/tmux.conf`.

---

## 📋 Overview

The tmux configuration is designed for modern terminal workflows, high ergonomics, seamless editor integration with Neovim, and a clean Catppuccin Mocha aesthetic.

### Configuration Path

- **Repository**: `tmux/tmux.conf`
- **Target**: `~/.config/tmux/tmux.conf` *(Supported natively by tmux 3.1+)*

To reload your configuration on the fly inside an active session:
```bash
tmux source-file ~/.config/tmux/tmux.conf
```
Or press:
```text
Prefix + r
```

---

## ⚙️ Configuration Breakdown

### 1. General & Terminal Settings

- **True Color (24-bit RGB)**:
  ```tmux
  set -g default-terminal "tmux-256color"
  set -ag terminal-overrides ",xterm-256color:RGB"
  ```
  Ensures that rich colorschemes in modern CLI applications (like Neovim themes) display accurately without color banding.

- **Zero Escape Delay (`escape-time 0`)**:
  Eliminates the delay when pressing `Esc` in Vim/Neovim (prevents mode switching lag).

- **Deep Scrollback (`history-limit 50000`)**:
  Increases scrollback buffer from the default 2,000 lines to 50,000 lines.

- **Focus Events (`focus-events on`)**:
  Propagates terminal focus changes to applications inside tmux, enabling Neovim's `FocusGained` and `FocusLost` autocommands (essential for auto-save and file reload).

- **Mouse Support (`mouse on`)**:
  Enables mouse clicking for pane selection, window tabs, dragging to resize borders, and mousewheel scrolling.

---

### 2. Window & Pane Numbering

- **1-Based Indexing**:
  ```tmux
  set -g base-index 1
  setw -g pane-base-index 1
  ```
  Windows and panes start at index `1` instead of `0`, matching the natural layout of physical keyboard number keys `1-9`.

- **Automatic Window Renumbering (`renumber-windows on`)**:
  When a window is closed, remaining windows are automatically renumbered sequentially to prevent gaps.

---

### 3. Keybindings Reference

Default Prefix: **`Ctrl-b`** (`C-b`)

> [!NOTE]
> If you prefer `Ctrl-a`, lines 42–44 in `tmux/tmux.conf` can be uncommented to switch the prefix.

#### Session & Config Management

| Keybinding | Action |
|---|---|
| `Prefix + r` | Reload `~/.config/tmux/tmux.conf` and display confirmation |
| `Prefix + d` | Detach from the current session |
| `Prefix + s` | Interactive session switcher |

#### Windows & Splits

| Keybinding | Action | Description |
|---|---|---|
| `Prefix + \|` | Split window horizontally | Creates left / right panes; preserves current working directory (`pwd`) |
| `Prefix + -` or `Prefix + _` | Split window vertically | Creates top / bottom panes; preserves current working directory (`pwd`) |
| `Prefix + c` | New window | Creates a new window in the current working directory (`pwd`) |
| `Prefix + 1` .. `Prefix + 9` | Select window | Switches directly to window number 1–9 |
| `Prefix + &` | Kill window | Closes the current window after confirmation |
| `Prefix + x` | Kill pane | Closes the active pane after confirmation |

#### Pane Navigation

| Keybinding | Action | Description |
|---|---|---|
| `Ctrl + h` | Move left | Smart navigation across Neovim splits and tmux panes |
| `Ctrl + j` | Move down | Smart navigation across Neovim splits and tmux panes |
| `Ctrl + k` | Move up | Smart navigation across Neovim splits and tmux panes |
| `Ctrl + l` | Move right | Smart navigation across Neovim splits and tmux panes |
| `Ctrl + \` | Move previous | Return to previous pane/split |
| `Alt + Left` | Move to left pane | Direct navigation without prefix |
| `Alt + Right` | Move to right pane | Direct navigation without prefix |
| `Alt + Up` | Move to upper pane | Direct navigation without prefix |
| `Alt + Down` | Move to lower pane | Direct navigation without prefix |
| `Prefix + h` | Move to left pane | Vim-style navigation |
| `Prefix + j` | Move to lower pane | Vim-style navigation |
| `Prefix + k` | Move to upper pane | Vim-style navigation |
| `Prefix + l` | Move to right pane | Vim-style navigation |

#### Pane Resizing & Zoom

| Keybinding | Action | Description |
|---|---|---|
| `Prefix + H` | Resize pane left by 5 cells | Repeatable without re-entering prefix |
| `Prefix + J` | Resize pane down by 5 cells | Repeatable without re-entering prefix |
| `Prefix + K` | Resize pane up by 5 cells | Repeatable without re-entering prefix |
| `Prefix + L` | Resize pane right by 5 cells | Repeatable without re-entering prefix |
| `Prefix + m` or `Prefix + z` | Toggle pane zoom | Temporarily expands active pane to full window size |

---

### 4. Vi Copy Mode & System Clipboard

Copy mode is configured with Vim keybindings:

1. Press `Prefix + [` to enter copy mode.
2. Navigate using standard Vim motions (`h`, `j`, `k`, `l`, `w`, `b`, `/`, `?`, etc.).
3. Press `v` to begin character visual selection.
4. Press `y` to yank the selection to the system clipboard (uses `xclip`) and exit copy mode.
5. Alternatively, clicking and dragging with the mouse automatically copies selected text to the system clipboard on release.

---

### 5. Catppuccin Mocha Styling

The UI is customized with a cohesive, minimalist dark theme:

| Element | Color Hex | Description |
|---|---|---|
| **Status Bar Background** | `#1e1e2e` | Catppuccin Base |
| **Status Bar Foreground** | `#cdd6f4` | Catppuccin Text |
| **Active Session Badge** | `#89b4fa` (Blue) | Bold highlight on status-left |
| **Active Window Tab** | `#45475a` (Surface1) | White bold text with asterisk indicator |
| **Inactive Window Tab** | `#1e1e2e` / `#6c7086` | Dimmed overlay |
| **Active Pane Border** | `#89b4fa` (Blue) | Highlighted active pane border |
| **Inactive Pane Border** | `#313244` (Surface0) | Subtle, non-distracting split lines |
| **Right Status Info** | `#313244` / `#a6e3a1` | Formatted `YYYY-MM-DD │ HH:MM` and Hostname |
