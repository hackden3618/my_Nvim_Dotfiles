Refining my own workflow on nvim PDE (personal development environment)

# My Neovim Configuration

A modular Neovim setup configured as a Personal Development Environment (PDE) for Java, C/C++, Python, and Web Development.

## 📁 Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── init.lua        # Config module loader
│   │   ├── lazy.lua        # Plugin manager bootstrap
│   │   ├── options.lua     # Vim options/settings
│   │   └── remap.lua       # Custom keymaps
│   └── plugins/
│       ├── treesitter.lua  # Syntax highlighting
│       ├── telescope.lua   # Fuzzy finder
│       ├── lsp.lua         # Language servers
│       ├── cmp.lua         # Autocompletion
│       ├── nvim-tree.lua   # File explorer
│       ├── lualine.lua     # Statusline
│       ├── dap.lua         # Debugging
│       ├── java.lua        # Java-specific config
│       ├── web-dev.lua     # Live server & runners
│       └── misc.lua        # Quality of life plugins
└── README.md               # This file
```

## ⚡ Quick Start

### Prerequisites

```bash
# Arch Linux
sudo pacman -S neovim git gcc nodejs npm python jdk-openjdk maven gradle

# Install live-server globally
npm install -g live-server
```

### Installation

```bash
# Clone this config
git clone https://github.com/hackden3618/my_Nvim_Dotfiles.git ~/.config/nvim

# Launch Neovim (plugins will auto-install)
nvim

# Install LSP servers
:Mason
```

## 🎹 Keybindings

### Leader Key
- **Leader:** `Space`
- **Local Leader:** `\`

### General Navigation
| Key | Action | Mode |
|-----|--------|------|
| `<leader>pv` | Open file explorer (Ex) | Normal |
| `<C-n>` | Toggle file tree (nvim-tree) | Normal |
| `<leader>ff` | Find files (Telescope) | Normal |
| `<leader>fg` | Live grep (search in files) | Normal |
| `<C-\>` | Toggle terminal | Normal |

### LSP (Code Intelligence)
| Key | Action | Mode |
|-----|--------|------|
| `gd` | Go to definition | Normal |
| `gr` | Go to references | Normal |
| `K` | Hover documentation | Normal |
| `<leader>rn` | Rename symbol | Normal |
| `<leader>ca` | Code actions | Normal |
| `<leader>f` | Format code | Normal |

### Debugging (DAP)
| Key | Action | Mode |
|-----|--------|------|
| `<leader>db` | Toggle breakpoint | Normal |
| `<leader>dc` | Start/Continue debugging | Normal |
| `<leader>di` | Step into | Normal |
| `<leader>do` | Step over | Normal |
| `<leader>dO` | Step out | Normal |
| `<leader>dt` | Terminate debugging | Normal |
| `<leader>du` | Toggle debug UI | Normal |

### Java-Specific (nvim-jdtls)
| Key | Action | Mode |
|-----|--------|------|
| `<leader>jo` | Organize imports | Normal |
| `<leader>jv` | Extract variable | Normal/Visual |
| `<leader>jc` | Extract constant | Normal/Visual |
| `<leader>jm` | Extract method | Visual |

### Running Code
| Key | Action | Mode |
|-----|--------|------|
| `<leader>rj` | Run Java file | Normal |
| `<leader>rc` | Compile and run C | Normal |
| `<leader>rp` | Run Python | Normal |
| `<leader>ls` | Toggle live server (web dev) | Normal |

### Completion (Insert Mode)
| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<Tab>` | Next completion item |
| `<S-Tab>` | Previous completion item |
| `<CR>` | Confirm selection |
| `<C-e>` | Abort completion |

### Commenting (Comment.nvim)
| Key | Action | Mode |
|-----|--------|------|
| `gcc` | Toggle line comment | Normal |
| `gc` | Toggle comment (motion) | Normal/Visual |
| `gbc` | Toggle block comment | Normal |
| `gb` | Toggle block comment (motion) | Normal/Visual |

## 📦 Plugins

### Core Functionality
- **lazy.nvim** - Plugin manager
- **nvim-treesitter** - Syntax highlighting & parsing
- **telescope.nvim** - Fuzzy finder for files, text, etc.
- **nvim-tree.lua** - File explorer sidebar

### LSP & Completion
- **nvim-lspconfig** - LSP client configurations
- **mason.nvim** - LSP server installer
- **mason-lspconfig.nvim** - Bridge between Mason and LSP
- **nvim-cmp** - Autocompletion engine
- **cmp-nvim-lsp** - LSP completion source
- **LuaSnip** - Snippet engine

### Debugging
- **nvim-dap** - Debug Adapter Protocol client
- **nvim-dap-ui** - Debug UI
- **nvim-dap-virtual-text** - Inline variable values
- **mason-nvim-dap** - Debug adapter installer

### Language-Specific
- **nvim-jdtls** - Enhanced Java support (Eclipse JDT LS)

### Quality of Life
- **nvim-autopairs** - Auto-close brackets, quotes
- **Comment.nvim** - Easy commenting
- **gitsigns.nvim** - Git integration (signs, blame, etc.)
- **lualine.nvim** - Statusline
- **toggleterm.nvim** - Terminal integration
- **tokyonight.nvim** - Colorscheme

## 🛠️ Language Support

### Java

#### Features
- Full LSP support (autocomplete, go-to-definition, etc.)
- Organize imports, extract methods/variables
- Maven/Gradle project support
- Debugging with breakpoints

#### Running Java Programs

**Console Application:**
```java
// Test.java
public class Test {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```
- Quick run: `<leader>rj` (compiles and runs)
- Or manually: `:!javac % && java %:r`

