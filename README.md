# 🚀 Neovim Configuration

A modern, feature-rich Neovim configuration built for productivity and development efficiency. This setup transforms Neovim into a powerful IDE-like experience with intelligent code completion, advanced navigation, and seamless workflow integration.

## ✨ Features

- 🎨 **Beautiful UI** - Tokyo Night theme with custom statusline and dashboard
- 🔍 **Fuzzy Finding** - Lightning-fast file and text search with Telescope
- 🧠 **Smart Code Intelligence** - Full LSP support with auto-completion, diagnostics, and navigation
- 🌳 **Advanced Syntax** - Treesitter-powered highlighting and text objects
- 🔧 **Auto Formatting** - Format-on-save with Prettier, Black, Stylua, and more
- 📁 **File Management** - Intuitive file explorer with git integration
- 🔀 **Git Workflow** - Seamless git operations with LazyGit and Gitsigns
- ⚡ **Performance** - Lazy-loaded plugins for instant startup
- 🎯 **Productivity** - Session management, quick navigation, and smart editing tools

## 📦 Plugin Ecosystem

### Core Framework
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager with lazy loading
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Essential Lua functions

### UI & Appearance
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** - Beautiful dark theme with custom colors
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Elegant statusline
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Tab-like buffer management
- **[alpha-nvim](https://github.com/goolord/alpha-nvim)** - Customizable startup screen
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indentation guides

### File Management & Navigation
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer with icons
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder for files, text, and more
- **[flash.nvim](https://github.com/folke/flash.nvim)** - Quick jump navigation

### Language Support & Intelligence
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP client configurations
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP server installer
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Auto-completion engine
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Advanced syntax highlighting
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine

### Code Quality & Formatting
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** - Code formatting
- **[nvim-lint](https://github.com/mfussenegger/nvim-lint)** - Linting integration
- **[trouble.nvim](https://github.com/folke/trouble.nvim)** - Diagnostics and quickfix lists

### Git Integration
- **[lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)** - LazyGit integration
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations and actions

### Productivity Tools
- **[auto-session](https://github.com/rmagatti/auto-session)** - Session management
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-close brackets
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** - Surround text objects
- **[substitute.nvim](https://github.com/gbprod/substitute.nvim)** - Enhanced text substitution
- **[todo-comments.nvim](https://github.com/folke/todo-comments.nvim)** - Highlight and navigate TODOs

## 🛠️ Language Support

### Fully Supported Languages
- **JavaScript/TypeScript** - Full LSP, formatting (Prettier), linting (ESLint)
- **Python** - Pyright LSP, formatting (Black + isort), linting (Pylint)
- **Lua** - Native support with Stylua formatting
- **HTML/CSS** - Complete web development stack
- **React/Vue/Svelte** - Modern framework support
- **JSON/YAML** - Configuration file support
- **Markdown** - Documentation writing

### Formatters & Linters
- **Prettier** - JavaScript, TypeScript, HTML, CSS, JSON, Markdown
- **Black + isort** - Python code formatting and import sorting
- **Stylua** - Lua code formatting
- **Pylint** - Python code analysis

## ⚡ Installation

### Prerequisites
- Neovim 0.9+ 
- Git
- A terminal with true color support
- A [Nerd Font](https://www.nerdfonts.com/) for icons

### Quick Setup
```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone https://github.com/Bishwas-Cdy/Nvim.git ~/.config/nvim

# Start Neovim - plugins will auto-install
nvim
```

### First Launch
1. Launch Neovim - Lazy.nvim will automatically install all plugins
2. Wait for installation to complete
3. Restart Neovim
4. Run `:checkhealth` to verify everything is working

## 🎯 Keybindings Reference

> **Leader Key**: `Space` - Your main command key for most shortcuts

### 🔤 Basic Editing
| Keybind | Description |
|---------|-------------|
| `jk` | Exit insert mode |
| `<leader>nh` | Clear search highlights |
| `<leader>+` | Increment number |
| `<leader>-` | Decrement number |

### 🪟 Window Management
| Keybind | Description |
|---------|-------------|
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<leader>sm` | Maximize/minimize split |

### 📑 Tab Management
| Keybind | Description |
|---------|-------------|
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Go to next tab |
| `<leader>tp` | Go to previous tab |
| `<leader>tf` | Open current file in new tab |

### 📁 File Explorer
| Keybind | Description |
|---------|-------------|
| `<leader>ee` | Toggle file explorer |
| `<leader>ef` | Find current file in explorer |
| `<leader>ec` | Collapse file explorer |
| `<leader>er` | Refresh file explorer |

### 🔍 Fuzzy Finding (Telescope)
| Keybind | Description |
|---------|-------------|
| `<leader>ff` | Find files |
| `<leader>fr` | Find recent files |
| `<leader>fs` | Find text in files |
| `<leader>fc` | Find word under cursor |
| `<leader>ft` | Find TODO comments |
| `<leader>fk` | Find keymaps |

**Inside Telescope:**
- `Ctrl+k/j` - Navigate results
- `Ctrl+q` - Send to quickfix
- `Ctrl+t` - Open in Trouble

### 🧠 Code Intelligence (LSP)
| Keybind | Description |
|---------|-------------|
| `gR` | Show references |
| `gD` | Go to declaration |
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Show documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |

### 🩺 Diagnostics
| Keybind | Description |
|---------|-------------|
| `<leader>D` | Show file diagnostics |
| `<leader>d` | Show line diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>rs` | Restart LSP |

### 📝 Code Completion
**Inside completion menu:**
- `Ctrl+k/j` - Navigate suggestions
- `Ctrl+b/f` - Scroll docs
- `Ctrl+Space` - Trigger completion
- `Ctrl+e` - Cancel
- `Enter` - Accept

### ⚡ Quick Navigation
| Keybind | Description |
|---------|-------------|
| `s` | Flash jump (2 chars) |
| `S` | Flash treesitter |
| `Ctrl+Space` | Expand selection |
| `Backspace` | Shrink selection |

### 🔧 Code Formatting
| Keybind | Description |
|---------|-------------|
| `<leader>mp` | Format file/selection |
| `<leader>l` | Run linter |

### 🔄 Text Substitution
| Keybind | Description |
|---------|-------------|
| `<leader>r` | Substitute with motion |
| `<leader>rr` | Substitute line |
| `<leader>R` | Substitute to end of line |

### 💾 Session Management
| Keybind | Description |
|---------|-------------|
| `<leader>wr` | Restore session |
| `<leader>ws` | Save session |

### 🌿 Git Integration
| Keybind | Description |
|---------|-------------|
| `<leader>lg` | Open LazyGit |
| `]h` / `[h` | Next/prev git hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff file |

### 📝 TODO Comments
| Keybind | Description |
|---------|-------------|
| `]t` / `[t` | Next/prev TODO |

### 🔧 Trouble (Diagnostics)
| Keybind | Description |
|---------|-------------|
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xt` | TODO list |

### 🌳 Treesitter Text Objects
**Selection (use with `d`, `c`, `y`, or in visual mode):**

| Text Object | Description |
|-------------|-------------|
| `af/if` | Function call (outer/inner) |
| `am/im` | Method/function definition |
| `ac/ic` | Class (outer/inner) |
| `ai/ii` | Conditional (outer/inner) |
| `al/il` | Loop (outer/inner) |
| `aa/ia` | Parameter/argument |

**Navigation:**
| Keybind | Description |
|---------|-------------|
| `]m/[m` | Next/prev function |
| `]c/[c` | Next/prev class |
| `]f/[f` | Next/prev function call |

**Code Manipulation:**
| Keybind | Description |
|---------|-------------|
| `<leader>na/pa` | Swap parameter next/prev |
| `<leader>nm/pm` | Swap function next/prev |

## 🚀 Performance

- **Startup Time**: ~50ms (with lazy loading)
- **Memory Usage**: Minimal footprint with on-demand plugin loading
- **Responsive**: Optimized for large codebases

## 🎨 Customization

The configuration is modular and easy to customize:

### File Structure
```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/bishwas/
│   ├── core/               # Core settings
│   │   ├── init.lua
│   │   ├── keymaps.lua     # Key mappings
│   │   └── options.lua     # Vim options
│   ├── plugins/            # Plugin configurations
│   │   ├── init.lua
│   │   ├── colorscheme.lua
│   │   ├── telescope.lua
│   │   └── ...
│   └── lazy.lua           # Plugin manager setup
└── lazy-lock.json         # Plugin versions
```

### Adding New Plugins
1. Create a new file in `lua/bishwas/plugins/`
2. Follow the lazy.nvim plugin spec
3. Restart Neovim

### Modifying Keybinds
Edit `lua/bishwas/core/keymaps.lua` or individual plugin files.

### Changing Colorscheme
Modify `lua/bishwas/plugins/colorscheme.lua`.

## 🤝 Contributing

Feel free to:
- Open issues for bugs or feature requests
- Submit pull requests for improvements  
- Share your customizations

## 📄 License

This configuration is open source and available under the MIT License.

## 🙏 Acknowledgments

This configuration is built upon the excellent work of the Neovim community and these amazing plugins. Special thanks to all the plugin maintainers who make modern Neovim possible.

---

**Enjoy coding with this powerful Neovim setup!** 🎉

For the complete keybinds reference, check out [KEYBINDS_REFERENCE.txt](./KEYBINDS_REFERENCE.txt) for detailed explanations of all 100+ shortcuts.