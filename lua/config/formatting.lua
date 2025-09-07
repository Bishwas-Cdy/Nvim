-- /* ---- 💫 Null-ls Configuration 💫 ---- */
-- Formatting and linting with null-ls

local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- ===============================================
    -- PYTHON FORMATTERS AND LINTERS
    -- ===============================================
    formatting.black.with({
      extra_args = { "--line-length", "88" },
    }),
    formatting.isort.with({
      extra_args = { "--profile", "black" },
    }),
    diagnostics.flake8.with({
      extra_args = { "--max-line-length", "88", "--ignore", "E203,W503" },
    }),
    diagnostics.mypy,
    
    -- ===============================================
    -- WEB DEVELOPMENT FORMATTERS
    -- ===============================================
    formatting.prettier.with({
      filetypes = {
        "javascript", "javascriptreact", "typescript", "typescriptreact",
        "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml",
        "markdown", "graphql", "handlebars",
      },
      extra_args = { "--single-quote", "--jsx-single-quote" },
    }),
    diagnostics.eslint.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml" })
      end,
    }),
    
    -- ===============================================
    -- JAVA FORMATTERS
    -- ===============================================
    formatting.google_java_format,
    
    -- ===============================================
    -- OTHER FORMATTERS AND LINTERS
    -- ===============================================
    formatting.stylua,  -- Lua formatter
    formatting.shfmt,   -- Shell script formatter
    diagnostics.shellcheck,  -- Shell script linter
    
    -- YAML
    formatting.yamlfmt,
    diagnostics.yamllint,
    
    -- Dockerfile
    diagnostics.hadolint,
    
    -- SQL
    formatting.sqlformat,
  },
  
  -- Format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(c)
              return c.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})

-- Augroup for formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
