# Configuración de Neovim (moise)

[English](README.md)

Una configuración moderna y rápida de Neovim para el desarrollo diario: soporte LSP completo, autocompletado con snippets y una interfaz pulida — todo con carga diferida (lazy).

Destacados:

- **Linting y formateo que respetan el repo** — los linters y formatters solo se ejecutan cuando el proyecto tiene un archivo de configuración (`.eslintrc`, `.prettierrc`, `stylua.toml`, …). Nunca reformatea ni marca un repo que no lo pidió.
- **LSP primero** — [mason](https://github.com/williamboman/mason.nvim) instala servidores y herramientas, `lspconfig` los configura y `nvim-cmp` completa.
- **UI basada en snacks** — dashboard, explorador de archivos y pickers vienen de [snacks.nvim](https://github.com/folke/snacks.nvim) en lugar de cinco plugins separados.

## Inicio rápido

```bash
# clona el repo en el directorio de configuración de Neovim
git clone <este-repo> ~/.config/nvim
# Windows: clona en ~/AppData/Local/nvim

# abre Neovim — lazy.nvim instala todos los plugins en el primer arranque
nvim
```

El primer arranque compila los parsers de tree-sitter y descarga los servidores y herramientas LSP vía mason; puede tardar unos minutos. Los arranques siguientes son rápidos.

Si falta un servidor o herramienta, vuelve a ejecutar el instalador:

```vim
:MasonToolsInstall
```

## Requisitos

| Dependencia | Versión | Notas |
|---|---|---|
| Neovim | >= 0.12 (probado en 0.12.4) | Build LuaJIT |
| Git | >= 2.0 | Lo usa lazy.nvim para clonar plugins |
| Compilador C (gcc/clang) | cualquiera | Compila los parsers de tree-sitter y el jsregexp de LuaSnip |
| CLI de tree-sitter | >= 0.22 (probado en 0.26.9) | Dependencia de sistema, ver abajo |

### CLI de tree-sitter

El CLI de tree-sitter es una **dependencia de sistema** (como git o gcc); la configuración solo avisa si falta. Instálalo por plataforma:

- **Arch Linux** — `sudo pacman -S tree-sitter-cli`
- **Ubuntu 24.04+** — `sudo apt install tree-sitter-cli` (Ubuntu anterior: usa cargo)
- **Windows** — `winget install tree-sitter` (o cargo)
- **Universal (requiere Rust)** — `cargo install tree-sitter-cli`

### Toolchains de lenguaje (para mason)

mason descarga los servidores y herramientas usando las toolchains de abajo. Instala solo las de los lenguajes que uses — si falta una toolchain, falla en silencio y simplemente omite esa herramienta.

| Toolchain | Se usa para |
|---|---|
| Node.js + npm | `ts_ls`, `prettier`, `eslint`, `pyright` |
| Go | `gopls`, `golangci-lint`, `stylua` |
| Python + pip | `black`, `pylint` |
| Terraform | `terraform` (fmt), `tflint` |

## Servidores y herramientas LSP

mason-tool-installer instala estos automáticamente en el primer arranque:

**Servidores LSP:** `ts_ls` (TypeScript/JS), `gopls` (Go), `lua_ls` (Lua), `pyright` (Python), `jsonls`, `yamlls`, `bashls`, `terraformls`, `dockerls`, `docker_compose_language_service`.

**Formatters y linters:** `prettier`, `eslint`, `stylua`, `black`, `pylint`, `golangci-lint`, `yamllint`, `tflint`.

## Linting y formateo — respeta el repo

Por diseño, el linting y el formateo automáticos **respetan el repositorio**: solo se ejecutan cuando el proyecto declara un archivo de configuración para esa herramienta, de modo que abrir un repo ajeno nunca produce diffs ni ruido no deseados.

| Lenguaje | Archivos de config que habilitan lint/format |
|---|---|
| JavaScript / TypeScript | `.eslintrc*`, `eslint.config.*`, `.prettierrc*`, `prettier.config.*`, `.editorconfig`, `tsconfig.json` |
| Lua | `stylua.toml` |
| Python | `pyproject.toml`, `setup.cfg`, `.pylintrc`, `Pipfile`, `pyrightconfig.json` |
| Go | `go.mod`, `.golangci.yml` |
| JSON / YAML | `.prettierrc*`, `.yamllint*` |

La búsqueda sube por el árbol de directorios desde el archivo actual, así que los configs de la raíz del repo se encuentran desde cualquier subdirectorio.

- **Lint al guardar** — none-ls actualiza los diagnósticos automáticamente
  (diagnósticos LSP nativos, visibles en trouble y en la columna de signos).
- **Format al guardar** — none-ls formatea en `BufWritePre` (solo su propio
  cliente, nunca el language server).
- **Format manual** — `<leader>mp` formatea con none-ls cuando quieras.

## Keymaps

### General

| Tecla | Acción |
|---|---|
| `<leader>w` | Guardar archivo |
| `<leader>sr` | Split vertical |
| `<leader>sb` | Split horizontal |
| `<A-j>` / `<A-k>` | Mover línea abajo / arriba (normal, insert, visual) |
| Flechas | Redimensionar ventana |

### Buffers y tabs

| Tecla | Acción |
|---|---|
| `<Tab>` / `<S-Tab>` | Siguiente / anterior buffer |
| `<leader>bn` | Tab nuevo |
| `<leader>bw` | Cerrar buffer |
| `<leader>h` / `<leader>l` | Tab anterior / siguiente |

### Archivos y explorador

| Tecla | Acción |
|---|---|
| `<leader>m` | Explorador de archivos (sidebar) |
| `<leader>e` | File browser (centrado) |
| `<leader>ff` | Buscar archivos |
| `<leader>fr` | Archivos recientes |
| `<leader>fp` | Proyectos |
| `<C-p>` | Buscar archivos (cwd) |

### Búsqueda

| Tecla | Acción |
|---|---|
| `<leader>/` | Grep en cwd |
| `<leader>sg` | Grep |
| `<leader>sw` | Grep palabra / selección visual |
| `<leader>,` | Picker de buffers |
| `<leader>:` | Historial de comandos |
| `<leader>n` | Notificaciones |

### Git

| Tecla | Acción |
|---|---|
| `<leader>fg` | Archivos git |
| `<leader>gs` | Estado de git |
| `<leader>gl` / `<leader>gL` | Git log / log de línea |
| `<leader>gb` | Ramas |
| `<leader>gS` | Stash |
| `<leader>fgs` | Estado de fugitive |
| `<leader>gsp` / `gsn` / `gsr` | Preview / siguiente / reset de hunk |

### LSP

| Tecla | Acción |
|---|---|
| `K` | Hover |
| `gd` / `gr` / `gD` / `gy` / `gI` | Definición / referencias / declaración / type def / implementación (picker) |
| `<leader>rn` | Renombrar |
| `<leader>vca` | Code actions (normal y visual) |
| `<leader>rs` | Reiniciar LSP |

### Diagnósticos

| Tecla | Acción |
|---|---|
| `<leader>sd` | Todos los diagnósticos |
| `<leader>sD` | Diagnósticos del buffer |
| `<leader>vn` / `<leader>vp` | Siguiente / anterior diagnóstico |

### Formateo y linting

| Tecla | Acción |
|---|---|
| `<leader>mp` | Formatear archivo / rango (none-ls) |
| `<leader>vf` | Formatear (LSP) |

### Terminal

| Tecla | Acción |
|---|---|
| `<C-t>` | Toggle terminal (también desde adentro) |
| `<leader>tt` | Segunda terminal |

### Otros

| Tecla | Acción |
|---|---|
| `<leader>xt` | Todos (Trouble) |
| `<leader>uC` | Colorschemes |

Dentro del explorador y cualquier picker: `<CR>` abre, `<C-v>` split vertical (lado derecho), `<C-s>` split horizontal, `<C-t>` tab nuevo.

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

### Autocompletado

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

### LSP y herramientas de lenguaje

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

### Edición

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

## Estructura de la configuración

```
init.lua
lua/moise/
  lazy.lua                 setup de lazy.nvim + imports de categorías
  common/                  opciones globales + keymaps
  utils/                   helpers (incl. detección repo-aware de lint/format)
  plugins/
    extras/                plenary, tmux-navigator, visual-multi
    git/                   vim-fugitive, gitsigns
    syntax/                nvim-autopairs, Comment, vim-illuminate, todo-comments
    cmp/                   nvim-cmp + sources, LuaSnip, lspkind, friendly-snippets
    lsp/                   mason, lspconfig, none-ls
    ui/                    snacks, lualine, bufferline, toggleterm, colorscheme, treesitter, trouble
    config/
      snacks/              opciones por módulo de snacks (required explícito, nunca importado por lazy)
      lsp/                 settings por servidor LSP (lua_ls, gopls, jsonls, yamlls)
```

> **Nota sobre `plugins/config/snacks/`**: lazy.nvim trata cada archivo dentro de un
> directorio *importado* como un spec de plugin. Los archivos de config de snacks viven
> fuera de los specs de plugins y se cargan con `require` explícito desde
> `lua/moise/plugins/ui/snacks.lua`, así lazy nunca los escanea.
