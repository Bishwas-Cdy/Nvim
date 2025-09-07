-- /* ---- 💫 Auto Import Configuration 💫 ---- */
-- Automatic imports for React, TypeScript, and other languages

return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    require("typescript-tools").setup({
      on_attach = function(client, bufnr)
        -- Enable auto-import
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        
        -- Key mappings for TypeScript specific actions
        local opts = { buffer = bufnr }
        
        vim.keymap.set("n", "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", opts)
        vim.keymap.set("n", "<leader>cs", "<cmd>TSToolsSortImports<cr>", opts)
        vim.keymap.set("n", "<leader>cu", "<cmd>TSToolsRemoveUnused<cr>", opts)
        vim.keymap.set("n", "<leader>ci", "<cmd>TSToolsAddMissingImports<cr>", opts)
        vim.keymap.set("n", "<leader>cf", "<cmd>TSToolsFixAll<cr>", opts)
        vim.keymap.set("n", "<leader>cg", "<cmd>TSToolsGoToSourceDefinition<cr>", opts)
        vim.keymap.set("n", "<leader>cr", "<cmd>TSToolsRenameFile<cr>", opts)
      end,
      
      settings = {
        tsserver_locale = "en",
        complete_function_calls = true,
        include_completions_with_insert_text = true,
        
        tsserver_plugins = {
          "@styled/typescript-styled-plugin",
        },
        
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = false,
        },
        
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        
        expose_as_code_action = {
          "fix_all",
          "add_missing_imports",
          "remove_unused",
          "organize_imports",
        },
        
        -- Auto-import settings
        preferences = {
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
          includeAutomaticOptionalChainCompletions = true,
        },
      },
    })
  end,
}
