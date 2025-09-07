-- /* ---- 💫 Core Options Configuration 💫 ---- */
-- Basic Neovim settings and options

local opt = vim.opt
local g = vim.g

-- Leader key
g.mapleader = " "
g.maplocalleader = " "

-- General settings
opt.mouse = "a"                    -- Enable mouse support
opt.clipboard = "unnamedplus"      -- Use system clipboard
opt.swapfile = false               -- Disable swap file
opt.backup = false                 -- Disable backup file
opt.undofile = true                -- Enable persistent undo
opt.writebackup = false            -- Disable backup before overwrite

-- UI settings
opt.number = true                  -- Show line numbers
opt.relativenumber = true          -- Show relative line numbers
opt.signcolumn = "yes"             -- Always show sign column
opt.wrap = false                   -- Disable line wrapping
opt.scrolloff = 8                  -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8              -- Keep 8 columns left/right of cursor
opt.cursorline = true              -- Highlight current line
opt.termguicolors = true           -- Enable 24-bit RGB color
opt.showmode = false               -- Don't show mode in command line
opt.cmdheight = 1                  -- Command line height
opt.pumheight = 10                 -- Popup menu height
opt.conceallevel = 0               -- Show concealed text

-- Indentation
opt.tabstop = 4                    -- Number of spaces for tab
opt.softtabstop = 4                -- Number of spaces for tab in insert mode
opt.shiftwidth = 4                 -- Number of spaces for auto indent
opt.expandtab = true               -- Convert tabs to spaces
opt.autoindent = true              -- Enable auto indent
opt.smartindent = true             -- Enable smart indent

-- Search settings
opt.hlsearch = true                -- Highlight search matches
opt.incsearch = true               -- Show search matches as you type
opt.ignorecase = true              -- Ignore case in search
opt.smartcase = true               -- Override ignorecase if uppercase used

-- Split windows
opt.splitbelow = true              -- Force horizontal splits below
opt.splitright = true              -- Force vertical splits right

-- File encoding
opt.fileencoding = "utf-8"         -- File encoding
opt.encoding = "utf-8"             -- String encoding

-- Performance
opt.updatetime = 300               -- Faster completion
opt.timeoutlen = 500               -- Time to wait for mapped sequence
opt.lazyredraw = false             -- Don't redraw during macros

-- Folding (using treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false             -- Don't fold by default

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Wildmenu
opt.wildmode = "longest:full,full"
opt.wildignore = {
  "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe",
  "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/*",
  "*/node_modules/*", "*/.DS_Store", "*/venv/*", "*/.venv/*"
}

-- Python provider (for AI/ML work)
g.python3_host_prog = vim.fn.exepath("python3")

-- Disable built-in plugins we don't need
local disabled_built_ins = {
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
  "2html_plugin", "logipat", "rrhelper", "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
