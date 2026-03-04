A full-featured Neovim setup built for **PHP**, **Java**, **C/C++**, **TypeScript/JavaScript**, and **Web Development** — with LSP completions, debugging, Git integration, and a clean UI.

---

## 📦 Plugin Manager

This config uses **[lazy.nvim](https://github.com/folke/lazy.nvim)** for plugin management.

- Run `:Lazy` to open the plugin dashboard
- Run `:Lazy sync` to install/update all plugins
- Run `:Lazy clean` to remove unused plugins

---

## 🗂️ File Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── init.lua            # Core config loader
│   │   ├── lazy.lua            # lazy.nvim bootstrap
│   │   ├── options.lua         # vim options (tabs, line numbers, etc.)
│   │   └── remap.lua           # Global keymaps
│   └── plugins/
│       ├── barbar.lua          # Buffer/tab bar
│       ├── catppuccin.lua      # Colorscheme
│       ├── cmp.lua             # Autocompletion engine
│       ├── comment.lua         # Smart commenting
│       ├── dap.lua             # Debugger (DAP)
│       ├── git.lua             # Git integration
│       ├── harpoon.lua         # File bookmarking
│       ├── java.lua            # Java LSP (jdtls)
│       ├── java-runners.lua    # Java compile/run keymaps
│       ├── lsp.lua             # All language servers (Mason)
│       ├── lualine.lua         # Status line
│       ├── luasnip.lua         # Snippet engine
│       ├── maven.lua           # Maven build keymaps
│       ├── misc.lua            # Autopairs
│       ├── nvim-tree.lua       # File explorer
│       ├── surround.lua        # Surround text objects
│       ├── telescope.lua       # Fuzzy finder
│       ├── treesitter.lua      # Syntax highlighting
│       ├── web-dev.lua         # Live server + HTML/CSS + runners
│       ├── which-key.lua       # Keymap hint popup
│       └── wilder.lua          # Enhanced command-line completion
```

---

## 🧠 Language Servers (LSP)

Managed via **Mason** (`lsp.lua`). Run `:Mason` to view installed servers.

| Language              | Server         | Notes                                |
|-----------------------|----------------|--------------------------------------|
| PHP                   | `intelephense` | Completions, hover, go-to-def        |
| PHP (HTML parts)      | `html`         | Tag/attribute completions inside PHP |
| PHP (abbreviations)   | `emmet_ls`     | `div.container` → full tag expansion |
| Java                  | `jdtls`        | Managed separately in `java.lua`     |
| C / C++               | `clangd`       |                                      |
| TypeScript/JavaScript | `ts_ls`        |                                      |
| HTML                  | `html`         |                                      |
| CSS / SCSS / LESS     | `cssls`        |                                      |
| Lua                   | `lua_ls`       |                                      |

### LSP Keymaps (active in any LSP buffer)

| Key           | Action                     |
|---------------|----------------------------|
| `gd`          | Go to definition           |
| `K`           | Hover documentation        |
| `gr`          | Find references            |
| `gl`          | Show diagnostics (float)   |
| `[d`          | Previous diagnostic        |
| `]d`          | Next diagnostic            |
| `<leader>cr`  | Rename symbol globally     |
| `<leader>ca`  | Code actions               |
| `<leader>cf`  | Format file                |
| `<leader>qd`  | Diagnostics list (loclist) |

---

## ✅ Autocompletion

Powered by **nvim-cmp** + **LuaSnip** (`cmp.lua`, `luasnip.lua`).

| Key          | Action                      |
|--------------|-----------------------------|
| `<C-Space>`  | Trigger completion manually |
| `<Tab>`      | Select next item            |
| `<S-Tab>`    | Select previous item        |
| `<CR>`       | Confirm selection           |
| `<C-e>`      | Abort completion            |
| `<C-b>`      | Scroll docs up              |
| `<C-f>`      | Scroll docs down            |

**Completion sources:** LSP → Snippets → Buffer words → File paths

---

## 🐛 Debugging (DAP)

Configured for **C/C++** (codelldb) and **Java** (java-debug-adapter) via `dap.lua`.

| Key           | Action            |
|---------------|-------------------|
| `<leader>db`  | Toggle breakpoint |
| `<leader>dc`  | Start / Continue  |
| `<leader>di`  | Step into         |
| `<leader>do`  | Step over         |
| `<leader>dO`  | Step out          |
| `<leader>dt`  | Terminate session |
| `<leader>du`  | Toggle DAP UI     |

---

## ☕ Java

Full Java IDE experience via `java.lua` (jdtls) and `java-runners.lua`.

### Runners

| Key           | Action                                     |
|---------------|--------------------------------------------|
| `<leader>rj`  | Compile & run (all `.java` in directory)   |
| `<leader>rjd` | Compile & run with JDBC (auto-detects JAR) |
| `<leader>rjm` | Run a specific main class (prompted)       |
| `<leader>rjp` | Run with package structure (`src/` layout) |
| `<leader>jC`  | Compile only (no run)                      |
| `<leader>jX`  | Clean `.class` files                       |

### JDTLS Refactoring

| Key           | Action                |
|---------------|-----------------------|
| `<leader>jo`  | Organize imports      |
| `<leader>jv`  | Extract variable      |
| `<leader>jc`  | Extract constant      |
| `<leader>jm`  | Extract method        |
| `<leader>jt`  | Test nearest method   |
| `<leader>jT`  | Test class            |
| `<leader>ju`  | Update project config |

### Maven

| Key           | Action              |
|---------------|---------------------|
| `<leader>mc`  | `mvn clean compile` |
| `<leader>mr`  | `mvn exec:java`     |
| `<leader>mt`  | `mvn test`          |
| `<leader>mp`  | `mvn package`       |
| `<leader>mC`  | `mvn clean`         |
| `<leader>mi`  | `mvn clean install` |

---

## 🌐 Web Development

### PHP Development

PHP files have **four layers of completion** working simultaneously:

- **`intelephense`** — PHP functions, variables, classes, constants
- **`html` LSP** — HTML tag names and attributes (`<div`, `class=`, `href=` etc.)
- **`emmet_ls`** — Emmet abbreviation expansion (`ul>li*5` → full list markup)
- **HTML snippets via LuaSnip** — `html:5` boilerplate, `div`, `a`, all common tags

PHP files need a proper HTML structure for browser-sync live reload to inject its script:

```php
<!DOCTYPE html>
<html>
<head><title>Page</title></head>
<body>
    <?php // your code here ?>
</body>
</html>
```

| Key            | Action                                      |
|----------------|---------------------------------------------|
| `<leader>rph`  | Run current PHP file via XAMPP's PHP binary |
| `<leader>ls`   | Start live-server for current directory     |

### XAMPP Virtual Host

Apache is configured to serve your project folder directly — no `sudo` needed to edit files.

```bash
# /etc/hosts entry
127.0.0.1   campus.test

# Access your project at:
# http://campus.test          → direct Apache (PHP executes)
# http://localhost:3000       → browser-sync proxy (live reload)
```

```bash
# Live reload alias — in ~/.zshrc
alias phpdev='browser-sync start --proxy "campus.test" \
  --files "/home/admin/Documents/Programming/Campus_Projects/..." \
  --reload-delay 500 --ws'
```

### Other runners

| Key           | Action          |
|---------------|-----------------|
| `<leader>rc`  | Compile & run C |
| `<leader>rp`  | Run Python      |

---

## 🔭 Telescope (Fuzzy Finder)

| Key           | Action                          |
|---------------|---------------------------------|
| `<leader>ff`  | Find files                      |
| `<leader>fg`  | Live grep (search inside files) |
| `<leader>fd`  | Find diagnostics                |
| `<leader>fr`  | Resume last search              |
| `<leader>f.`  | Recent files                    |
| `<leader>fb`  | Open buffers                    |

---

## 🗃️ Buffer Management (barbar)

| Key            | Action                     |
|----------------|----------------------------|
| `<leader>bh`   | Previous buffer            |
| `<leader>bl`   | Next buffer                |
| `<leader>b1-9` | Jump to buffer by position |
| `<leader>b0`   | Jump to last buffer        |
| `<leader>bc`   | Close buffer               |
| `<leader>bp`   | Pin buffer                 |
| `<leader>bb`   | Pick buffer (interactive)  |
| `<leader>bd`   | Pick & delete buffer       |
| `<leader>b<`   | Move buffer left           |
| `<leader>b>`   | Move buffer right          |

### Buffer sorting

| Key            | Action            |
|----------------|-------------------|
| `<leader>bsn`  | Sort by number    |
| `<leader>bsf`  | Sort by name      |
| `<leader>bsd`  | Sort by directory |
| `<leader>bsl`  | Sort by language  |
| `<leader>bsw`  | Sort by window    |

---

## 🌲 File Explorer (nvim-tree)

| Key      | Action           |
|----------|------------------|
| `<C-n>`  | Toggle file tree |

---

## 🐙 Git

| Key           | Action                  |
|---------------|-------------------------|
| `<leader>gh`  | Preview hunk (gitsigns) |
| `<leader>gb`  | Git blame (fugitive)    |
| `<leader>ga`  | Git add file            |
| `<leader>gA`  | Git add all             |
| `<leader>gc`  | Git commit              |
| `<leader>gP`  | Git push                |

---

## 🔖 Harpoon (Quick File Nav)

| Key     | Action                  |
|---------|-------------------------|
| `<S-m>` | Mark current file       |
| `<TAB>` | Open harpoon quick menu |

---

## ✂️ Surround

| Key  | Action                        |
|------|-------------------------------|
| `ys` | Add surrounding               |
| `cs` | Change surrounding            |
| `ds` | Delete surrounding            |
| `S`  | Add surrounding (visual mode) |

---

## 💬 Comments

| Key          | Action                            |
|--------------|-----------------------------------|
| `<leader>/`  | Toggle comment (normal or visual) |

---

## 🎨 UI & Theme

| Plugin         | Details                                          |
|----------------|--------------------------------------------------|
| **Catppuccin** | Mocha flavour, transparent background            |
| **lualine**    | Status line with auto theme                      |
| **barbar**     | Buffer tabs with git status and file icons       |
| **wilder**     | Fuzzy command-line completion for `:` `/` `?`    |
| **which-key**  | Popup showing available keymaps after `<leader>` |

---

## ⚡ Quick Reference Card

```
<leader> = Space

Navigation      gd=definition  K=hover  gr=refs  gl=float-diag
LSP             <leader>cr=rename  ca=actions  cf=format
Find            <leader>ff=files  fg=grep  fd=diag  fb=buffers
Run             <leader>rj=java  rc=C  rp=python  rph=PHP
Java            <leader>jC=compile  jX=clean  jo=imports
Maven           <leader>mc=compile  mr=run  mt=test
Git             <leader>gh=hunk  gb=blame  gc=commit  gP=push
Buffers         <leader>bh/bl=prev/next  bc=close  bb=pick
Debug           <leader>db=breakpoint  dc=continue  du=UI
Files           <C-n>=tree  <S-m>=harpoon-mark  <TAB>=harpoon-menu
Comment         <leader>/
```
