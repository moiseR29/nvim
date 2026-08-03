# Neovim Configuration (moise)

[Español](README.es.md)

A modern, fast Neovim configuration for day-to-day development: full LSP support,
snippet-powered completion, and a polished UI — all lazy-loaded.

Highlights:

- **Repo-aware linting & formatting** — linters and formatters only run when the
  project has a config file (`.eslintrc`, `.prettierrc`, `stylua.toml`, …). It
  never reformats or reflags a repo that didn't ask for it.
- **LSP-first** — [mason](https://github.com/williamboman/mason.nvim) installs
  servers and tools, `lspconfig` wires them up, `nvim-cmp` completes.
- **Snacks-based UI** — dashboard, file explorer and pickers all come from
  [snacks.nvim](https://github.com/folke/snacks.nvim) instead of five separate plugins.

## Quick start

```bash
# clone into your Neovim config directory
git clone <this-repo> ~/.config/nvim
# Windows: clone into ~/AppData/Local/nvim

# open Neovim — lazy.nvim installs every plugin on first launch
nvim
```

First launch compiles tree-sitter parsers and downloads LSP servers/tools via
mason; it can take a few minutes. Subsequent launches are fast.

If a server or tool is missing, re-run the installer:

```vim
:MasonToolsInstall
```

## Requirements

| Dependency | Version | Notes |
|---|---|---|
| Neovim | >= 0.12 (tested on 0.12.4) | LuaJIT build |
| Git | >= 2.0 | Used by lazy.nvim to clone plugins |
| C compiler (gcc/clang) | any | Compiles tree-sitter parsers and LuaSnip's jsregexp |
| tree-sitter CLI | >= 0.22 (tested on 0.26.9) | System dependency, see below |

### tree-sitter CLI

The tree-sitter CLI is a **system dependency** (like git or gcc) — the config
only warns if it is missing. Install it per platform:

- **Arch Linux** — `sudo pacman -S tree-sitter-cli`
- **Ubuntu 24.04+** — `sudo apt install tree-sitter-cli` (older Ubuntu: use cargo)
- **Windows** — `winget install tree-sitter` (or cargo)
- **Universal (needs Rust)** — `cargo install tree-sitter-cli`

### Language toolchains (for mason)

mason downloads LSP servers and tools using the toolchains below. Only install
the ones for the languages you work with — a missing toolchain fails silently
and just skips that tool.

| Toolchain | Used for |
|---|---|
| Node.js + npm | `ts_ls`, `prettier`, `eslint`, `pyright` |
| Go | `gopls`, `golangci-lint`, `stylua` |
| Python + pip | `black`, `pylint` |
| Terraform | `terraform` (fmt), `tflint` |

## LSP servers & tools

mason-tool-installer installs these automatically on first run:

**LSP servers:** `ts_ls` (TypeScript/JS), `gopls` (Go), `lua_ls` (Lua), `pyright`
(Python), `jsonls`, `yamlls`, `bashls`, `terraformls`, `dockerls`,
`docker_compose_language_service`.

**Formatters & linters:** `prettier`, `eslint`, `stylua`, `black`, `pylint`,
`golangci-lint`, `yamllint`, `tflint`.

## Linting & formatting — repo-aware

By design, automatic linting and formatting **respect the repository**: they run
only when the project declares a config file for that tool, so opening a foreign
repo never produces unwanted diffs or noise.

| Language | Config files that enable lint/format |
|---|---|
| JavaScript / TypeScript | `.eslintrc*`, `eslint.config.*`, `.prettierrc*`, `prettier.config.*`, `.editorconfig`, `tsconfig.json` |
| Lua | `stylua.toml` |
| Python | `pyproject.toml`, `setup.cfg`, `.pylintrc`, `Pipfile`, `pyrightconfig.json` |
| Go | `go.mod`, `.golangci.yml` |
| JSON / YAML | `.prettierrc*`, `.yamllint*` |

The config walks up the directory tree from your current file, so repo-root
configs are found from any subdirectory.

- **Lint on save** — none-ls updates diagnostics automatically (native LSP
  diagnostics, shown in trouble and the sign column).
- **Format on save** — none-ls formats on `BufWritePre` (only its own client,
  never the language server).
- **Manual format** — `<leader>mp` formats with none-ls anytime.

## Keymaps

### General

| Key | Action |
|---|---|
| `<leader>w` | Save file |
| `<leader>sr` | Vertical split |
| `<leader>sb` | Horizontal split |
| `<A-j>` / `<A-k>` | Move line down / up (normal, insert, visual) |
| Arrow keys | Resize window |

### Buffers & tabs

| Key | Action |
|---|---|
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<leader>bn` | New tab |
| `<leader>bw` | Close buffer |
| `<leader>h` / `<leader>l` | Previous / next tab |

### Files & explorer

| Key | Action |
|---|---|
| `<leader>m` | File explorer (sidebar) |
| `<leader>e` | File browser (centered) |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fp` | Projects |
| `<C-p>` | Find files (cwd) |

### Search

| Key | Action |
|---|---|
| `<leader>/` | Grep in cwd |
| `<leader>sg` | Grep |
| `<leader>sw` | Grep word / visual selection |
| `<leader>,` | Buffers picker |
| `<leader>:` | Command history |
| `<leader>n` | Notifications |

### Git

| Key | Action |
|---|---|
| `<leader>fg` | Git files |
| `<leader>gs` | Git status |
| `<leader>gl` / `<leader>gL` | Git log / log for line |
| `<leader>gb` | Branches |
| `<leader>gS` | Stash |
| `<leader>fgs` | Fugitive status |
| `<leader>gsp` / `gsn` / `gsr` | Hunk preview / next / reset |

### LSP

| Key | Action |
|---|---|
| `K` | Hover |
| `gd` / `gr` / `gD` / `gy` / `gI` | Definition / references / declaration / type def / implementation (picker) |
| `<leader>rn` | Rename |
| `<leader>vca` | Code actions (normal & visual) |
| `<leader>rs` | Restart LSP |

### Diagnostics

| Key | Action |
|---|---|
| `<leader>sd` | All diagnostics |
| `<leader>sD` | Buffer diagnostics |
| `<leader>vn` / `<leader>vp` | Next / previous diagnostic |

### Formatting & linting

| Key | Action |
|---|---|
| `<leader>mp` | Format file / range (none-ls) |
| `<leader>vf` | Format (LSP) |

### Terminal

| Key | Action |
|---|---|
| `<C-t>` | Toggle terminal (also from inside it) |
| `<leader>tt` | Second terminal |

### Misc

| Key | Action |
|---|---|
| `<leader>xt` | Todos (Trouble) |
| `<leader>uC` | Colorschemes |

Inside the explorer and any picker: `<CR>` opens, `<C-v>` vertical split (right
side), `<C-s>` horizontal split, `<C-t>` new tab.

## Plugins

### UI

| Plugin | Commit |
|---|---|
| lazy.nvim | `306a055` |
| snacks.nvim | `882c996` |
| lualine.nvim | `221ce6b` |
| bufferline.nvim | `655133c` |
| toggleterm.nvim | `50ea089` |
| nvim-web-devicons | `2ae6958` |
| vscode.nvim | `aa1102a` |
| plenary.nvim | `74b06c6` |

### Completion

| Plugin | Commit |
|---|---|
| nvim-cmp | `2ffe79f` |
| cmp-buffer | `b74fab3` |
| cmp-path | `c642487` |
| cmp-nvim-lua | `e3a22cb` |
| cmp-nvim-lsp | `cbc7b02` |
| cmp_luasnip | `98d9cb5` |
| LuaSnip | `642b0c5` |
| friendly-snippets | `6cd7280` |
| lspkind.nvim | `c7274c4` |
| nvim-autopairs | `7b9923a` |

### LSP & language tools

| Plugin | Commit |
|---|---|
| mason.nvim | `2a6940a` |
| mason-lspconfig.nvim | `67029cc` |
| mason-tool-installer.nvim | `443f1ef` |
| nvim-lspconfig | `1c0d8f7` |
| neodev.nvim | `46aa467` |
| lsp_signature.nvim | `b7ace9d` |
| none-ls.nvim | `01f8e62` |
| none-ls-extras.nvim | `9a8b8a9` |
| trouble.nvim | `bd67efe` |

### Editing

| Plugin | Commit |
|---|---|
| nvim-treesitter | `7b6cc89` |
| Comment.nvim | `e30b7f2` |
| vim-illuminate | `91313e5` |
| todo-comments.nvim | `31e3c38` |

### Git

| Plugin | Commit |
|---|---|
| vim-fugitive | `3b753cf` |
| gitsigns.nvim | `31d6fb2` |

### Extras

| Plugin | Commit |
|---|---|
| vim-tmux-navigator | `e41c431` |
| vim-visual-multi | `a6975e7` |

## Configuration structure

```
init.lua
lua/moise/
  lazy.lua                 lazy.nvim setup + plugin category imports
  common/                  global options + keymaps
  utils/                   helpers (incl. repo-aware lint/format detection)
  plugins/
    extras/                plenary, tmux-navigator, visual-multi
    git/                   vim-fugitive, gitsigns
    syntax/                nvim-autopairs, Comment, vim-illuminate, todo-comments
    cmp/                   nvim-cmp + sources, LuaSnip, lspkind, friendly-snippets
    lsp/                   mason, lspconfig, none-ls
    ui/                    snacks, lualine, bufferline, toggleterm, colorscheme, treesitter, trouble
    config/
      snacks/              per-module snacks options (required explicitly, never imported by lazy)
      lsp/                 per-server LSP settings (lua_ls, gopls, jsonls, yamlls)
```

> **Note on `plugins/config/snacks/`**: lazy.nvim treats every file inside an
> *imported* directory as a plugin spec. The snacks config files live outside
> the plugin specs and are `require`d explicitly from
> `lua/moise/plugins/ui/snacks.lua`, so lazy never scans them.
