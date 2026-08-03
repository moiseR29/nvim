# Neovim configuration (moise)

Personal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

| Dependency | Version | Notes |
|---|---|---|
| Neovim | >= 0.12 (tested on 0.12.4) | Needs LuaJIT build |
| Git | >= 2.0 | Used by lazy.nvim to clone plugins |
| C compiler (gcc/clang) | any | Compiles tree-sitter parsers |
| tree-sitter CLI | >= 0.22 (tested on 0.26.9) | Required to generate parsers for go, javascript, markdown, bash, query, etc. |

### Installing the tree-sitter CLI per platform

The tree-sitter CLI is a **system dependency** (like git or gcc), it is not
installed by the config itself. The config only warns if it is missing.

- **Arch Linux**

  ```bash
  sudo pacman -S tree-sitter-cli
  ```

- **Ubuntu 24.04+**

  ```bash
  sudo apt install tree-sitter-cli
  ```

  On Ubuntu < 24.04 the package is not available; use the universal option.

- **Windows**

  ```powershell
  winget install tree-sitter
  ```

  Or the universal option.

- **Universal (needs Rust)**

  ```bash
  cargo install tree-sitter-cli
  ```

## Installation

```bash
# clone the repo (or symlink it) into your Neovim config directory
git clone <this-repo> ~/.config/nvim

# on Windows: clone into ~/AppData/Local/nvim

# open Neovim — lazy.nvim installs all plugins automatically
nvim
```

The first launch compiles all tree-sitter parsers and may take a couple of
minutes. Subsequent launches are fast.

## Plugins (from lazy-lock.json)

| Plugin | Version (commit) |
|---|---|
| lazy.nvim | `306a055` |
| snacks.nvim | `882c996` |
| lualine.nvim | `221ce6b` |
| bufferline.nvim | `655133c` |
| nvim-treesitter | `7b6cc89` |
| nvim-web-devicons | `2ae6958` |
| plenary.nvim | `74b06c6` |
| trouble.nvim | `bd67efe` |
| todo-comments.nvim | `31e3c38` |
| vim-tmux-navigator | `e41c431` |
| vim-visual-multi | `a6975e7` |
| vscode.nvim | `aa1102a` |

## What each plugin replaces (from the old config)

| Old plugin | New plugin(s) |
|---|---|
| alpha.nvim (dashboard) | snacks.nvim dashboard |
| nvim-tree.lua (file tree) | snacks.nvim explorer |
| telescope.nvim + file-browser + ui-select + fzf-native | snacks.nvim picker |
| toggleterm.nvim | snacks.nvim terminal |
| indent-blankline | snacks.nvim indent |
| dressing.nvim (input/select) | snacks.nvim input + picker.ui_select |
| lualine.nvim (statusline) | lualine.nvim (kept — snacks.statusline no longer exists) |

## Config layout

```
init.lua
lua/moise/
  lazy.lua                 lazy.nvim setup + plugin imports
  common/                  global options + keymaps
  utils/                   helpers
  plugins/
    extras/                plenary, tmux-navigator, visual-multi
    ui/                    snacks, lualine, colorscheme, treesitter, trouble
    config/snacks/         per-module snacks config (required from the spec,
                           never imported by lazy — see note below)
    ui-old/                previous config, kept as reference only
```

> **Note on `plugins/config/snacks/`**: lazy.nvim treats every file inside an
> *imported* directory as a plugin spec. The snacks config files live outside
> the plugin specs and are `require`d explicitly from
> `lua/moise/plugins/ui/snacks.lua`, so lazy never scans them.

## Main keymaps

| Key | Action |
|---|---|
| `<leader>m` / `<leader>e` | File explorer (sidebar) |
| `<leader>tm` | File explorer (centered, telescope-style) |
| `<C-t>` | Terminal toggle (also works from inside the terminal) |
| `<leader>tt` | Second terminal |
| `<C-p>` | Find files |
| `<C-f>` | Grep in cwd |
| `<leader>ff` / `fg` / `fr` / `fp` | Files / Git files / Recent / Projects |
| `<leader>sd` / `sD` / `sH` / `sM` / `sq` / `uC` | Diagnostics / Buffer diag / Highlights / Man / Quickfix / Colorschemes |
| `gd` / `gr` / `gD` / `gy` | LSP definition / references / declaration / type definition |

Inside the explorer (and any picker): `<CR>` opens, `<C-v>` opens in a
vertical split (right side), `<C-s>` horizontal split, `<C-t>` opens in a new tab.
