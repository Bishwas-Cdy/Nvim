-- /* ---- 💫 Autocommands Configuration 💫 ---- */
-- Automatic commands for enhanced functionality

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ===============================================
-- GENERAL AUTOCOMMANDS
-- ===============================================

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Restore cursor position
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.fn.setpos(".", vim.fn.getpos("'\""))
      vim.cmd("silent! foldopen")
    end
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto-resize splits when Vim gets resized
autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

-- ===============================================
-- FILETYPE SPECIFIC AUTOCOMMANDS
-- ===============================================

-- Python specific settings
local python_group = augroup("PythonSettings", { clear = true })
autocmd("FileType", {
  pattern = "python",
  group = python_group,
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "88"  -- Black's line length
  end,
})

-- Web development settings (HTML, CSS, JS, React)
local web_group = augroup("WebDevSettings", { clear = true })
autocmd("FileType", {
  pattern = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },
  group = web_group,
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Java specific settings
local java_group = augroup("JavaSettings", { clear = true })
autocmd("FileType", {
  pattern = "java",
  group = java_group,
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "120"
  end,
})

-- Markdown settings
local markdown_group = augroup("MarkdownSettings", { clear = true })
autocmd("FileType", {
  pattern = "markdown",
  group = markdown_group,
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

-- ===============================================
-- LSP RELATED AUTOCOMMANDS
-- ===============================================

-- LSP attach autocommand (will be used in LSP config)
local lsp_group = augroup("LspAttach", { clear = true })
autocmd("LspAttach", {
  group = lsp_group,
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    
    -- LSP keymaps
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
    
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

-- ===============================================
-- BUFFER MANAGEMENT
-- ===============================================

-- Close some filetypes with <q>
autocmd("FileType", {
  pattern = {
    "qf", "help", "man", "lspinfo", "spectre_panel", "lir",
    "DressingSelect", "tsplayground", "Jaq"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- ===============================================
-- TERMINAL SETTINGS
-- ===============================================

-- Terminal settings
local term_group = augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
  group = term_group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- ===============================================
-- AI/ML SPECIFIC AUTOCOMMANDS
-- ===============================================

-- Jupyter notebook settings
local jupyter_group = augroup("JupyterSettings", { clear = true })
autocmd("FileType", {
  pattern = "python",
  group = jupyter_group,
  callback = function()
    -- Add jupyter-specific keymaps when in a .ipynb context
    if vim.fn.expand("%:e") == "ipynb" then
      vim.keymap.set("n", "<leader>jr", ":JupyterRunFile<CR>", { buffer = true, silent = true })
      vim.keymap.set("n", "<leader>jc", ":JupyterRunCurrentLine<CR>", { buffer = true, silent = true })
    end
  end,
})

-- ===============================================
-- PROJECT DETECTION
-- ===============================================

-- Auto-detect project type and set appropriate settings
local project_group = augroup("ProjectDetection", { clear = true })
autocmd("VimEnter", {
  group = project_group,
  callback = function()
    local cwd = vim.fn.getcwd()
    
    -- Check for Python project indicators
    if vim.fn.filereadable(cwd .. "/requirements.txt") == 1 or
       vim.fn.filereadable(cwd .. "/pyproject.toml") == 1 or
       vim.fn.filereadable(cwd .. "/setup.py") == 1 then
      vim.g.project_type = "python"
    end
    
    -- Check for Node.js project
    if vim.fn.filereadable(cwd .. "/package.json") == 1 then
      vim.g.project_type = "node"
    end
    
    -- Check for Java project
    if vim.fn.filereadable(cwd .. "/pom.xml") == 1 or
       vim.fn.filereadable(cwd .. "/build.gradle") == 1 then
      vim.g.project_type = "java"
    end
  end,
})
