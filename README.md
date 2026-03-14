# My Neovim Configuration

A comprehensive, modular Neovim setup configured as a Personal Development Environment (PDE) for Java, C/C++, Python, and Web Development. Built to replace VSCode, Netbeans, and even your file manager!

## 📁 Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── init.lua           # Config module loader
│   │   ├── lazy.lua           # Plugin manager bootstrap
│   │   ├── options.lua        # Vim options/settings
│   │   └── remap.lua          # Custom keymaps
│   └── plugins/
│       ├── treesitter.lua     # Syntax highlighting
│       ├── telescope.lua      # Fuzzy finder
│       ├── lsp.lua            # Language servers & diagnostics
│       ├── cmp.lua            # Autocompletion
│       ├── nvim-tree.lua      # File explorer
│       ├── lualine.lua        # Statusline
│       ├── dap.lua            # Debugging
│       ├── java.lua           # Java-specific config (nvim-jdtls)
│       ├── java-runners.lua   # Java run configurations
│       ├── web-dev.lua        # Live server & language runners
│       ├── which-key.lua      # Keybinding helper
│       └── misc.lua           # Quality of life plugins
└── README.md                   # This file
```

## ⚡ Quick Start

### Prerequisites

```bash
# Arch Linux
sudo pacman -S neovim git gcc nodejs npm python jdk-openjdk maven gradle tree-sitter

# Install live-server globally (for web dev)
mkdir -p ~/.local/share/npm-global
npm config set prefix ~/.local/share/npm-global
echo 'export PATH=~/.local/share/npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
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

## 🎹 Complete Keybindings Reference

