-- /* ---- 💫 Mason Configuration 💫 ---- */
-- Package manager for LSP servers, formatters, and linters

require("mason").setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = {
    -- Python
    "pylsp",
    "pyright",
    
    -- Web Development
    "html",
    "cssls",
    "ts_ls",
    "emmet_ls",
    "jsonls",
    
    -- Java
    "jdtls",
    
    -- Other
    "lua_ls",
    "bashls",
    "yamlls",
    "dockerls",
  },
  automatic_installation = true,
})