**GUI Application (Swing):**
```java
// MyFrame.java
import javax.swing.*;

public class MyFrame extends JFrame {
    public MyFrame() {
        setTitle("My App");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);
    }

    public static void main(String[] args) {
        new MyFrame();
    }
}
```
- Run: `<leader>rj` or `:!javac % && java %:r`

**Debugging:**
1. Open your Java file
2. Set breakpoint: `<leader>db` on desired line
3. Compile with debug info: `:!javac -g %`
4. Start debugger: `<leader>dc`
5. Step through with `<leader>di`, `<leader>do`

### C/C++

#### Features
- Clangd LSP for autocomplete and diagnostics
- CodeLLDB debugger integration
- Compile and run shortcuts

#### Running C Programs

**Console Application:**
```c
// test.c
#include <stdio.h>

int main() {
    printf("Hello World\n");
    return 0;
}
```
- Quick run: `<leader>rc` (compiles and runs)
- Or manually: `:!gcc % -o %:r && ./%:r`

**With Debugging Symbols:**
```bash
:!gcc -g % -o %:r
```

**Debugging:**
1. Compile with `-g` flag
2. Set breakpoint: `<leader>db`
3. Start debugger: `<leader>dc`
4. Select executable when prompted

### Python

#### Features
- Python LSP (Pyright) for type checking
- Run scripts directly

#### Running Python

```python
# test.py
def main():
    print("Hello World")

if __name__ == "__main__":
    main()
```
- Quick run: `<leader>rp`
- Or manually: `:!python %`

### Web Development (HTML/CSS/JavaScript)

#### Features
- HTML, CSS, TypeScript LSP
- Live server with auto-reload
- ESLint integration

#### Using Live Server

1. Create an HTML file in your project
```html
<!-- index.html -->
<!DOCTYPE html>
<html>
<head>
    <title>My Page</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Hello World</h1>
    <script src="script.js"></script>
</body>
</html>
```

2. Start live server: `<leader>ls`
3. Browser opens automatically at http://127.0.0.1:8080
4. Edit files - browser auto-refreshes on save!
5. Stop: `<leader>ls` again

## 🔧 Adding Support for More Languages

### Via Mason

```vim
:Mason
```
Search for and install LSP servers for your language:
- `rust_analyzer` - Rust
- `gopls` - Go
- `tsserver` - TypeScript
- etc.

### Manual LSP Configuration

Edit `~/.config/nvim/lua/plugins/lsp.lua`:

```lua
-- Add to ensure_installed table
"rust_analyzer",  -- or any language server

-- Add configuration
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
```

### Adding Run Commands

Edit `~/.config/nvim/lua/plugins/web-dev.lua`:

```lua
-- Add new keymap
vim.keymap.set("n", "<leader>rr", ":split | term cargo run<CR>", { desc = "Run Rust" })
```

## 🐛 Debugging Setup

### Available Debuggers

Installed via Mason:
- **codelldb** - C/C++/Rust
- **java-debug-adapter** - Java
- **debugpy** - Python (install via Mason if needed)

### Basic Debugging Workflow

1. **Set breakpoints:** Navigate to line, press `<leader>db`
2. **Start debugging:** `<leader>dc`
3. **Step through code:**
   - `<leader>di` - Step into function
   - `<leader>do` - Step over line
   - `<leader>dO` - Step out of function
4. **View variables:** DAP UI shows variables automatically
5. **Continue execution:** `<leader>dc`
6. **Stop debugging:** `<leader>dt`

### Debugging Java

For complex Java projects (Maven/Gradle):

```bash
# Terminal 1 - Start Java in debug mode
mvn clean compile
java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -cp target/classes com.example.Main

# Neovim - Attach debugger
:lua require'dap'.continue()
```

The Java DAP configuration auto-connects to port 5005.

## 🎨 Customization

### Changing Colorscheme

Edit `~/.config/nvim/lua/plugins/misc.lua`:

```lua
-- Replace tokyonight with:
{
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        vim.cmd([[colorscheme catppuccin]])
    end,
}
```

### Adding Custom Keymaps

Edit `~/.config/nvim/lua/config/remap.lua`:

```lua
-- Example: Quick save
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
```

### Vim Options

Edit `~/.config/nvim/lua/config/options.lua` to change:
- Tab width
- Line numbers style
- Scroll behavior
- etc.

## 📚 Learning Resources

### Vim Motions
- `:Tutor` - Built-in Vim tutorial
- `vimtutor` - Command-line tutorial
- https://vim-adventures.com - Gamified learning

### Neovim-Specific
- https://neovim.io/doc/user/ - Official docs
- `:help <topic>` - In-editor help (e.g., `:help lsp`)

### Plugin Documentation
- `:Lazy` - View all plugins, press `?` for help
- `:Mason` - Manage LSP servers
- `:checkhealth` - Diagnose issues

## 🐞 Troubleshooting

### LSP Not Working
```vim
:LspInfo  " Check if LSP attached
:Mason    " Verify servers installed
:checkhealth lsp
```

### Treesitter Issues
```vim
:TSUpdate  " Update parsers
:checkhealth nvim-treesitter
```

### Plugin Issues
```vim
:Lazy sync  " Update all plugins
:Lazy clean " Remove unused plugins
```

### DAP Not Connecting
```vim
:checkhealth dap
```

Make sure debug adapters are installed in `:Mason`.

## 🤝 Contributing

Feel free to fork this config and customize it! If you add cool features, consider sharing them.

## 📄 License

This configuration is free to use and modify. Do whatever you want with it!

---

**Maintained by:** [@hackden3618](https://github.com/hackden3618)  
**Repo:** https://github.com/hackden3618/my_Nvim_Dotfiles