### Leader Keys
- **Leader:** `Space`
- **Local Leader:** `\`

### General Navigation & Files

| Key | Action | Mode | Plugin |
|-----|--------|------|--------|
| `<leader>pv` | Open file explorer (Ex) | Normal | Built-in |
| `<C-n>` | Toggle file tree sidebar | Normal | nvim-tree |
| `<C-\>` | Toggle terminal | Normal | toggleterm |

### Find & Search (Telescope)

| Key | Action | Mode |
|-----|--------|------|
| `<leader>ff` | Find files | Normal |
| `<leader>fg` | Live grep (search text in files) | Normal |

### LSP (Code Intelligence)

| Key | Action | Mode | Description |
|-----|--------|------|-------------|
| `gd` | Go to definition | Normal | Jump to where symbol is defined |
| `gr` | Go to references | Normal | Find all usages of symbol |
| `K` | Hover documentation | Normal | Show docs for symbol under cursor |
| `<leader>cr` | Rename symbol | Normal | Refactor: rename across project |
| `<leader>ca` | Code actions | Normal | Quick fixes and refactorings |
| `<leader>f` | Format code | Normal | Auto-format current file |

### Diagnostics (Errors & Warnings)

| Key | Action | Mode | Description |
|-----|--------|------|-------------|
| `gl` | Show diagnostic float | Normal | **View full error/warning message** |
| `[d` | Previous diagnostic | Normal | Jump to previous error/warning |
| `]d` | Next diagnostic | Normal | Jump to next error/warning |
| `<leader>q` | Diagnostic quickfix list | Normal | List all errors/warnings in project |

**Visual Indicators:**
- `` in gutter = Error
- `` in gutter = Warning
- `` in gutter = Hint
- `` in gutter = Info
- Underlined text = Problem area
- Inline `●` = Brief error at end of line

### Debugging (nvim-dap)

| Key | Action | Mode |
|-----|--------|------|
| `<leader>db` | Toggle breakpoint | Normal |
| `<leader>dc` | Start/Continue debugging | Normal |
| `<leader>di` | Step into function | Normal |
| `<leader>do` | Step over line | Normal |
| `<leader>dO` | Step out of function | Normal |
| `<leader>dt` | Terminate debugging | Normal |
| `<leader>du` | Toggle debug UI | Normal |

### Java-Specific (nvim-jdtls)

| Key | Action | Mode |
|-----|--------|------|
| `<leader>jo` | Organize imports | Normal |
| `<leader>jv` | Extract variable | Normal/Visual |
| `<leader>jc` | Extract constant | Normal/Visual |
| `<leader>jm` | Extract method | Visual |
| `<leader>jc` | Compile all Java files | Normal |
| `<leader>jcd` | Compile Java with JDBC | Normal |

### Running Code

| Key | Action | Mode | Description |
|-----|--------|------|-------------|
| `<leader>rj` | Run Java | Normal | Compiles all `.java` files, runs current file's class |
| `<leader>rjd` | Run Java (JDBC) | Normal | Run with MySQL JDBC driver in classpath |
| `<leader>rjm` | Run specific Java main | Normal | Choose which main class to run |
| `<leader>rc` | Compile & run C | Normal | `gcc % -o %:r && ./%:r` |
| `<leader>rp` | Run Python | Normal | `python %` |
| `<leader>ls` | Toggle live server | Normal | Start/stop live server for web dev |

### Completion (Insert Mode)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion menu |
| `<Tab>` | Next completion item |
| `<S-Tab>` | Previous completion item |
| `<CR>` | Confirm selection |
| `<C-e>` | Abort completion |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |

### Commenting (Comment.nvim)

| Key | Action | Mode |
|-----|--------|------|
| `gcc` | Toggle line comment | Normal |
| `gc` | Toggle comment (motion) | Normal/Visual |
| `gbc` | Toggle block comment | Normal |
| `gb` | Toggle block comment (motion) | Normal/Visual |

**Examples:**
- `gcc` on a line → comments/uncomments it
- `gc3j` → comment next 3 lines
- Select lines in Visual mode → `gc` → comments selection

### Terminal

| Key | Action | Mode |
|-----|--------|------|
| `<C-\>` | Toggle horizontal terminal | Normal |
| `<leader>tf` | Float terminal | Normal |
| `<leader>th` | Horizontal terminal | Normal |

### Git (if lazygit installed)

| Key | Action | Mode |
|-----|--------|------|
| `<leader>gg` | Open LazyGit | Normal |

**GitSigns (in gutter):**
- Green bar = Added lines
- Blue bar = Changed lines
- Red bar = Deleted lines

### Which-Key Helper

| Key | Action |
|-----|--------|
| `<leader>` | Wait 1 second → see all available keybindings |
| `:WhichKey` | Show all keybindings |

Press `Space` and wait - a menu appears showing all your options!

## 📦 Plugins & What They Do

### Core Functionality

#### lazy.nvim
**Purpose:** Plugin manager  
**What it does:** Automatically installs, updates, and loads all your plugins  
**Commands:**
- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Update all plugins
- `:Lazy clean` - Remove unused plugins

#### nvim-treesitter
**Purpose:** Advanced syntax highlighting & code understanding  
**What it does:** 
- Provides accurate syntax highlighting for 100+ languages
- Enables smart text objects (select functions, classes, etc.)
- Powers indentation and folding
**Supported:** Lua, Java, C/C++, Python, JavaScript, HTML, CSS, Rust, and more

#### telescope.nvim
**Purpose:** Fuzzy finder  
**What it does:**
- Find files by name (`Space+ff`)
- Search text across all files (`Space+fg`)
- Fast, incremental search with preview
**Dependencies:** plenary.nvim (utility functions)

#### nvim-tree.lua
**Purpose:** File explorer sidebar  
**What it does:**
- Visual file tree like VSCode
- Create, delete, rename files/folders
- Toggle with `Ctrl+n`
**Keys inside tree:**
- `a` = create file
- `d` = delete
- `r` = rename
- `?` = help menu

### LSP & Completion

#### nvim-lspconfig
**Purpose:** LSP client configuration  
**What it does:**
- Connects to language servers for IDE features
- Provides autocomplete, go-to-definition, error checking
- Formats code, shows documentation

#### mason.nvim
**Purpose:** LSP server installer  
**What it does:**
- One-stop shop for installing language servers
- Also manages debuggers and formatters
**Usage:** `:Mason` → browse and install servers

#### mason-lspconfig.nvim
**Purpose:** Bridge between Mason and LSP  
**What it does:**
- Automatically installs LSP servers you specify
- Ensures servers are available before LSP starts

#### nvim-cmp
**Purpose:** Autocompletion engine  
**What it does:**
- Shows completion menu as you type
- Sources completions from LSP, snippets, buffer text, file paths
**Dependencies:**
- `cmp-nvim-lsp` - LSP completions
- `cmp-buffer` - Words from current buffer
- `cmp-path` - File path completions
- `LuaSnip` - Snippet engine
- `cmp_luasnip` - Snippet completions

### Debugging

#### nvim-dap
**Purpose:** Debug Adapter Protocol client  
**What it does:**
- Set breakpoints, step through code
- Inspect variables, call stack
- Works with multiple languages

#### nvim-dap-ui
**Purpose:** Visual debugging interface  
**What it does:**
- Shows variables, watches, call stack in panels
- Integrates with nvim-dap to provide VSCode-like debugging UI

#### nvim-dap-virtual-text
**Purpose:** Inline variable values  
**What it does:**
- Shows variable values next to code while debugging
- No need to hover or check panels

#### mason-nvim-dap
**Purpose:** Debug adapter installer  
**What it does:**
- Installs debuggers via Mason
- Currently configured: `codelldb` (C/C++), `java-debug-adapter`

### Language-Specific

#### nvim-jdtls
**Purpose:** Enhanced Java support  
**What it does:**
- Eclipse JDT Language Server integration
- Organize imports, extract methods/variables
- Better than basic LSP for Java projects
- Handles Maven/Gradle projects

### Quality of Life

#### nvim-autopairs
**Purpose:** Auto-close brackets and quotes  
**What it does:**
- Type `(` → automatically adds `)`
- Type `"` → automatically adds closing `"`
- Smart deletion: delete `(|)` → deletes both

#### Comment.nvim
**Purpose:** Easy commenting  
**What it does:**
- `gcc` to toggle line comment
- Works with any language
- Respects language-specific comment syntax

#### gitsigns.nvim
**Purpose:** Git integration  
**What it does:**
- Shows added/changed/deleted lines in gutter
- Inline git blame
- Stage/unstage hunks

#### lualine.nvim
**Purpose:** Statusline  
**What it does:**
- Shows mode, file name, git branch, diagnostics
- Beautiful, informative bottom bar
**Dependencies:** nvim-web-devicons (icons)

#### toggleterm.nvim
**Purpose:** Terminal integration  
**What it does:**
- Open terminals inside Neovim
- Multiple terminal modes (horizontal, vertical, float)
- Runs live-server, compilers, etc.

#### which-key.nvim
**Purpose:** Keybinding helper  
**What it does:**
- Press `Space` → wait → see menu of available keys
- Never forget your keybindings
- Self-documenting configuration

#### tokyonight.nvim
**Purpose:** Colorscheme  
**What it does:**
- Modern, beautiful color theme
- Good contrast, easy on eyes
**Variants:** night, storm, day, moon

## 🛠️ Language Support

### Java

#### Features
- Full LSP support (autocomplete, go-to-definition, refactoring)
- Eclipse JDT Language Server (nvim-jdtls)
- Organize imports, extract methods/variables/constants
- Maven/Gradle project support
- JDBC database development support
- Debugging with breakpoints, variable inspection

#### Running Java Programs

**Simple Console Application:**
```java
// Test.java
public class Test {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```
- **Run:** `Space+rj` (compiles all `.java` files, runs current class)
- **Or manually:** `:!javac % && java %:r`

**Multi-File Projects:**
```
my_project/
├── Main.java
├── Helper.java
└── Database.java
```
- Open `Main.java`
- Press `Space+rj`
- Compiles **all** `.java` files, runs `Main`

**GUI Application (Swing/JavaFX):**
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
- Run: `Space+rj`
- GUI window opens!

**JDBC Projects:**

See [JDBC Development Setup](#-jdbc-development-setup-optional) section below.

**Debugging Java:**
1. Open your Java file
2. Set breakpoint: `Space+db` on desired line
3. Compile with debug info: `:!javac -g %`
4. Start debugger: `Space+dc`
5. Step through: `Space+di` (into), `Space+do` (over)
6. Inspect variables in DAP UI

### C/C++

#### Features
- Clangd LSP for autocomplete and diagnostics
- CodeLLDB debugger integration
- Compile and run shortcuts
- Works with Makefiles and CMake

#### Running C Programs

**Simple Console Application:**
```c
// test.c
#include <stdio.h>

int main() {
    printf("Hello World\n");
    return 0;
}
```
- **Quick run:** `Space+rc` (compiles and runs)
- **Or manually:** `:!gcc % -o %:r && ./%:r`

**With Debugging Symbols:**
```bash
:!gcc -g % -o %:r
```

**Debugging C:**
1. Compile with `-g` flag
2. Set breakpoint: `Space+db`
3. Start debugger: `Space+dc`
4. Select executable when prompted
5. Step through code

**Multi-File C Projects:**
Use a Makefile:
```makefile
# Makefile
CC = gcc
CFLAGS = -Wall -g

all: program

program: main.o helper.o
	$(CC) $(CFLAGS) -o program main.o helper.o

clean:
	rm -f *.o program
```

Then: `:!make` to build, `./program` to run

### Python

#### Features
- Python LSP (install `pyright` via `:Mason`)
- Run scripts directly
- Supports virtual environments

#### Running Python

```python
# test.py
def main():
    print("Hello World")

if __name__ == "__main__":
    main()
```
- **Quick run:** `Space+rp`
- **Or manually:** `:!python %`

**With Arguments:**
```vim
:!python % arg1 arg2
```

**Using Virtual Environment:**
```bash
# Activate venv before opening nvim
source venv/bin/activate
nvim script.py
```

### Web Development (HTML/CSS/JavaScript)

#### Features
- HTML, CSS, TypeScript/JavaScript LSP
- ESLint integration
- Live server with auto-reload
- Format on save

#### Using Live Server

1. Create project structure:
```
my_website/
├── index.html
├── style.css
└── script.js
```

2. Open any file:
```bash
cd my_website
nvim index.html
```

3. Start live server: `Space+ls`
4. Browser opens at http://127.0.0.1:8080
5. Edit files - browser **auto-refreshes** on save!
6. Stop: `Space+ls` again

**Example HTML:**
```html
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

## 🗄️ JDBC Development Setup (Optional)

If you work with Java database applications, set up the JDBC helper script.

### Install JDBC Helper Script

Create the script:

```bash
nvim ~/.local/bin/jdbc-project
```

Paste this content:

```bash
#!/bin/bash

PROJECT_NAME=${1:-jdbc_project}
JDBC_JAR="$HOME/lib/mysql-connector-j-8.2.0.jar"

# Download MySQL connector if not exists
if [ ! -f "$JDBC_JAR" ]; then
    echo "Downloading MySQL JDBC driver..."
    mkdir -p "$HOME/lib"
    wget -O "$JDBC_JAR" https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.2.0/mysql-connector-j-8.2.0.jar
    echo "Driver downloaded to $HOME/lib/"
fi

# Create project structure
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Create GENERIC main Java file
cat > Main.java << 'JAVAEOF'
import java.sql.*;
import java.util.Scanner;

public class Main {
    // Database configuration - CHANGE THESE FOR YOUR PROJECT
    static String dbUrl = "jdbc:mysql://localhost:3306/";
    static String dbName = "testdb";  // Change to your database name
    static String username = "root";   // Change to your MySQL username
    static String password = "";       // Change to your MySQL password
    
    static Connection connection;
    static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        connectToDatabase();
        
        // Your code here
        System.out.println("Connected! Ready to work with database.");
        
        // Example: uncomment to test
        // runSampleQuery();
        
        closeConnection();
    }

    public static void connectToDatabase() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl + dbName, username, password);
            System.out.println("✅ Connected to database: " + dbName);
        } catch (Exception e) {
            System.err.println("❌ Connection failed: " + e.getMessage());
            System.exit(1);
        }
    }

    public static void runSampleQuery() {
        try {
            Statement stmt = connection.createStatement();
            // Example query - change to match your table
            ResultSet rs = stmt.executeQuery("SHOW TABLES");
            
            System.out.println("\nTables in database:");
            while (rs.next()) {
                System.out.println("- " + rs.getString(1));
            }
            
            stmt.close();
        } catch (SQLException e) {
            System.err.println("Query error: " + e.getMessage());
        }
    }

    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Connection closed.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing connection: " + e.getMessage());
        }
    }
}
JAVAEOF

# Create a run script
cat > run.sh << RUNEOF
#!/bin/bash
JDBC_JAR="$JDBC_JAR"

echo "🔨 Compiling..."
javac -cp "\$JDBC_JAR" *.java

if [ \$? -eq 0 ]; then
    echo "▶️  Running..."
    java -cp ".:\$JDBC_JAR" Main
else
    echo "❌ Compilation failed!"
    exit 1
fi
RUNEOF

chmod +x run.sh

# Create README for the project
cat > README.md << 'READMEEOF'
# JDBC Project

## Setup

1. **Configure your database** in `Main.java`:
   ```java
   static String dbName = "testdb";      // Your database name
   static String username = "root";       // Your MySQL username
   static String password = "";           // Your MySQL password
   ```

2. **Run the project**:
   ```bash
   ./run.sh
   ```
   
   Or in Neovim: `Space+rjd`

## Project Structure

- `Main.java` - Your main code file
- `run.sh` - Script to compile and run with JDBC classpath

## Adding More Classes

Create new `.java` files in this directory. They'll be compiled automatically.

Example:
```bash
touch DatabaseHelper.java
nvim DatabaseHelper.java
./run.sh  # Compiles all .java files
```

## Common MySQL Commands

```sql
-- Create database
CREATE DATABASE testdb;

-- Create sample table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Insert sample data
INSERT INTO users (name, email) VALUES ('John Doe', 'john@example.com');
```
READMEEOF

echo "✅ JDBC Project created: $PROJECT_NAME"
echo "📁 Location: $(pwd)"
echo ""
echo "📝 Next steps:"
echo "   1. Edit Main.java and set your database credentials"
echo "   2. Run with: ./run.sh"
echo "   3. Or open in Neovim: nvim Main.java (then Space+rjd to run)"
```

Make it executable:

```bash
chmod +x ~/.local/bin/jdbc-project
```

### Using JDBC Projects

**Create new project:**
```bash
jdbc-project my_database_app
cd my_database_app
```

**Configure database credentials in Main.java:**
```java
static String dbName = "your_database";
static String username = "your_username";  
static String password = "your_password";
```

**Run:**
- Terminal: `./run.sh`
- Neovim: `Space+rjd` (compiles and runs with JDBC classpath)

**Example JDBC code:**
```java
// After connecting in main()
try {
    Statement stmt = connection.createStatement();
    
    // INSERT
    stmt.execute("INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com')");
    
    // SELECT
    ResultSet rs = stmt.executeQuery("SELECT * FROM users");
    while (rs.next()) {
        System.out.println("User: " + rs.getString("name"));
    }
    
    stmt.close();
} catch (SQLException e) {
    e.printStackTrace();
}
```

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

Add to `ensure_installed`:
```lua
ensure_installed = {
    "lua_ls",
    "jdtls",
    "rust_analyzer",  -- Add your language
    -- ...
},
```

Add handler if special config needed:
```lua
handlers = {
    -- ... existing handlers
    
    ["rust_analyzer"] = function()
        require("lspconfig").rust_analyzer.setup({
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    cargo = { allFeatures = true },
                },
            },
        })
    end,
}
```

### Adding Run Commands

Edit `~/.config/nvim/lua/plugins/web-dev.lua` or create language-specific file:

```lua
-- Add new keymap for running your language
vim.keymap.set("n", "<leader>rr", ":split | term cargo run<CR>", { desc = "Run Rust" })
vim.keymap.set("n", "<leader>rg", ":split | term go run %<CR>", { desc = "Run Go" })
```

## 🐛 Debugging Setup

### Available Debuggers

Installed via Mason (`:Mason`):
- **codelldb** - C/C++/Rust
- **java-debug-adapter** - Java
- **debugpy** - Python (install if needed)

### Basic Debugging Workflow

1. **Set breakpoints:** Navigate to line, press `Space+db`
2. **Start debugging:** `Space+dc`
3. **Step through code:**
   - `Space+di` - Step into function
   - `Space+do` - Step over line
   - `Space+dO` - Step out of function
4. **View variables:** DAP UI shows variables automatically
5. **Continue execution:** `Space+dc`
6. **Stop debugging:** `Space+dt`

### Debugging Java

**Simple programs:**
```bash
# Compile with debug symbols
:!javac -g Main.java

# Set breakpoint (Space+db)
# Start debugger (Space+dc)
```

**Complex projects (Maven/Gradle):**

```bash
# Terminal 1 - Start Java in debug mode
mvn clean compile
java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 \
     -cp target/classes com.example.Main

# Neovim - Attach debugger
:lua require'dap'.continue()
```

The Java DAP configuration auto-connects to port 5005.

### Debugging C

```c
// test.c with bug
#include <stdio.h>

int main() {
    int x = 5;
    int y = 0;
    int result = x / y;  // Set breakpoint here!
    printf("%d\n", result);
    return 0;
}
```

Steps:
1. Compile: `:!gcc -g test.c -o test`
2. Set breakpoint on line 6: `Space+db`
3. Start debugger: `Space+dc`
4. When prompted, enter: `./test`
5. Step through, inspect variables

## 🎨 Customization

### Changing Colorscheme

Edit `~/.config/nvim/lua/plugins/misc.lua`:

```lua
-- Replace tokyonight with:
{
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme catppuccin-mocha]])
    end,
}
```

Popular alternatives:
- `folke/tokyonight.nvim` (current)
- `catppuccin/nvim`
- `rose-pine/neovim`
- `EdenEast/nightfox.nvim`
- `navarasu/onedark.nvim`

### Adding Custom Keymaps

Edit `~/.config/nvim/lua/config/remap.lua`:

```lua
-- Example: Quick save
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Example: Quick quit
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Example: Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear highlight" })
```

### Vim Options

Edit `~/.config/nvim/lua/config/options.lua` to change:

```lua
-- Tab width
vim.opt.tabstop = 2       -- 2 spaces per tab
vim.opt.shiftwidth = 2    -- 2 spaces for indentation

-- Disable relative numbers
vim.opt.relativenumber = false

-- Change scroll offset
vim.opt.scrolloff = 10    -- Keep 10 lines above/below cursor

-- Enable mouse
vim.opt.mouse = "a"

-- Undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
```

### Adding More Plugins

Create a new file in `lua/plugins/`:

```bash
nvim ~/.config/nvim/lua/plugins/my-plugin.lua
```

```lua
return {
    "author/plugin-name",
    config = function()
        require("plugin-name").setup({
            -- configuration
        })
    end,
}
```

Example - adding git blame:
```lua
return {
    "f-person/git-blame.nvim",
    config = function()
        vim.g.gitblame_enabled = 1
    end,
}
```

Restart Neovim → plugin auto-installs!

## 📚 Learning Resources

### Vim Motions
- `:Tutor` - Built-in Vim tutorial
- `vimtutor` - Command-line tutorial (run in terminal)
- https://vim-adventures.com - Gamified learning
- https://www.openvim.com - Interactive tutorial

### Neovim-Specific
- https://neovim.io/doc/user/ - Official docs
- `:help <topic>` - In-editor help (e.g., `:help lsp`, `:help telescope`)
- `:checkhealth` - Diagnose configuration issues

### Plugin Documentation
- `:Lazy` - View all plugins, press `?` for help
- `:Mason` - Manage LSP servers, debuggers, formatters
- Each plugin's GitHub README

### Essential Vim Commands

**Movement:**
- `h j k l` - Left, down, up, right
- `w` / `b` - Next/previous word
- `0` / `$` - Start/end of line
- `gg` / `G` - Top/bottom of file
- `%` - Jump to matching bracket

**Editing:**
- `i` - Insert before cursor
- `a` - Insert after cursor
- `o` - New line below
- `dd` - Delete line
- `yy` - Copy line
- `p` - Paste
- `u` - Undo
- `<C-r>` - Redo

**With Counts:**
- `5j` - Move down 5 lines
- `3dd` - Delete 3 lines
- `2yy` - Copy 2 lines

##
