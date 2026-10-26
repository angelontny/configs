# Neovim Configuration

Documentation for the modern Lua-based Neovim configuration located at [`nvim/`](../nvim/) and symlinked to `~/.config/nvim/`.

---

## 📋 Architecture & Directory Structure

The configuration is built completely in Lua and organized modularly following modern Neovim best practices with [`lazy.nvim`](https://github.com/folke/lazy.nvim) as the package manager.

```text
nvim/
├── init.lua                   # Main entrypoint: sets mapleader (" ") and loads core config
└── lua/
    ├── config/
    │   ├── init.lua           # Sequentially requires options, keymaps, autocmds, and lazy
    │   ├── options.lua        # Editor options (indentation, line numbers, splits, search)
    │   ├── keymaps.lua        # General and navigation keybindings
    │   ├── autocmds.lua       # Auto-commands (highlight on yank, split resizing, cursor restore)
    │   └── lazy.lua           # Bootstraps lazy.nvim and imports plugin specifications
    └── plugins/
        ├── colorscheme.lua    # Tokyo Night theme (cohesive with tmux)
        ├── ui.lua             # Lualine statusline, devicons, which-key, and dressing.nvim
        ├── treesitter.lua     # AST syntax highlighting, incremental selection, and indentation
        ├── telescope.lua      # Telescope fuzzy finder (files, grep, buffers, config)
        ├── explorer.lua       # nvim-tree file explorer sidebar
        ├── lsp.lua            # Mason, Mason-lspconfig, and LSP configuration
        ├── completion.lua     # nvim-cmp autocompletion engine and luasnip
        ├── git.lua            # Gitsigns (gutter status, hunk preview, blame)
        ├── coding.lua         # Mini.pairs, mini.comment, mini.surround
        └── tmux.lua           # vim-tmux-navigator (seamless Ctrl-h/j/k/l with tmux)
```

---

## 🎨 Theme & Appearance

- **Colorscheme**: **Tokyo Night (`tokyonight-night`)**
  - Perfectly matches the Tokyo Night palette used in `tmux/tmux.conf` (`#1a1b26` bg, `#7aa2f7` blue, `#9ece6a` green, `#7dcfff` cyan).
  - Integrates natively with Treesitter, Telescope, GitSigns, NvimTree, and LSP diagnostics.
- **Statusline**: `lualine.nvim` with `tokyonight` theme displaying git branch, diffs, LSP diagnostics, relative file path, and line position.

---

## ⌨️ Keybindings Reference

Leader Key: **`<Space>`**

### File & Window Management

| Keybinding | Mode | Action |
|---|---|---|
| `<leader>w` | Normal | Save file (`:w`) |
| `<leader>q` | Normal | Quit window (`:q`) |
| `<leader>Q` | Normal | Force quit all without saving (`:qa!`) |
| `<leader>nh` / `<Esc>` | Normal | Clear search highlights |
| `<leader>sv` | Normal | Split window vertically |
| `<leader>sh` | Normal | Split window horizontally |
| `<leader>se` | Normal | Equalize split sizes |
| `<leader>sx` | Normal | Close current split |
| `<C-Up>` / `<C-Down>` | Normal | Resize window vertically |
| `<C-Left>` / `<C-Right>` | Normal | Resize window horizontally |

### Buffer Navigation

| Keybinding | Mode | Action |
|---|---|---|
| `<S-h>` or `[b` | Normal | Switch to previous buffer |
| `<S-l>` or `]b` | Normal | Switch to next buffer |
| `<leader>bd` | Normal | Delete / close current buffer |

### Tmux & Window Navigation

| Keybinding | Mode | Action |
|---|---|---|
| `<C-h>` | Normal | Navigate left (seamlessly hops into Tmux pane if at edge) |
| `<C-j>` | Normal | Navigate down (seamlessly hops into Tmux pane if at edge) |
| `<C-k>` | Normal | Navigate up (seamlessly hops into Tmux pane if at edge) |
| `<C-l>` | Normal | Navigate right (seamlessly hops into Tmux pane if at edge) |
| `<C-\>` | Normal | Switch to previous window/pane |

### Telescope (Fuzzy Finding)

| Keybinding | Action |
|---|---|
| `<leader>ff` | Find files in current workspace |
| `<leader>fg` | Live ripgrep search through files |
| `<leader>fb` | Search open buffers |
| `<leader>fr` | Search recent files |
| `<leader>fh` | Search help tags |
| `<leader>fc` | Search Neovim configuration files |

### File Explorer (`nvim-tree`)

| Keybinding | Action |
|---|---|
| `<leader>e` | Toggle file explorer sidebar |
| `<leader>ef` | Reveal active file in tree |

### Code Editing & Motions

| Keybinding | Mode | Action |
|---|---|---|
| `J` / `K` | Visual | Move selected lines down / up |
| `<` / `>` | Visual | Indent left / right (retains selection) |
| `p` | Visual | Paste without overwriting yank register |
| `<C-d>` / `<C-u>` | Normal | Scroll half-page down / up centered |
| `gcc` | Normal | Toggle line comment |
| `gc` | Visual | Toggle comment on selection |
| `sa<motion><char>` | Normal/Visual | Add surrounding pair (e.g. `saiw"` surrounds word with `"`) |
| `sd<char>` | Normal | Delete surrounding pair |
| `sr<old><new>` | Normal | Replace surrounding pair |

### Git Integration (`gitsigns`)

| Keybinding | Action |
|---|---|
| `]h` / `[h` | Jump to next / previous git hunk |
| `<leader>hp` | Preview hunk diff inline |
| `<leader>hs` | Stage current hunk |
| `<leader>hr` | Reset / discard current hunk |
| `<leader>hu` | Undo last staged hunk |
| `<leader>gb` | Git blame current line |
| `<leader>gd` | Diff current buffer against index |

### Language Server Protocol (LSP)

| Keybinding | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | List references |
| `gi` | Go to implementation |
| `K` | Show hover documentation |
| `<C-k>` | Show signature documentation |
| `<leader>rn` | Rename symbol across workspace |
| `<leader>ca` | Open code action menu |
| `<leader>cf` | Format current buffer |
| `[d` / `]d` | Jump to previous / next diagnostic |
| `<leader>d` | Show line diagnostic float |

---

## 📦 Language Servers & Mason

Language servers and formatters are managed automatically via `mason.nvim` and `mason-lspconfig.nvim`. Pre-configured servers include:

- `lua_ls`: Lua Language Server (configured for Neovim API globals and types)
- `pyright`: Python Language Server
- `bashls`: Bash / Shell Language Server
- `jsonls`: JSON Language Server

To manage or install additional servers interactively, run:
```vim
:Mason
```
To manage plugin updates:
```vim
:Lazy
```
